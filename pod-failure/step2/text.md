# Step 2: Deploy a Backend Application

We deploy a simple backend using hashicorp/http-echo. This container listens on port 5678 and returns the text Hello from backend whenever it receives a request.

```
kubectl create deployment backend --image=hashicorp/http-echo --port=5678 -- /http-echo --text="Hello from backend"
```

We can see the created Pods by running:

```
kubectl get pods -l app=backend
```

Expected output:
```
NAME                            READY   STATUS    RESTARTS   AGE
backend-xxxxx                    1/1    Running       0      10s
```

If it doesn't say "1/1" under "READY" and "Running" under "STATUS", wait a bit and check again.
