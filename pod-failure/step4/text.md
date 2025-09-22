# Step 4: Generate Continuous Traffic

Now that we have a backend application running and exposed via a Service, we need to simulate real client traffic. This will allow us to observe what happens when a Pod fails.

We’ll do this by running a temporary Pod that continuously sends HTTP requests to the backend Service.

## Run a temporary curl Pod
```
kubectl run curlpod --rm -i --tty --image=curlimages/curl -- sh
```
Command breakdown:
- `kubectl run curlpod` → Creates a temporary Pod named curlpod.
- `-- sh` → Opens a shell inside the Pod.

## Continuously send requests to the backend
```
while true; do curl http://backend.chaos-lab.svc.cluster.local:5678; sleep 1; done
```

What you should see:
```
Hello from backend
Hello from backend
Hello from backend
...
```
Each line corresponds to a single request to the backend.