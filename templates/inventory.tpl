[leader]
${leader_private_ip} ansible_host=${leader_public_ip} ansible_user=${ssh_user} ansible_ssh_private_key_file=${ssh_key_path}

[workers]
%{ for w in workers ~}
${w.priv} ansible_host=${w.pub} ansible_user=${ssh_user} ansible_ssh_private_key_file=${ssh_key_path}
%{ endfor ~}

[kubernetes:children]
leader
workers
