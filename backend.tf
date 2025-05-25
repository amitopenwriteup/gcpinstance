terraform {
  backend "gcs" {
    bucket  = "name of bucket"
    prefix  = "student.01-instance-state"
  }
}
