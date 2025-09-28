variable "IMAGE_NAME" {
  default = "argentinaluiz/docker-ci-test"
}

variable "TAGS" {
  default = ""
}

variable "CACHE_FROM" {
  default = null
}

variable "CACHE_TO" {
  default = null
}



group "default" {
    targets = [ "prod" ]
}

target "prod" {
    context = "./nestjs-project"
    dockerfile = "./Dockerfile.prod"
    #tags = split(",", TAGS)\
    secret = [ 
    {
      type = "env"
      id = "github_token"
    }
  ]
}

target "ci"  {
  context = "./nestjs-project"
  dockerfile = "./Dockerfile.prod"
  tags = [ "${IMAGE_NAME}:ci" ]
  target = "ci"
  secret = [ 
    {
      type = "env"
      id = "github_token"
    }
  ]
}