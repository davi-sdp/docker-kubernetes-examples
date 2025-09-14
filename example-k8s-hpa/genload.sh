#kubectl run -it --rm --restart=Never busybox --image=busybox -- /bin/sh
# Inside busybox pod:
#while true; do wget -q -O- http://nginx-service; done

while true; do curl localhost; done
