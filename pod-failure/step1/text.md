# Step 1: Create a Namespace for the Lab

Namespaces act like folders in Kubernetes. By creating a namespace called chaos-lab, we isolate all resources for this tutorial. This makes it easier to manage and, at the end, we can clean up everything with a single delete command.

```
kubectl create namespace chaos-lab
```{{copy}}

We can then set our kubectl default namespace to chaos-lab. By default, kubectl uses the default namespace if we don’t specify one.
```
kubectl config set-context --current --namespace=chaos-lab
```{{copy}}
This command essentially means: “Whenever I run kubectl commands, assume I mean inside chaos-lab.”