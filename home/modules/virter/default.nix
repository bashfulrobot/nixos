{ pkgs, ... }: {

  home.packages = [ pkgs.binutils ];

  home.file.".config/virter/virter.toml".text = ''
    [libvirt]
    # pool is the libvirt pool that virter should use.
    # The user is responsible for ensuring that this pool exists and is active.
    # Default value: "default"
    pool = "default"

    # network is the libvirt network that virter should use.
    # The user is responsible for ensuring that this network exists and is active.
    # Default value: "default"
    network = "default"

    # static_dhcp is a boolean flag that determines how virter handles DHCP hosts
    # entries.When false, the hosts entries are added and removed as needed.
    # When true, the hosts entries must be created(with 'virter network host add')
    # before the VM is started.Adding and removing DHCP entries can temporarily
    # disrupt network access from running VMs.With this option, that disruption
    # can be controlled.
    # Default value: "false"
    static_dhcp = "false"

    # dnsmasq_options is an array of dnsmasq options passed when creating a new
    # network.Options are strings, corresponding to the long flags described
    # here: https://dnsmasq.org/docs/dnsmasq-man.html
    # Default value: []
    dnsmasq_options = []

    # disk_cache is passed to libvirt as the disk driver cache attribute.See
    # https://libvirt.org/formatdomain.html#hard-drives-floppy-disks-cdroms.
    # Default value: ""
    disk_cache = ""

    [time]
    # ssh_ping_count is the number of times virter will try to connect to a VM's
    # ssh port after starting it.
    # Default value: 300
    ssh_ping_count = 300

    # ssh_ping_period is how long virter will wait between to attempts at trying
    # to reach a VM's ssh port after starting it.
    # Default value: "1s"
    ssh_ping_period = "1s"

    # shutdown_timeout is how long virter will wait for a VM to shut down.
    # If a shutdown operation exceeds this timeout, an error will be produced.
    # Default value: "20s"
    shutdown_timeout = "20s"

    [auth]
    # virter_public_key_path is where virter should place its generated public key.
    # If this file does not exist and the file from virter_private_key_path exists,
    # an error will be produced.
    # If neither of the files exist, a new keypair will be generated and placed at the
    # respective locations.
    # If both files exist, they will be used to connect to all VMs started by virter.
    # Default value: "/home/dustin/.config/virter/id_rsa.pub"
    virter_public_key_path = "/home/dustin/.ssh/id_rsa_temp.pub"

    # virter_private_key_path is where virter should place its generated private key.
    # If this file does not exist and the file from virter_public_key_path exists,
    # an error will be produced.
    # If neither of the files exist, a new keypair will be generated and placed at the
    # respective locations.
    # If both files exist, they will be used to connect to all VMs started by virter.
    # Default value: "/home/dustin/.config/virter/id_rsa"
    virter_private_key_path = "/home/dustin/.ssh/id_rsa_temp"

    # user_public_key can be used to define additional public keys to inject into
    # the VM.If non - empty, the contents of this string will be added to the root
    # user's authorized keys inside the VM.
    # Default value: ""
    user_public_key = ""

    [container]
    # provider is the container engine used.Can be either podman or docker.
        provider = "docker"

    # default pull policy to apply if non was specified.Can be 'Always', 'IfNotExist' or 'Never'.
    # Default value: "IfNotExist"
    pull = "IfNotExist"

  '';
}
