# Step 6: Create Pod replica

Close the curl Pod by running 'Ctrl + C'.

Now, if we create a replica of the backend pod with:
```
kubectl scale deployment backend --replicas=2
```
We can now ensure that we do not see any failure if one Pod goes down. If you now rerun, the curl pod and once again, send requests to the backend, then cause one of the pods to fail, you will see that the curl requests always return with "Hello from backend". This happens because if a Pod that is used by a Service in Kubernetes goes down, it will reroute the traffic to a healthy Pod if one exists.

```
kubectl run curlpod --rm -i --tty --image=curlimages/curl -- sh
while true; do curl http://backend.chaos-lab.svc.cluster.local:5678; sleep 1; done
```

```
POD=$(kubectl get pods -n chaos-lab -l app=backend -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | shuf -n 1)
kubectl delete pod $POD -n chaos-lab
```