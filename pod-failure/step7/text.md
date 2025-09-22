
Once you’ve completed the chaos experiment, it’s important to clean up your resources.

```
kubectl delete namespace chaos-lab
```{{copy}}

This deletes the entire chaos-lab namespace and automatically removes all Pods, Deployments, Services, and other resources created for this tutorial.


Or, if you’re feeling adventurous, try the special cleanup script:

```
chmod +x cleanup-chaos.sh
./cleanup-chaos.sh --yes
```{{copy}}

Hint: If you open the script with cat cleanup-chaos.sh, you might discover a hidden surprise…