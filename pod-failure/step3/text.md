# Step 3: Expose the Backend with a Service


A Service groups Pods and provides a stable network endpoint. Even if individual Pods come and go, the Service ensures clients can always connect to the application without worrying about Pod IPs.

```
kubectl expose deployment backend --name=backend --port=5678 --target-port=5678
```

We can check the running services with:
```
kubectl get svc backend
```

```
                                       +--------+
                                -----> | Pod 1  |
+---------+        +----------+        +--------+
| Client  | -----> | Service  |
+---------+        +----------+        +--------+
                                -----> | Pod 2  |
                                       +--------+
```

This figure shows how a Service sits between the Client and multiple Pods, providing a stable network endpoint regardless of pod IPs.