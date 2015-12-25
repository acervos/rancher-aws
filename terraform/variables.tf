variable "availability-zones" {
  description "Availability zones to use for the rancher master and nodes"
  default = [
    "eu-west-1a",
    "eu-west-1b",
    "eu-west-1c"
  ]
}

variable "rancher_master_min" {
  description "Minimum amount of rancher master nodes to run"
  default 1
}

variable "rancher_master_max" {
  description "Maximum amount of rancher master nodes to run"
  default 2
}

variable "rancher_master_healthcheck_grace_period" {
  description "Grace period before ELB starts chceking rancher nodes instances"
  default 600
}

variable "rancher_master_image_id" {
  description "The AMI for running the master rancher node"
  default "ami-9d6fb4ee"
}

variable "rancher_master_instance_type" {
  description "The image type for the master rancher node"
  default "t2.medium"
}
