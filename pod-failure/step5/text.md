# Step 1: Environment Preparation

Pod status

```
kubectl get pods -n default -o wide
```

Optional: resource usage (if metrics-server available)

```
kubectl top pod -n default
```