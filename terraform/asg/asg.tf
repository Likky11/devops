resource "aws_launch_template" "test-lt" {
  name = "test-lt"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_options {
    core_count       = 4
    threads_per_core = 2
  }
credit_specification {
    cpu_credits = "standard"
  }

  disable_api_stop        = true
  disable_api_termination = true

  ebs_optimized = true

  iam_instance_profile {
    name = "test"
  }
 image_id = "ami-0166fe664262f664c"
 instance_type = "t2.micro" 
  instance_initiated_shutdown_behavior = "terminate"


  

  key_name = "test"
metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
security_groups = ["sg-03f755c64f713e25e"]
associate_public_ip_address = true 

  }

  placement {
    availability_zone = "us-east-1"
  }
 
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  user_data = filebase64("${path.module}/example.sh")
}



resource "aws_autoscaling_group" "sample-asg" {
  desired_capacity     = 0
  max_size             = 0
  min_size             = 0
  vpc_zone_identifier  = ["subnet-09a3cbcd301a46ec1", "subnet-03c94dd92e353e98b"]
  launch_template {
    id      = aws_launch_template.test-lt.id 
    version = "$Latest"  # Use the latest version of the launch template
  }

  health_check_type          = "EC2"
  health_check_grace_period = 300
  force_delete               = true
}


