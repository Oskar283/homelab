
# Zigbee adapter not recognized.
Ensure that the user are in the dialout group

# Homeassistant with the storage on a NFS
## 1. Add NFS to /etc/fstab 1.
`<NFS_Server>:<Remote_Directory>  <Local_Mount_Point>  nfs  <options>  0  0`

Based on your NFS configuration (192.168.0.39:/mnt/homeassistant_config), and assuming you want to mount it to /mnt//homeassistant_config on your Raspberry Pi, add the following line:

```
192.168.0.39:/mnt/tank/set1/homeassistant_config  /mnt/homeassistant_config  nfs  defaults  0  0
```

    192.168.0.39:/mnt/tank/set1/homeassistant_config: This is the NFS server and the shared folder you want to mount.
    /mnt/homeassistant_config: This is the local directory where you want to mount the NFS share.
    nfs: This specifies that the file system type is NFS.
    defaults: This option sets default settings for the mount (read-write, no timeouts, etc.).
    0 0: These numbers are used for filesystem checks and backups. For NFS mounts, these are generally set to 0.

## 2. Ensure that the folder in fstab matches information in docker-compose


# Deploy updates from repo.

## 1. Mount NFS folder temp
sudo mkdir -p /mnt/nfs_share
sudo mount -t nfs 192.168.0.39:/mnt/tank/set1 ~/homelab/pi5/mount_config/

## 2. run: bash ./deploy.sh

## 3. unmount folder if needed
```
sudo umount ~/homelab/pi5/mount_config
```
