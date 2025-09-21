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

# k8s role for dev
resource "kubernetes_role" "namespace-viewer" {
  metadata {
    name      = "namespace-viewer"
    namespace = "online-boutique"
  }

  rule {
    api_groups     = [""]
    resources      = ["pods", "services", "secrets", "configmap", "persistentVolumes"]
    resource_names = ["foo"]
    verbs          = ["get", "list", "watch", "describe"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "daemonsets", "statefulsets"]
    verbs      = ["get", "list", "watch", "describe"]
  }
}
#rolebinding for dev
resource "kubernetes_role_binding" "namespace-viewer" {
  metadata {
    name      = "namespace-viewer"
    #namespace = "online-boutique"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "cluster-admin"
  }
  subject {
    kind      = "User"
    name      = "developer"
    api_group = "rbac.authorization.k8s.io"
  }
}

#k8s cluster-role for admin user
resource "kubernetes_cluster_role" "cluster-viewer" {
  metadata {
    name = "cluster-viewer"
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["get", "list", "watch", "describe"]
  }
}
#clusterrole binding for admin user
resource "kubernetes_cluster_role_binding" "cluster-viewer" {
  metadata {
    name = "cluster-viewer"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "User"
    name      = "admin"
    api_group = "rbac.authorization.k8s.io"
  }
}
