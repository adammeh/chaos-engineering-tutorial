# Deploy an Easter egg Pod
kubectl create deployment chaos-egg \
  --image=hashicorp/http-echo \
  --port=5678 -- /http-echo --text="Hello Chaos!"