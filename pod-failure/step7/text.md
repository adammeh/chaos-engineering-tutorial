# Step 7: Clean Up

Once you’ve completed the chaos experiment, it’s important to clean up your resources.

```
kubectl delete namespace chaos-lab
```

This deletes the entire chaos-lab namespace and automatically removes all Pods, Deployments, Services, and other resources created for this tutorial.