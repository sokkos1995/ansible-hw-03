variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  default     = "b1g51e8snmd071om17j0"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  default     = "b1gkfhvrdn8er82j6v3s"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "ansible-hw03"
  description = "VPC network & subnet name"
}

variable "ssh_user" {
  type        = string
  default     = "ubuntu"
  description = "SSH user for VMs"
}

variable "ssh_private_key_path" {
  type        = string
  default     = "~/.ssh/id_ed25519"
  description = "Path to SSH private key (for output commands)"
}

variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = [
    {
      vm_name     = "vector-01"
      cpu         = 2
      ram         = 4
      disk_volume = 10
    },
    {
      vm_name     = "lighthouse-01"
      cpu         = 2
      ram         = 4
      disk_volume = 10
    },
    {
      vm_name     = "clickhouse-01"
      cpu         = 2
      ram         = 4
      disk_volume = 10
    },
  ]
}
