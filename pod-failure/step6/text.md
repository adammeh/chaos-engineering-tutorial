# Step 6: Create Pod replica

So far, we’ve seen that deleting a single Pod can temporarily cause some requests to fail. To improve resilience, Kubernetes allows us to run multiple replicas of a Pod.

This ensures that if one Pod goes down, the Service can route traffic to other healthy Pods, thereby preventing downtime entirely.

First, close the curlpod by doing `Ctrl + C`{{}} and then running `exit`{{}}.

## Scale the backend deploymend
```
kubectl scale deployment backend --replicas=2
```{{copy}}
Command breakdown:
- `kubectl scale deployment backend`{{}} → Targets the backend Deployment.
- `--replicas=2`{{}} → Tells Kubernetes to maintain 2 running Pods for this Deployment.

Kubernetes will automatically create a second Pod identical to the first.

## Verify the new Pods
```
kubectl get pods -l app=backend
```{{copy}}
Expected output:
```
NAME                            READY   STATUS    RESTARTS   AGE
backend-xxxxx                    1/1    Running       0      Xs
backend-yyyyy                    1/1    Running       0      Xs
```
- Now there are 2 Pods serving the same backend.
- The Service will automatically load balance requests between them.

## Rerun the Curl client

```'kubectl run curlpod --rm -i --tty --image=curlimages/curl -- sh```{{copy}}
```while true; do curl http://backend.chaos-lab.svc.cluster.local:5678; sleep 1; done```{{copy}}

Then, in another terminal, delete a Pod at random:
```
POD=$(kubectl get pods -n chaos-lab -l app=backend -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | shuf -n 1)
kubectl delete pod $POD -n chaos-lab
```{{copy}}

What you’ll see:
- Requests continue returning "Hello from backend" without any failure, even though a Pod was deleted.
- Kubernetes reroutes traffic to the remaining healthy Pod while it recreates the deleted one.
