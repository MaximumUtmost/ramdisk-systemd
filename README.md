Ideally in /etc/fstab, mount a tmpfs /mnt/ramdisk at boot.
Here is my /etc/fstab line as an example: tmpfs, mounted at /mnt/ramdisk, 20GB, for uid 1000, gid 1000
tmpfs   /mnt/ramdisk   tmpfs   defaults,size=20G,mode=1777,uid=1000,gid=1000 0 0

sudo systemctl enable ramdisk-sync.service

Change the directories and filenames as you see fit.
Ensure your user has sufficient permissions to all relevant directories.
