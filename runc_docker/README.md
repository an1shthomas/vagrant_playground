### Rootless containers

Run the following commands as a normal user
```
mkdir ~/mycontainer
cd ~/mycontainer
mkdir rootfs
docker export $(docker create busybox) | tar -C rootfs -xvf -
runc spec --rootless
runc --root /tmp/runc run mycontainerid
```
