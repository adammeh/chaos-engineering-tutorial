
A Service in Kubernetes acts as a stable network endpoint for a group of Pods.
- Pods can come and go, and each Pod gets its own dynamic IP.
- A Service ensures clients don’t need to know individual Pod IPs.
- The Service also load-balances requests across all available Pods.

Analogy:
- Pod = worker in a team.
- Service = receptionist forwarding requests to any available worker.

## Create a Service
```
kubectl expose deployment backend \
  --name=backend \
  --port=5678 \
  --target-port=5678
```{{copy}}

Command breakdown:
- `kubectl expose deployment backend`{{}} → Exposes the Deployment as a network-accessible Service.
- `--name=backend`{{}} → Names the Service backend.
- `--port=5678`{{}} → Port that clients will connect to.
- `--target-port=5678`{{}} → The port Pods are listening on.

## Verify the Service
```
kubectl get svc backend
```{{copy}}
Expected output:
```
NAME      TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
backend   ClusterIP   x.x.x.x        <none>        5678/TCP   10s
```

## Diagram
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