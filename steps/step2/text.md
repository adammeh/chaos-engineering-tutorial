# Step 1: Environment Preparation

Verify Kubernetes cluster status and access permissions.

```
kubectl apply -f deployment.yaml
```

```
kubectl get pods -l app=hello-nginx
```

```
NAME                            READY   STATUS    RESTARTS   AGE
hello-nginx-xxxxx               1/1     Running   0          10s
hello-nginx-yyyyy               1/1     Running   0          10s
```