#!/usr/bin/env bash
set -euo pipefail

# =============== Config & Defaults ===============
NAMESPACE="chaos-lab"
KCTX=""
YES="false"
NOWAIT="false"
DELETE_OPERATOR="false"

# =============== Pretty Print ===============
bold() { printf "\033[1m%s\033[0m\n" "$*"; }
info() { printf "[INFO] %s\n" "$*"; }
warn() { printf "\033[33m[WARN]\033[0m %s\n" "$*"; }
err()  { printf "\033[31m[ERR ]\033[0m %s\n" "$*" >&2; }
ok()   { printf "\033[32m[ OK ]\033[0m %s\n" "$*"; }

usage() {
  cat <<EOF
Usage: $(basename "$0") [options]

Options:
  -n, --namespace <name>     Namespace to delete (default: chaos-lab)
  -c, --context <kubectx>    Kubernetes context to use
      --yes                  Skip confirmation prompt
      --no-wait              Do not wait for deletion to complete
      --delete-operator      Also uninstall Litmus operator/CRDs
  -h, --help                 Show this help

Examples:
  $(basename "$0")
  $(basename "$0") --yes -n chaos-demo
  $(basename "$0") --delete-operator --yes
EOF
}

# =============== Parse Args ===============
while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--namespace) NAMESPACE="$2"; shift 2;;
    -c|--context)   KCTX="$2"; shift 2;;
    --yes)          YES="true"; shift;;
    --no-wait)      NOWAIT="true"; shift;;
    --delete-operator) DELETE_OPERATOR="true"; shift;;
    -h|--help)      usage; exit 0;;
    *) err "Unknown option: $1"; usage; exit 1;;
  esac
done

# =============== Easter Egg (prints immediately) ===============
cat <<'EGG'
   ____ _                _        ____ _                          _     
  / ___| |__   ___  __ _| |_ ___ / ___| | ___  __ _ _ __ ___   __| |___ 
 | |   | '_ \ / _ \/ _` | __/ _ \ |   | |/ _ \/ _` | '_ ` _ \ / _` / __|
 | |___| | | |  __/ (_| | ||  __/ |___| |  __/ (_| | | | | | | (_| \__ \
  \____|_| |_|\___|\__,_|\__\___|\____|_|\___|\__,_|_| |_| |_|\__,_|___/
      🐣 You found the Chaos Easter Egg! Happy cleaning & safe chaos!
EGG

# =============== Preconditions ===============
# kubectl check
if ! command -v kubectl >/dev/null 2>&1; then
  err "kubectl not found. Please install kubectl first."
  exit 1
fi

KUBECTL=(kubectl)
if [[ -n "$KCTX" ]]; then
  KUBECTL+=(--context "$KCTX")
fi

# Show context/namespace summary
CTX_DISPLAY="$("${KUBECTL[@]}" config current-context || echo "<unknown>")"
bold "Cleanup plan:"
info "  Kube context : ${CTX_DISPLAY}"
info "  Namespace    : ${NAMESPACE}"
info "  Wait delete  : $([[ "$NOWAIT" == "true" ]] && echo "no" || echo "yes")"
info "  Delete operator/CRDs: ${DELETE_OPERATOR}"

# NS existence check
if ! "${KUBECTL[@]}" get ns "$NAMESPACE" >/dev/null 2>&1; then
  warn "Namespace '$NAMESPACE' does not exist or not accessible."
else
  ok "Namespace '$NAMESPACE' exists and will be deleted."
fi

# Confirmation
if [[ "$YES" != "true" ]]; then
  read -r -p "Proceed with cleanup? [y/N] " ans
  case "$ans" in
    y|Y|yes|YES) ;;
    *) warn "Aborted by user."; exit 0;;
  esac
fi

# =============== Delete Namespace ===============
if "${KUBECTL[@]}" get ns "$NAMESPACE" >/dev/null 2>&1; then
  if [[ "$NOWAIT" == "true" ]]; then
    info "Deleting namespace '$NAMESPACE' (no wait)..."
    "${KUBECTL[@]}" delete ns "$NAMESPACE" --ignore-not-found
  else
    info "Deleting namespace '$NAMESPACE' and waiting for completion..."
    "${KUBECTL[@]}" delete ns "$NAMESPACE" --ignore-not-found --wait=true --timeout=120s || {
      warn "Timed out waiting for namespace deletion. It may still be terminating."
    }
  fi
else
  warn "Skip: namespace '$NAMESPACE' not found."
fi

# =============== Optional: uninstall Litmus operator/CRDs ===============
if [[ "$DELETE_OPERATOR" == "true" ]]; then
  info "Uninstalling Litmus operator (best-effort)..."
  # Try common operator namespaces
  for ns in litmus litmuschaos; do
    if "${KUBECTL[@]}" get ns "$ns" >/dev/null 2>&1; then
      "${KUBECTL[@]}" delete ns "$ns" --ignore-not-found --wait=false || true
    fi
  done

  # Try removing CRDs (safe if absent)
  info "Deleting Litmus CRDs (chaosengines, chaosexperiments, chaosresults)..."
  "${KUBECTL[@]}" delete crd chaosengines.litmuschaos.io chaosexperiments.litmuschaos.io chaosresults.litmuschaos.io 2>/dev/null || true
fi

ok "Cleanup routine finished."
echo
bold "Tip:"
echo "  To see exactly what this script does in the tutorial, run:"
echo "    cat $(basename "$0")"
