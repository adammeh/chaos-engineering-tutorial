# Step 3: Deploy a Backend Application


A Service groups Pods and provides a stable network endpoint. Even if individual Pods come and go, the Service ensures clients can always connect to the application without worrying about Pod IPs.

```
kubectl expose deployment backend --name=backend --port=5678 --target-port=5678
```

We can check the running services with:
```
kubectl get svc backend
```
