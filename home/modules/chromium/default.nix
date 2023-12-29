{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    # package = pkgs.google-chrome;
    commandLineArgs = [ "--ozone-platform-hint=auto" ];
    extensions = [
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
      { id = "kfimphpokifbjgmjflanmfeppcjimgah"; } # inoreader
      {
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
      } # dark reader
      # { id = "ldgfbffkinooeloadekpmfoklnobpien"; } # raindrop.io
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
      {
        id = "niloccemoadcdkdjlinkgdfekeahmflj";
      } # pocket
      # { id = "lmhkmibdclhibdooglianggbnhcbcjeh"; } # Summarize (gpt)
      { id = "liecbddmkiiihnedobmlmillhodjkdmb"; } # Loom video recording
      { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # Privacy Badger
      { id = "oeopbcgkkoapgobdbedcemjljbihmemj"; } # Checker Plus for Gmail™
      {
        id = "hkhggnncdpfibdhinjiegagmopldibha";
      } # Checker Plus for Google Calendar™
      # { id = "gfapcejdoghpoidkfodoiiffaaibpaem"; } # Dracula theme, in case I can't do the pro
      { id = "hefhjoddehdhdgfjhpnffhopoijdfnak"; } # Privacy Party
      { id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi"; } # Google docs offline
      { id = "cdglnehniifkbagbbombnjghhcihifij"; } # Kagi search
      { id = "pcmpcfapbekmbjjkdalcgopdkipoggdi"; } # Markdown downloader
      { id = "gcaimhkfmliahedmeklebabdgagipbia"; } # Archive Today
      { id = "mphkdfmipddgfobjhphabphmpdckgfhb"; } # obsidian clipper

    ];
  };
}
