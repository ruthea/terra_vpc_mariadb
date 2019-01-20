#!/bin/bash -v
instancetype=$(curl http://169.254.169.254/latest/meta-data/instance-type)
echo "instance type is: " $instancetype
case $instancetype in
 "i3.large" | "i3.xlarge" | "i3.2xlarge" )
   mkdir -p /var/lib/mysql
   mkfs.ext4 -E nodiscard /dev/nvme0n1
   mount -o discard /dev/nvme0n1 /var/lib/mysql
   echo "/dev/nvme0n1 /var/lib/mysql ext4 defaults,nofail,discard 0 2" >> /etc/fstab
   mount -a
   ;;

 "i3.4xlarge" | "i3.8xlarge" | "i3.16xlarge" )
   mkdir -p /var/lib/mysql
   yum -y install mdadm
   mdadm --create --verbose /dev/md0 --level=stripe --raid-devices=2 /dev/nvme0n1 /dev/nvme1n1
   mkfs.ext4 -E nodiscard /dev/md0
   mount -o discard /dev/md0 /var/lib/mysql
   echo "/dev/md0 /var/lib/mysql ext4 defaults,nofail,discard 0 2" >> /etc/fstab
   mount -a
   ;;

 *)
   echo "other instance type - not attempting to mount any disks"
   ;;
esac
