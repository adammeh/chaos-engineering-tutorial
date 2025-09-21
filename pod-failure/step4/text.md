# Step 4: Generate Continuous Traffic


We start by running a temporary Pod with curl:

```
kubectl run curlpod --rm -i --tty --image=curlimages/curl -- sh
```

Then inside the shell, we run

```
while true; do curl http://backend.chaos-lab.svc.cluster.local:5678; sleep 1; done
```

This command continuously sends a request to the backend Service every second and prints the response. It simulates a client application making repeated calls, so we can observe what happens during failures.