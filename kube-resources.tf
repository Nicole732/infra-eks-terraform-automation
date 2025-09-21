#configure k8s provider and auth with aws cluster
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data) #get eks certificate and passes it to k8s certificate

  #generate a token for authentication from K8s 
  #uses aws authenticated user to connect to eks cluster
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

#create k8s resources
#create the namespace to deploy application
resource "kubernetes_namespace" "online-boutique" {
  metadata {
    name = "online-boutique"
  }

}