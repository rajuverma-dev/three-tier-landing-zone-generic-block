variable "rgs" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags = optional(object({
      owner = string
      cost  = string
    }))

  }))
}
