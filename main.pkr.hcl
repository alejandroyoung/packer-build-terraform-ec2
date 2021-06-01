source "amazon-ebs" "main" {
  #ami_name        = "${local.ami_name}-${var.jenkins_build_id}"
  ami_name        = "${local.ami_name}-${var.jenkins_build_id}-${local.timestamp}"
  ami_description = "${var.name}-${var.env}-${local.timestamp}"
  instance_type   = var.instance_type
  region          = var.region

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type    = "ebs"
      architecture        = "x86_64"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["137112412989"]
  }

  ssh_username  = "ec2-user"
  ssh_interface = "private_ip"
  ebs_optimized = true

  vpc_filter {
    filters = {
      "tag:Name" : "testing-DEMO-vpc"
    }
  }

  subnet_filter {
    random = true
    filters = {
      "tag:Name" : "testing-DEMO-public-subnet*"
    }
  }

  tags = {
    Name           = local.ami_name
    BuiltBy        = "Packer"
    App            = var.name
    AppVersion     = var.app_version
    Environment    = var.env
    SourceAMI      = "{{ .SourceAMIName }}"
    ManagedBy      = "Rackspace"
    JenkinsBuildID = var.jenkins_build_id
  }

}

build {
  sources = ["source.amazon-ebs.main"]

}
