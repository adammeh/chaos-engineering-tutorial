# Step 1: Create a Namespace for the Lab

Namespaces act like folders in Kubernetes. By creating a namespace called chaos-lab, we isolate all resources for this tutorial. This makes it easier to manage and, at the end, we can clean up everything with a single delete command.

```
kubectl create namespace chaos-lab
kubectl config set-context --current --namespace=chaos-lab
```