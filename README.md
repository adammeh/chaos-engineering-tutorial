# Chaos Engineering with LitmusChaos: Pod Kill Experiment

In this tutorial, you will learn how to use **LitmusChaos** to inject failures into a Kubernetes cluster and observe how the system recovers.  
We will use a simple demo application, delete one of its Pods using a chaos experiment, and analyze the self-healing behavior.

---

## Learning Objectives

By the end of this tutorial, you will be able to:
1. Deploy a demo application in Kubernetes.
2. Install and configure LitmusChaos.
3. Run a **Pod-Delete Chaos Experiment** to simulate Pod failures.
4. Observe how Kubernetes automatically recovers from failure.
5. Analyze results and suggest improvements to system resilience.

---