# Step 1: Environment Preparation

DELETE POD

```
kubectl get pods -l app=hello-nginx -w
```

```
kubectl delete pod -l app=hello-nginx --field-selector metadata.name=hello-nginx-xxxxx
```
(replace hello-nginx-xxxxx with the actual pod name)