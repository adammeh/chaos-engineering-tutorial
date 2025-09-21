# Step 5: Simulate Pod Failure

DELETE POD

In another terminal, first run:
```
kubectl get pods -l app=backend -w
```
This allows for the observation of the pods and what happens to them.


We then pick and delete one backend pod at random by running:
```
POD=$(kubectl get pods -n chaos-lab -l app=backend -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | shuf -n 1)
kubectl delete pod $POD -n chaos-lab
```

By deleting a Pod, we simulate a failure (just like chaos engineering). Watch the curl loop. You should see something that looks like this:
```
Hello from backend
curl: (7) Failed to connect to backend.default.svc.cluster.local port 5678 after 4 ms: Could not connect to server
Hello from backend
```
Since we delete the existing pod, when curl sends a request to the backend, it fails to connect. However, Kubernetes automatically spins up a new Pod to restore the deleted one which causes is why it returns to normal right after.

We can improve on this though.