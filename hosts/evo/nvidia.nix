# Get BusID:
# lspci | rg "VGA|3D controller"
# it will be in hexadecimal format, convert it to decimal
# https://www.binaryhexconverter.com/hex-to-decimal-converter
{ config, pkgs, inputs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
  no-offload = pkgs.writeShellScriptBin "no-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=0
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=
    export __GLX_VENDOR_LIBRARY_NAME=
    export __VK_LAYER_NV_optimus=
    exec "$@"
  '';
  # sink-intel-service = {
  #   enable = true;
  #   wantedBy = ["graphical.target"];
  #   after = ["graphical.target"];
  #   description = "source nvidia sink intel";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "root";
  #     RemainAfterExit = "yes";
  #     ExecStart = "${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource modesetting NVIDIA-0 && xrandr --auto";
  #   };
  # };
in {

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfree = pkgs.lib.mkForce true;

  environment.systemPackages = [
    nvidia-offload
    no-offload
    pkgs.gnomeExtensions.gpu-profile-selector
    inputs.envycontrol.packages.x86_64-linux.default
  ];

  #  Use Home manager to configire the gnome extention
  # home-manager.users.noaccos.homeModules.programs.browsers.firefox.gnomeIntegration = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      modesetting.enable = true;
      prime = {
        offload.enable = true;
        # allowExternalGpu = true;

        # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
        intelBusId = "PCI:0:2:0";

        # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
        nvidiaBusId = "PCI:1:0:0";

      };

      powerManagement = {
        enable = true;
        finegrained = true;
      };

    };
  };

  specialisation = {

    sync.configuration = {
      system.nixos.tags = [ "sync" ];

      boot = {
        kernelParams = [
          "acpi_rev_override"
          "mem_sleep_default=deep"
          "nvidia-drm.modeset=1"
        ];
        # kernelPackages = pkgs.linuxPackages_5_4;
        # extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
      };

      services.xserver = {
        # videoDrivers = [ "nvidia" ];

        config = ''
          Section "Device"
              Identifier  "Intel Graphics"
              Driver      "intel"
              #Option      "AccelMethod"  "sna" # default
              #Option      "AccelMethod"  "uxa" # fallback
              Option      "TearFree"        "true"
              Option      "SwapbuffersWait" "true"
              BusID       "PCI:0:2:0"
              #Option      "DRI" "2"             # DRI3 is now default
          EndSection

          Section "Device"
              Identifier "nvidia"
              Driver "nvidia"
              BusID "PCI:1:0:0"
              Option "AllowEmptyInitialConfiguration"
          EndSection
        '';
        screenSection = ''
          Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
          Option         "AllowIndirectGLXProtocol" "off"
          Option         "TripleBuffer" "on"
        '';
      };

      hardware.nvidia.modesetting.enable = true;
      hardware.nvidia.prime.offload.enable = pkgs.lib.mkForce false;
      hardware.nvidia.prime.sync.enable = pkgs.lib.mkForce true;
      hardware.nvidia.powerManagement.enable = pkgs.lib.mkForce false;
      hardware.nvidia.powerManagement.finegrained = pkgs.lib.mkForce false;

      # systemd.services.sink-intel-service = sink-intel-service;
    };
    reverse-prime.configuration = {
      system.nixos.tags = [ "reverse-prime" ];

      hardware.nvidia.modesetting.enable = true;
      hardware.nvidia.prime.offload.enable = pkgs.lib.mkForce false;
      hardware.nvidia.prime.sync.enable = pkgs.lib.mkForce false;
      hardware.nvidia.powerManagement.enable = pkgs.lib.mkForce false;
      hardware.nvidia.powerManagement.finegrained = pkgs.lib.mkForce false;

      hardware.nvidia.prime.reverseSync.enable = true;

      services.xserver = {
        # videoDrivers = [ "nvidia" ];

        config = ''
          Section "Device"
              Identifier  "Intel Graphics"
              Driver      "intel"
              #Option      "AccelMethod"  "sna" # default
              #Option      "AccelMethod"  "uxa" # fallback
              Option      "TearFree"        "true"
              Option      "SwapbuffersWait" "true"
              BusID       "PCI:0:2:0"
              #Option      "DRI" "2"             # DRI3 is now default
          EndSection

          # Section "Device"
          #     Identifier "nvidia"
          #     Driver "nvidia"
          #     BusID "PCI:1:0:0"
          #     Option "AllowEmptyInitialConfiguration"
          # EndSection
        '';
        screenSection = ''
          Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
          Option         "AllowIndirectGLXProtocol" "off"
          Option         "TripleBuffer" "on"
        '';
      };

      # systemd.services.sink-intel-service = sink-intel-service;
    };
  };

}
