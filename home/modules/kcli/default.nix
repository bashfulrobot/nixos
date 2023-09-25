{ config, lib, pkgs, ... }: {

  programs.bash = {
    shellAliases = {
      kcli =
        "${pkgs.docker}/bin/docker run --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir -v $HOME/.kube:/root/.kube quay.io/karmab/kcli";

      kcli-dl-lts = "kcli download image ubuntu2204";
      kcli-dl-custom =
        "echo 'run something like: kcli download image -u https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img ubuntu2204'";
      kcli-list-images = "kcli list available-image";
      kcli-update =
        "kcli version; sleep 1; docker pull quay.io/karmab/kcli; kcli version";
      kcli-create-default-network =
        "kcli create network  -c 192.168.122.0/24 default";
      kcli-create-default-pool =
        "sudo kcli create pool -p /var/lib/libvirt/images default; sudo setfacl -m u:$(id -un):rwx /var/lib/libvirt/images";
      kcli-init-local = "kcli create host kvm -H 127.0.0.1";
      kcli-init-srv = "kcli create host kvm -H 100.123.211.36 srv";
    };

  };

  # home.file.".kcli/k8s-small.yml".text = ''
  #   cp01:
  #     image: ubuntu2204
  #     numcpus: 4
  #     memory: 4096
  #     disks:
  #        - size: 60
  #     packages:
  #     - git
  #     - neovim
  #     - curl
  #     cmds:
  #     - apt update && apt dist-upgrade -y
  #     - date > dk-run.log
  # '';
  # home.file.".kcli/profiles.yml".text = ''
  #   ubuntu2204:
  #     image: ubuntu2204
  #   ub4:
  #     image: ubuntu-20.04-server-cloudimg-amd64.img
  #     numcpus: 4
  #     memory: 4096
  #     disks:
  #       - size: 60
  #     cmds:
  #       - apt update && apt dist-upgrade -y
  #       - apt install -y git make neovim curl zsh
  #     # - runuser -l ubuntu -c 'curl -Lo zsh.sh https://zsh.bashfulrobot.com'
  #     # - runuser -l ubuntu -c 'bash zsh.sh'
  #     # - curl -Lo zsh.sh https://zsh.bashfulrobot.com
  #     # - bash zsh.sh
  #   ub8:
  #     image: ubuntu-20.04-server-cloudimg-amd64.img
  #     numcpus: 4
  #     memory: 8192
  #     disks:
  #       - size: 120
  #     cmds:
  #       - apt update && apt dist-upgrade -y
  #       - apt install -y git make neovim curl zsh
  #     # - runuser -l ubuntu -c 'curl -Lo zsh.sh https://zsh.bashfulrobot.com'
  #     # - runuser -l ubuntu -c 'bash zsh.sh'
  #     # - curl -Lo zsh.sh https://zsh.bashfulrobot.com
  #     # - bash zsh.sh
  #   kvm-local_ubuntu2004:
  #     image: ubuntu-20.04-server-cloudimg-amd64.img
  #   cp:
  #     image: ubuntu2204
  #     numcpus: 4
  #     memory: 4096
  #     disks:
  #       - size: 60
  #     cmds:
  #       - apt update && apt dist-upgrade -y
  #       - apt install -y git make neovim curl wget zsh
  #       # - runuser -l ubuntu -c 'curl -Lo zsh.sh https://zsh.bashfulrobot.com'
  #       # - runuser -l ubuntu -c 'bash zsh.sh'
  #       # - curl -Lo zsh.sh https://zsh.bashfulrobot.com
  #       # - bash zsh.sh
  #       - curl -Lo kcli-kubeadm.sh https://raw.githubusercontent.com/bashfulrobot/desktoperator/main/kubeadm-test.sh
  #       - bash ./kcli-kubeadm.sh
  #   wk:
  #     image: ubuntu-20.04-server-cloudimg-amd64.img
  #     numcpus: 4
  #     memory: 8192
  #     disks:
  #       - size: 120
  #     cmds:
  #       - apt update && apt dist-upgrade -y
  #       - apt install -y git make neovim curl wget zsh
  #       # - runuser -l ubuntu -c 'curl -Lo zsh.sh https://zsh.bashfulrobot.com'
  #       # - runuser -l ubuntu -c 'bash zsh.sh'
  #       # - curl -Lo zsh.sh https://zsh.bashfulrobot.com
  #       # - bash zsh.sh
  #       - curl -Lo kcli-kubeadm.sh https://raw.githubusercontent.com/bashfulrobot/desktoperator/main/kubeadm-test.sh
  #       - bash ./kcli-kubeadm.sh
  #   cp-br:
  #     image: ubuntu-20.04-server-cloudimg-amd64.img
  #     numcpus: 4
  #     memory: 4096
  #     disks:
  #       - size: 60
  #     nets:
  #       - name: br0
  #     cmds:
  #       - apt update && apt dist-upgrade -y
  #       - apt install -y git make neovim curl wget zsh
  #       # - runuser -l ubuntu -c 'curl -Lo zsh.sh https://zsh.bashfulrobot.com'
  #       # - runuser -l ubuntu -c 'bash zsh.sh'
  #       # - curl -Lo zsh.sh https://zsh.bashfulrobot.com
  #       # - bash zsh.sh
  #       - curl -Lo kcli-kubeadm.sh https://raw.githubusercontent.com/bashfulrobot/desktoperator/main/kubeadm-test.sh
  #       - bash ./kcli-kubeadm.sh
  #   wk-br:
  #     image: ubuntu-20.04-server-cloudimg-amd64.img
  #     numcpus: 4
  #     memory: 8192
  #     disks:
  #       - size: 120
  #     nets:
  #       - name: br0
  #     cmds:
  #       - apt update && apt dist-upgrade -y
  #       - apt install -y git make neovim curl wget zsh
  #       # - runuser -l ubuntu -c 'curl -Lo zsh.sh https://zsh.bashfulrobot.com'
  #       # - runuser -l ubuntu -c 'bash zsh.sh'
  #       # - curl -Lo zsh.sh https://zsh.bashfulrobot.com
  #       # - bash zsh.sh
  #       - curl -Lo kcli-kubeadm.sh https://raw.githubusercontent.com/bashfulrobot/desktoperator/main/kubeadm-test.sh
  #       - bash ./kcli-kubeadm.sh
  #   kvm-local_centos8stream:
  #     image: CentOS-Stream-GenericCloud-8-20210603.0.x86_64.qcow2

  # '';

}
