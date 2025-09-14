kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml
kubectl apply -f nginx-hpa.yaml


#kubectl get hpa nginx-hpa
kubectl get hpa nginx-hpa --watch
#kubectl get deployment nginx-hpa