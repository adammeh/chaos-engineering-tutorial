# Step 5: Simulate Pod Failure

In this step, we’ll intentionally delete a backend Pod to simulate a failure. This is the core of chaos engineering: causing a controlled disruption to test system resilience.

## Observe the running Pods

Open a new terminal and run:
```
kubectl get pods -l app=backend -w
```
Command breakdown:
- `-l app=backend` → Filters for Pods created by the backend Deployment.
- `-w` → Watches the output in real-time, so you see Pods being added, deleted, or restarted.

This lets you monitor the Pods while you simulate the failure.

## Pick and delete a Pod at random
```
POD=$(kubectl get pods -n chaos-lab -l app=backend -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | shuf -n 1)
kubectl delete pod $POD -n chaos-lab
```
Command breakdown:
- `kubectl get pods ...` → Lists the names of all backend Pods.
- `tr ' ' '\n'` → Puts each Pod name on a separate line.
- `shuf -n 1` → Randomly selects one Pod.
- `kubectl delete pod $POD -n chaos-lab` → Deletes the selected Pod, simulating a failure.

## Observe the effect

Switch back to the `curlpod` terminal. You might see output like:
```
Hello from backend
curl: (7) Failed to connect to backend.chaos-lab.svc.cluster.local port 5678 after 4 ms: Could not connect to server
Hello from backend
```
What’s happening:
- When the Pod is deleted, the Service temporarily loses one of its endpoints.
- Some requests may fail while Kubernetes spins up a new Pod to replace the deleted one.
- Once the new Pod is ready, traffic resumes normally.

As seen from the example outcome, the failure happened after 4 ms. It could also be as extreme as 134268 ms:
```
curl: (28) Failed to connect to backend.chaos-lab.svc.cluster.local port 5678 after 134268 ms: Could not connect to server
```

The time taken to receive this "fail" message depends on when the curl request is made relative to when the Pod is deleted. If curl sends a request right after the pod is deleted, the connection is refused immediately since it already knows there are no endpoints. However, if curl sends a request right as the pod is being terminated, it may still try to forward the request to the “old” pod but since the pod is already gone or shutting down, the connection just hangs until it times out.

How can we mitigate this risk?