terraform {
  backend "s3" {
    bucket = "cicd-terraform-jenkins-practice"
    key = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}

// why should n't we use variables here