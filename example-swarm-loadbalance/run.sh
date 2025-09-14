docker stack deploy -d -c stack.yml portal

#docker service scale portal_core=5
#docker service create --name=cluster-web -p80:80 --replicas=4 stenote/nginx-hostname
