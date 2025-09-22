## Introduction

Modern systems run in distributed environments like Kubernetes, where failures are inevitable: nodes crash, pods restart, and networks glitch. Chaos engineering is the practice of intentionally injecting failures in order to test and strengthen system resilience before real outages occur.

This is critical for DevOps because:
- It validates that automated recovery and self-healing mechanisms actually work.
- It increases confidence in deployments and continuous delivery.
- It ensures systems remain reliable under stress.

Kubernetes promises built-in resilience. This tutorial will demonstrate how to design, run, and analyze controlled failure experiments, specifically pod-failure experiments in Kubernetes.

### Learning Objectives

In this tutorial, you will learn how to:
1. Design a small chaos experiment in Kubernetes.
2. Inject pod-level failures in a controlled way.
3. Observe how the system behaves under failure.
4. Compare recovery with single vs multiple pod replicas.
5. Understand how Kubernetes self-healing contributes to reliability in DevOps.
