
#kubectl get all -n default

kubectl delete --all deployments --namespace=default
kubectl delete --all services --namespace=default
kubectl delete --all hpa --namespace=default
kubectl delete --all pods --namespace=default
