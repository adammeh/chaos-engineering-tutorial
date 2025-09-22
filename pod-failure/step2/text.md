# Step 2: Deploy a Backend Application

In this step, we’ll create a simple backend application that will act as our target service for the chaos experiment.

We’ll use the lightweight image ´hashicorp/http-echo´, which does two simple things:
- Listens on a port (5678 in our case).
- Returns a fixed response (Hello from backend) whenever it receives an HTTP request.

This makes it perfect for testing — no complex logic, just a predictable response we can monitor.

## What is a Pod?

A Pod is the smallest deployable unit in Kubernetes — basically, a single instance of an application.
- Each Pod usually contains one container (the hashicorp/http-echo app in our case).
- Pods can die, restart, or be replaced automatically.
- Pods are managed by Deployments, which ensure the desired number of replicas are always running.

## Deploy the backend with a Deployment
```
kubectl create deployment backend \
  --image=hashicorp/http-echo \
  --port=5678 -- /http-echo --text="Hello from backend"
```{{copy}}

What does this command do?
- `kubectl create deployment backend` Creates a Deployment called ´backend´. A Deployment ensures a desired number of Pods are always running, automatically restarting or replacing them if they fail.
- `--image=hashicorp/http-echo`{{}} Tells Kubernetes to run a simple, lightweight HTTP server.
- `--port=5678`{{}} Declares that the container listens on port 5678.
- `-- /http-echo --text="Hello from backend"`{{}} Passes startup arguments to the container, telling it to echo back the text "Hello from backend".

## Verify the Pod is running
```
kubectl get pods -l app=backend
```{{copy}}

Expected output:
```
NAME                            READY   STATUS    RESTARTS   AGE
backend-xxxxx                    1/1    Running       0      10s
```
If you see something like `ContainerCreating`{{}} or `Pending`{{}}, wait a few seconds and run the command again.
