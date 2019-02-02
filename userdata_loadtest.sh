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

yum install -y wget
wget -P /tmp https://downloads.sourceforge.net/project/hammerdb/HammerDB/HammerDB-3.1/HammerDB-3.1-Linux-x86-64-Install?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fhammerdb%2Ffiles%2FHammerDB%2FHammerDB-3.1%2FHammerDB-3.1-Linux-x86-64-Install%2Fdownload&ts=1549133620
chmod +x /tmp/HammerDB-3.1-Linux-x86-64-Install
./tmp/HammerDB-3.1-Linux-x86-64-Install --mode silent


#### The below gets sysbench installed
#yum install -y wget
#wget https://raw.githubusercontent.com/ruthea/standard_replication/master/sysbench_helper
#chmod +x sysbench_helper
#./sysbench_helper
