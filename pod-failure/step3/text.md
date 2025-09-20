# Step 1: Environment Preparation

Verify Kubernetes cluster status and access permissions.

```
kubectl create deployment frontend --image=nginx -n default
kubectl scale deployment frontend --replicas=2 -n default
kubectl label deployment frontend app=frontend -n default
```

```
kubectl get pods -n default
```
