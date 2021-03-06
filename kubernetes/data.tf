// this file contains the data sources used in this project

// get gcloud authentication information
data "google_client_config" "default" {}


// get cluster endpoint from cloud storage
data "google_storage_bucket_object_content" "cluster_endpoint" {
  name   = "cluster-endpoint"
  bucket = "terraform-test-feras"
}

// get cluster certificate from cloud storage
data "google_storage_bucket_object_content" "cluster_cert" {
  name   = "cluster-cert"
  bucket = "terraform-test-feras"
}


// get the name of the sql instance database from a cloud storage bucket
data "google_storage_bucket_object_content" "db" {
  name   = "db"
  bucket = "terraform-test-feras"
}

// get the name of the sql instance from a cloud storage bucket
data "google_storage_bucket_object_content" "db_connection" {
  name   = "connection-name"
  bucket = "terraform-test-feras"
}

// get the name of the sql instance user from a cloud storage bucket
data "google_storage_bucket_object_content" "db_user" {
  name   = "db_user"
  bucket = "terraform-test-feras"
}

// get the name of the sql instance user password from a cloud storage bucket
data "google_storage_bucket_object_content" "db_pass" {
  name   = "db_pass"
  bucket = "terraform-test-feras"
}
