# Step 1: Environment Preparation

Verify Kubernetes cluster status and access permissions.

```
kubectl create deployment backend --image=hashicorp/http-echo --port=5678 -- /http-echo --text="Hello from backend"
```

```
kubectl get pods -n default
```

```
NAME                            READY   STATUS    RESTARTS   AGE
backend-xxxxx               1/1     Running   0          10s
backend-yyyyy               1/1     Running   0          10s
```

```
kubectl expose deployment backend --name=backend --port=5678 --target-port=5678
kubectl get svc backend
```

```
kubectl run curlpod --rm -i --tty --image=curlimages/curl -- sh
while true; do curl http://backend.default.svc.cluster.local:5678; sleep 1; done
```