{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.apps.chromium;

in {
  options = {
    apps.chromium.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the chromium browser.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${user-settings.user.username}" = {
      programs.chromium = {
        enable = true;
        package = pkgs.chromium;
        # package = pkgs.brave;
        commandLineArgs = [ "--ozone-platform-hint=auto" ];
        extensions = [
          { id = "cfpenpohaapdgnkglcbgjiooipcbcebi"; } # easy window resize
          { id = "khnpeclbnipcdacdkhejifenadikeghk"; } # asana
          { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
          { id = "kfimphpokifbjgmjflanmfeppcjimgah"; } # inoreader
          { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
          { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
          { id = "lljedihjnnjjefafchaljkhbpfhfkdic"; } # jiffy reader
          { id = "haebnnbpedcbhciplfhjjkbafijpncjl"; } # tineye
          { id = "fggkaccpbmombhnjkjokndojfgagejfb"; } # tactiq
          { id = "glnpjglilkicbckjpbgcfkogebgllemb"; } # okta
          { id = "gabdloknkpdefdpkkibplcfnkngbidim"; } # delugesiphon
          { id = "kbfnbcaeplbcioakkpcpgfkobkghlhen"; } # grammarly
          { id = "pbmlfaiicoikhdbjagjbglnbfcbcojpj"; } # simplify
          { id = "jldhpllghnbhlbpcmnajkpdmadaolakh"; } # todoist
          { id = "kgjfgplpablkjnlkjmjdecgdpfankdle"; } # zoom
          { id = "lcbjdhceifofjlpecfpeimnnphbcjgnc"; } # xbrowsersync
          { id = "niloccemoadcdkdjlinkgdfekeahmflj"; } # pocket
          { id = "liecbddmkiiihnedobmlmillhodjkdmb"; } # Loom video recording
          { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # Privacy Badger
          { id = "oeopbcgkkoapgobdbedcemjljbihmemj"; } # Checker Plus for Mail
          { id = "hkhggnncdpfibdhinjiegagmopldibha"; } # Checker Plus for Cal
          { id = "hefhjoddehdhdgfjhpnffhopoijdfnak"; } # Privacy Party
          { id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi"; } # Google docs offline
          { id = "pcmpcfapbekmbjjkdalcgopdkipoggdi"; } # Markdown downloader
          { id = "gcaimhkfmliahedmeklebabdgagipbia"; } # Archive Today
          { id = "mphkdfmipddgfobjhphabphmpdckgfhb"; } # obsidian clipper
          { id = "egejbknaophaadmhijkepokfchkbnelc"; } # bypass medium
          { id = "egiemoacchfofdhhlfhkdcacgaopncmi"; } # URL/Tab Manager
          { id = "bcelhaineggdgbddincjkdmokbbdhgch"; } # Mail message URL
          { id = "cfpdompphcacgpjfbonkdokgjhgabpij"; } # Glean browser extension
          { id = "gphhapmejobijbbhgpjhcjognlahblep"; } # gnome extention plugins
          { id = "miancenhdlkbmjmhlginhaaepbdnlllc"; } # copy to clipboard
          {
            id = "jpfpebmajhhopeonhlcgidhclcccjcik";
          } # Speed dial extention
          # { id = "akahnknmcbmgodngfjcflnaljdbhnlfo"; } # Vertical Tabs in Side Panel - Not needed in brave
          { id = "ncppfjladdkdaemaghochfikpmghbcpc"; } # Open as popup
          { id = "oodfdmglhbbkkcngodjjagblikmoegpa"; } # t.ly url shortener
          { id = "bkdgflcldnnnapblkhphbgpggdiikppg"; } # duckduckgo
          { id = "blkggjdmcfjdbmmmlfcpplkchpeaiiab"; } # Omnivore
          { id = "lbaenccijpceocophfjmecmiipgmacoi"; } # Wizardshot
        ];
      };
      # force chromium to use wayland - https://skerit.com/en/make-electron-applications-use-the-wayland-renderer
      home.file.".config/chromium-flags.conf".text = ''
        --enable-features=UseOzonePlatform
        --ozone-platform=wayland
      '';
    };
  };
}

# { id = "ldgfbffkinooeloadekpmfoklnobpien"; } # raindrop.io
# { id = "gfapcejdoghpoidkfodoiiffaaibpaem"; } # Dracula theme, in case I can't do the pro
# { id = "cdglnehniifkbagbbombnjghhcihifij"; } # Kagi search
# { id = "lmhkmibdclhibdooglianggbnhcbcjeh"; } # Summarize (gpt)
