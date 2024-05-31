from kubernetes import client, config

def scale_deployment(api_instance, namespace, deployment_name, replicas):
    # Update the replicas count
    deployment = api_instance.read_namespaced_deployment(deployment_name, namespace)
    deployment.spec.replicas = replicas

    # Update the deployment
    api_instance.patch_namespaced_deployment(
        name=deployment_name,
        namespace=namespace,
        body=deployment
    )

def main():
    # Assuming running in cluster
    config.load_incluster_config()

    apps_v1 = client.AppsV1Api()

    scale_deployment(apps_v1, "default", "my-deployment", 5)

if __name__ == "__main__":
    main()


Below is the conversion to go

    package main

    import (
        "context"
        "fmt"
        metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
        "k8s.io/client-go/kubernetes"
        "k8s.io/client-go/tools/clientcmd"
        "k8s.io/apimachinery/pkg/util/intstr"
    )

    func main() {
        kubeconfig := "/path/to/your/kubeconfig" // replace with your kubeconfig path
        config, _ := clientcmd.BuildConfigFromFlags("", kubeconfig)
        clientset, _ := kubernetes.NewForConfig(config)

        deploymentClient := clientset.AppsV1().Deployments("default") // replace "default" with your namespace

        deployment, _ := deploymentClient.Get(context.TODO(), "my-deployment", metav1.GetOptions{}) // replace "my-deployment" with your deployment name

        deployment.Spec.Replicas = intstr.Parse("5") // replace "5" with the number of replicas you want

        _, err := deploymentClient.Update(context.TODO(), deployment, metav1.UpdateOptions{})
        if err != nil {
            fmt.Println("Failed to update deployment:", err)
            return
        }

        fmt.Println("Updated deployment successfully.")
    }

