terraform {
  backend "gcs" {
    bucket  = "terraformgcpow23"
    prefix  = "student.01-instance-state"
  }
}