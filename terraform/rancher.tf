provider "aws" {
    access_key = ""
    secret_key = ""
    region = "us-west-1"
}

resource "template_file" "rancher_master_user_data" {
  template "${file("rancher-master-user-data.tpl")}"

  vars {
    rancher_rds_instance_address  = ${aws_rds_instance.rancher_rds_instance.address}
    rancher_rds_instance_port     = ${aws_rds_instance.rancher_rds_instance.port}
    rancher_rds_database_name     = ${rancher_rds_database_name}
    rancher_rds_database_username = ${rancher_rds_database_username}
    rancher_rds_database_password = ${rancher_rds_database_password}
  }
}

resource "aws_autoscaling_group" "rancher_asg" {
  availability_zones = [${availability-zones}]
  name = "rancher_asg"
  min_size = ${rancher_master_min}
  max_size = ${rancher_master_max}
  health_check_grace_period = ${rancher_master_healthcheck_grace_period}
  health_check_type = "ELB"
  load_balancers = "${aws_loadbalancer.rancher_elb.name}"
  launch_configuration = "${aws_launch_configuration.rancher_launch_config.name}"

  tag {
    key = "Name"
    value = "rancher-server"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "rancher_launch_config" {
    name = "rancher_launch_config"
    image_id = "${rancher_master_image_id}"
    instance_type = "${rancher_master_instance_type}"
    security_groups = [
      ${aws_security_group.rancher_master_security_group.name},
      ${aws_security_group.rancher_rds_secuirty_group.name}
    ]
    iam_instance_profile = ${aws_iam_instance_profile.rancher_master_iam_instance_profile.name}
    user_data = ${template_file.rancher_master_user_data.rendered}
}
