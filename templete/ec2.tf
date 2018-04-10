
resource "aws_instance" "kong-api-gw" {
	ami = "${var.amis["kong-gw"]}"		//Amazon Linux
	instance_type = "${var.instance_type["kong-gw"]}"

	availability_zone = "${var.zones[0]}"

	subnet_id = "${aws_subnet.pri1.id}" 
	vpc_security_group_ids = ["${aws_security_group.sg-kong-api-gw.id}"]
	iam_instance_profile = "${aws_iam_instance_profile.ec2-role.name}"

	root_block_device = [
		{
		volume_size = "20"
		volume_type = "gp2"
		delete_on_termination = "true"
		}
	]

	key_name = "${var.tags["Service"]}-${var.stage}-kong-api-gw-keypair"
	disable_api_termination = true	//Termination protection	true=On
	monitoring = "true"

	tags {
		Name = "${var.tags["Service"]}-${var.stage}-asg-kong-api-gw"
		Service = "${var.tags["Service"]}"
		AutoStart = "False"
		AutoStop = "True"
		RI = "scheduled"
	}
}


resource "aws_instance" "kong-cassandra" {
	ami = "${var.amis["kong-db"]}"
	instance_type = "${var.instance_type["kong-db"]}"

	availability_zone = "${var.zones[0]}"

	subnet_id = "${aws_subnet.pri1.id}" 
	vpc_security_group_ids = ["${aws_security_group.sg-kong-cassandra.id}"]
	iam_instance_profile = "${aws_iam_instance_profile.ec2-role.name}"

	root_block_device = [
		{
		volume_size = "30"
		volume_type = "gp2"
		delete_on_termination = "true"
		}
	]

	key_name = "${var.tags["Service"]}-${var.stage}-kong-cassandra-keypair"
	disable_api_termination = true	//Termination protection	true=On
	monitoring = "true"

	tags {
		Name = "${var.tags["Service"]}-${var.stage}-kong-cassandra"
		Service = "${var.tags["Service"]}"
		AutoStart = "True"
		AutoStop = "True"
		RI = "scheduled"
	}
}


