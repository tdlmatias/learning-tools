# Define certificate template
data "template_file" "certificates" {
    template                = "${file("${path.module}/template/kubernetes-csr.json")}"
    depends_on              = ["aws_elb.k8s_api_elb",
                               "aws_instance.etcd_instances",
                               "aws_instance.controllers",
                               "aws_instance.workers"]
    vars {
      kubernetes_api_elb_dns_name = "${aws_elb.k8s_api_elb.dns_name}"
      kubernetes_cluster_dns      = "${var.kubernetes_cluster_dns}"

      # Unfortunately, variables must be primitives, neither lists nor maps
      etcd0_ip              = "${aws_instance.etcd_instances.0.private_ip}"
      etcd1_ip              = "${aws_instance.etcd_instances.1.private_ip}"
      etcd2_ip              = "${aws_instance.etcd_instances.2.private_ip}"
      controller0_ip        = "${aws_instance.controllers.0.private_ip}"
      controller1_ip        = "${aws_instance.controllers.1.private_ip}"
      controller2_ip        = "${aws_instance.controllers.2.private_ip}"
      worker0_ip            = "${aws_instance.workers.0.private_ip}"
      worker1_ip            = "${aws_instance.workers.1.private_ip}"
      worker2_ip            = "${aws_instance.workers.2.private_ip}"

      etcd0_dns             = "${aws_instance.etcd_instances.0.private_dns}"
      etcd1_dns             = "${aws_instance.etcd_instances.1.private_dns}"
      etcd2_dns             = "${aws_instance.etcd_instances.2.private_dns}"
      controller0_dns       = "${aws_instance.controllers.0.private_dns}"
      controller1_dns       = "${aws_instance.controllers.1.private_dns}"
      controller2_dns       = "${aws_instance.controllers.2.private_dns}"
      worker0_dns           = "${aws_instance.workers.0.private_dns}"
      worker1_dns           = "${aws_instance.workers.1.private_dns}"
      worker2_dns           = "${aws_instance.workers.2.private_dns}"
    }
}

# Render the template into certificates
resource "null_resource" "certificates" {
  triggers {
    template_rendered       = "${ data.template_file.certificates.rendered }"
  }

  provisioner "local-exec" {
    command                 = "echo '${ data.template_file.certificates.rendered }' > ../cert/kubernetes-csr.json"
  }

  provisioner "local-exec" {
    command                 = "cd ../cert; cfssl gencert -initca ca-csr.json | cfssljson -bare ca; cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kubernetes-csr.json | cfssljson -bare kubernetes"
  }
}
