
# Zigbee adapter not recognized.
Ensure that the user are in the dialout group

# () Homeassistant with the /var/lib/docker/ storage on a NFS
## 1. Add NFS to /etc/fstab 1.

Create folder
```
mkdir -p /mnt/pi5_var_lib_docker nfs
```

`<NFS_Server>:<Remote_Directory>  <Local_Mount_Point>  nfs  <options>  0  0`

```
192.168.0.39:/mnt/tank/set1/pi5_var_lib_docker /mnt/pi5_var_lib_docker nfs  defaults  0  0
192.168.0.39:/mnt/tank/set1/homeassistant_config_and_data /mnt/homeassistant_config_and_data nfs  defaults  0  0
```

    192.168.0.39:/mnt/tank/set1/pi5_var_lib_docker: This is the NFS server and the shared folder you want to mount.
    /mnt/pi5_var_lib_docker: This is the local directory where you want to mount the NFS share.
    nfs: This specifies that the file system type is NFS.
    defaults: This option sets default settings for the mount (read-write, no timeouts, etc.).
    0 0: These numbers are used for filesystem checks and backups. For NFS mounts, these are generally set to 0.


It should now always be there on boot. If it's not, boot will fail

## 2. add it to /etc/docker/daemon.json
```
{
    "data-root": "/mnt/pi5_var_lib_docker"
}
```

# Deploy updates from repo.

## 1. Mount NFS folder temp
sudo mount -t nfs 192.168.0.39:/mnt/tank/set1 ~/homelab/pi5/mount_config/

## 2. run: bash ./deploy.sh

## 3. unmount folder if needed
```
sudo umount ~/homelab/pi5/mount_config
```
