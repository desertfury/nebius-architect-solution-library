
module "kube" {
  source = "github.com/nebius/terraform-nb-kubernetes.git?ref=1.0.1"

  network_id = "btcci5d99ka84l988qvs" // change to correct

  master_locations = [
    {
      zone      = "eu-north1-c"
      subnet_id = "f8ut3srsmjrlor5uko84" // change to correct
    },

  ]

  master_maintenance_windows = [
    {
      day        = "monday"
      start_time = "20:00"
      duration   = "3h"
    }
  ]
  node_groups = {
    "k8s-ng-system" = {
      description = "Kubernetes nodes group 01 with fixed 1 size scaling"
      fixed_scale = {
        size = 2
      }
      nat = true
      node_labels = {
        "group" = "system"
      }
      # node_taints = ["CriticalAddonsOnly=true:NoSchedule"]
    }
    "k8s-ng-h100-8gpu1" = {
      description = "Kubernetes nodes h100-8-gpu nodes with autoscaling"
      auto_scale = {
        min     = 1
        max     = 3
        initial = 1
      }
      platform_id     = "gpu-h100"
      gpu_environment = "runc"
      node_cores      = 20 // change according to VM size
      node_memory     = 160 // change according to VM size
      node_gpus       = 1
      disk_type       = "network-ssd-nonreplicated"
      disk_size       = 372
      nat = true
      node_labels = {
        "group" = "h100-8gpu"
      }
    }
  }
}


