resource "null_resource" "ssh_connection" {
  depends_on = [
    module.vpc
  ]
  connection {
    type        = "ssh"
    host        = module.ec2_public.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("privatekeys/terraform-key2.pem")
  }
  provisioner "file" {
    source      = "privatekeys/terraform-key2.pem"
    destination = "/tmp/terraform-key2.pem"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-key2.pem"
    ]
  }
  provisioner "local-exec" {
    command = "echo get the name of vpc id: ${module.vpc.vpc_id} >> ../local-output/private_ips.txt"
  }
}
