# Step 1: Environment Preparation

Verify Kubernetes cluster status and access permissions.

```
kubectl create deployment backend --image=hashicorp/http-echo -n default
kubectl scale deployment backend --replicas=2 -n default
kubectl label deployment backend app=backend -n default
```

```
kubectl get pods -l app=hello-nginx
```

```
NAME                            READY   STATUS    RESTARTS   AGE
hello-nginx-xxxxx               1/1     Running   0          10s
hello-nginx-yyyyy               1/1     Running   0          10s
```