# Define bastion server inside the public subnet
resource "aws_instance" "bastion" {
   ami  = "${var.ami}"
   instance_type = "${var.bastioninstancetype}"
   private_ip = "10.0.1.5"
   key_name = "${var.keyname}"
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
   associate_public_ip_address = true
   source_dest_check = false
  # Copies the myapp.conf file to /etc/myapp.conf
   provisioner "file" {
     source      = "${var.keypath}"
     destination = "/tmp/${var.keyname}.pem"
     connection {
      user     = "ec2-user"
      private_key = "${file("~/Downloads/test.pem")}"
     }
   }
    user_data = "${file("userdata.sh")}"
  tags {
    Name = "bastion"
  }
}

# Define instance for maxscale
resource "aws_instance" "max1" {
   ami  = "${var.ami}"
   instance_type = "${var.maxscaleinstancetype}"
   user_data = "${file("userdata_maxscale.sh")}"
   private_ip = "10.0.2.20"
   key_name = "${var.keyname}"
   subnet_id = "${aws_subnet.private-subnet1.id}"
   vpc_security_group_ids = ["${aws_security_group.sgdb.id}"]
   source_dest_check = false

  tags {
    Name = "maxscale1"
  }
}

# Define instance for maxscale #2
resource "aws_instance" "max2" {
   count = "${var.deploy_maxscale2 ? 1 : 0}"
   ami  = "${var.ami}"
   instance_type = "${var.maxscaleinstancetype}"
   user_data = "${file("userdata_maxscale.sh")}"
   private_ip = "10.0.3.20"
   key_name = "${var.keyname}"
   subnet_id = "${aws_subnet.private-subnet2.id}"
   vpc_security_group_ids = ["${aws_security_group.sgdb.id}"]
   source_dest_check = false

  tags {
    Name = "maxscale2"
  }
}

# Define instance for loadtesting
resource "aws_instance" "loadtest" {
   count = "${var.deploy_loadtest ? 1 : 0}"
   ami = "${var.ami}"
   instance_type = "${var.loadtestinstancetype}"
   user_data = "${file("userdata_loadtest.sh")}"
   private_ip = "10.0.2.30"
   key_name = "${var.keyname}"
   subnet_id = "${aws_subnet.private-subnet1.id}"
   vpc_security_group_ids = ["${aws_security_group.sgdb.id}"]
   source_dest_check = false
   tags {
    Name = "loadtest"
   }
}
# Define database inside the private subnet
resource "aws_instance" "db1" {
   ami  = "${var.ami}"
   instance_type = "${var.dbinstancetype}"
   user_data = "${file("userdata_database.sh")}"
   private_ip = "10.0.2.10"
   key_name = "${var.keyname}"
   subnet_id = "${aws_subnet.private-subnet1.id}"
   vpc_security_group_ids = ["${aws_security_group.sgdb.id}"]
   source_dest_check = false

  tags {
    Name = "database1"
  }
}

# Define database inside the private subnet
resource "aws_instance" "db2" {
   ami  = "${var.ami}"
   instance_type = "${var.dbinstancetype}"
   user_data = "${file("userdata_database.sh")}"
   private_ip = "10.0.3.10"
   key_name = "${var.keyname}"
   subnet_id = "${aws_subnet.private-subnet2.id}"
   vpc_security_group_ids = ["${aws_security_group.sgdb.id}"]
   source_dest_check = false

  tags {
    Name = "database2"
  }
}

# Define database inside the private subnet
resource "aws_instance" "db3" {
   ami  = "${var.ami}"
   instance_type = "${var.dbinstancetype}"
   user_data = "${file("userdata_database.sh")}"
   private_ip = "10.0.4.10"
   key_name = "${var.keyname}"
   subnet_id = "${aws_subnet.private-subnet3.id}"
   vpc_security_group_ids = ["${aws_security_group.sgdb.id}"]
   source_dest_check = false

  tags {
    Name = "database3"
  }
}

