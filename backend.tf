terraform {
  backend "gcs" {
    credentials = "location of json file"
    bucket  = "name of bucket"
    prefix  = "student.01-instance-state"
  }
}
