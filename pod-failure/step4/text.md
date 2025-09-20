# Step 1: Environment Preparation

DELETE POD

```
# Pick one random pod from all apps
POD=$(kubectl get pods -n default -l 'app in (frontend,backend)' -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | shuf -n 1)

# Delete the pod (simulate failure)
kubectl delete pod $POD -n default

echo "Chaos triggered! Pod $POD deleted. Watch self-healing"
```