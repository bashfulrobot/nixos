{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.apps.zoom-us;
  # Needed for pinning version
  zoomPkgs = import inputs.nixpkgs-zoom {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

in {
  options = {
    apps.zoom-us.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the zoom-us desktop.";
    };
    apps.zoom-us.downgrade = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use an older version zoom-us desktop taht works for me.";
    };
    apps.zoom-us.useUnstable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use the unstable version of zoom-us desktop.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Working, but testing below.
    # environment.systemPackages = with pkgs;
    #   [
    #     (if cfg.downgrade then zoomPkgs.zoom-us else zoom-us)
    #   ];
    environment.systemPackages = with pkgs;
      [
        (if cfg.downgrade then
          zoomPkgs.zoom-us
        else if cfg.useUnstable then
          unstable.zoom-us
        else
          zoom-us.overrideAttrs (attrs: {
            nativeBuildInputs = (attrs.nativeBuildInputs or [ ]) ++ [ bbe ];
            postFixup = ''
              cp $out/opt/zoom/zoom .
              bbe -e 's/\0manjaro\0/\0nixos\0\0\0/' < zoom > $out/opt/zoom/zoom
            '' + (attrs.postFixup or "") + ''
              sed -i 's|Exec=|Exec=env XDG_CURRENT_DESKTOP="gnome" |' $out/share/applications/Zoom.desktop
            '';
          }))
      ];
    systemd.tmpfiles.rules = [
      "L+ /usr/libexec/xdg-desktop-portal - - - - ${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal"
    ];
    home-manager.users."${user-settings.user.username}" = {

      # force zoom to use wayland and portals
      home.file.".config/zoomus.conf".text = ''
        [General]
        %2B8gcPZIuASRcihpYJW6UA83rPnH%2B7ifu11s9xp3p8Rc%23=1705948233
        %2BDktQynwbiTNOvk7etDBPF5SHkytoqcON6QJqxdvqUk%23=1717090190
        %2BYxig3Tcg9cSzPenXPFMaiuFOgDCmg81Qbt%2BzAOqOr8%23=1717570801
        0SftQNQrQI4jtNaKR4LuAzGUZFeb8VqaksXwvjDNCoQ%23=1701381601
        1HAXEP7c5mbtfLjWIFqdTuIkVyDFbE0OgQ73dREQ1ec%23=1716911164
        328bU7wu5P4dBiS9Eym0MO54LzZ9WLCcKhhw98wPAAc%23=1701707383
        39FmUBc17Ewmtga%2BJzHoAX9oonZUUTJr228GaehObGs%23=1705948233
        4awgejeMMpzMdEdW1a8Cjerd45yxHDZVRNRPY1h2Dv4%23=1702338010
        63tJmSFEpYg9dR34FZPBHK8VKGPcUT1yDVJWSS9UTuU%23=1713988858
        6K70qDQiygEOC1IRMP7u0d4D3mbTqYIWtc4J5HuRkQs%23=1712347324
        8Cjo0v208YO42O4fNVc1xwRM3I0bCD8fxc181spt%2Bew%23=1689969736
        AC84sdqtxW2pI4T2VCgZSScxnVB8xShBk2H2XcTadd4%23=1717000423
        CLDICMjcg7UNTm7jGjHsqYaAXuGKrME0D9TSH7Khf4o%23=1704529759
        GeoLocale=system
        HUcz7iOlu7Xyr31fWuNHSsMg5t9D%2BvCy6D0tT1DmHNM%23=1704470417
        JPex9HSNceUDcAyS1GhYJ5sCxhJKbVd6KQCqt2Zeo6U%23=1714152743
        MX3zBP9Pcrfy3VaYRAQLy9tW9JWlUXm1C4QP5o1ozWA%23=1699949476
        MeXhIBlkWtNIOLFGTeVddBAgzrqFhoIAgaPeP5xYSkw%23=1701474737
        Mzz1LijQi7%2BWxptNWXTtecgWKziCKglRhJ1JR4ALU5c%23=1704355203
        N65z0ERhK0hfZOUrpvZbKa20IAIu0Etuq8T%2BuqWl%2Bkw%23=1687724404
        SensitiveInfoMaskOn=true
        UeJ7AgrtBappnQjaaFui4jk8yVCY2K4zE14gyE34Rzo%23=1718741801
        Vozv1tIVMCwkLiogSki0IfQWBGLVlUX69ezlJZDQ1Ng%23=1716990998
        autoPlayGif=false
        autoScale=true
        bForceMaximizeWM=false
        captureHDCamera=true
        cefInstanceCountLimit=-1
        chatListPanelLastWidth=230
        com.zoom.client.langid=0
        conf.crash.enable.auto.uploaddumps=true
        conf.webserver=https://zoom.us
        conf.webserver.vendor.default=https://sysdig.zoom.us
        currentMeetingId=92485447464
        cuuNG8zLfSThzxirNJ%2Byiv6tYNITCsIKOouecnzelDI%23=1702569660
        deviceID=94:E7:0B:50:49:0C
        disableCef=false
        enable.host.auto.grab=true
        enableAlphaBuffer=true
        enableCefGpu=false
        enableCefLog=false
        enableCloudSwitch=true
        enableLog=true
        enableMiniWindow=false
        enableQmlCache=true
        enableScreenSaveGuard=true
        enableStartMeetingWithRoomSystem=false
        enableTestMode=false
        enableWaylandShare=false
        enableWebviewDevTools=false
        enablegpucomputeutilization=false
        fake.version=
        fch72d3vhpIEQwcqzoipl7i7vueuVi0qZZvkF0rJ8pY%23=1702455473
        flashChatTime=0
        forceEnableTrayIcon=true
        forceSSOURL=
        host.auto.grab.interval=10
        isTransCoding=false
        j3Ly8CySrbw9iHrqSD2TR4XOAiHKSRkbBQrPdToY3aY%23=1717000422
        kRsMBxoA%2Botsrp38nEoOC4ceZCE7T49xHuSqxARWLvY%23=1702512097
        logLevel=info
        m3OddGOQr94gPhBm5vXj4ZBtDyEReujKePOE9L2o5Zg%23=1715371148
        newMeetingWithVideo=true
        noSandbox=false
        playSoundForNewMessage=false
        q1qgVtSlsePAANsDAljvzvYKL81RewJO1Rjb5Uv1c0g%23=1694016558
        roHKmGnFqyVMAUXEUybBdbbOr1eulrLGR8cyk2jQEm4%23=1715974534
        shareBarTopMargin=0
        showOneTimePTAICTipHubble=false
        showOneTimeQAMostUpvoteHubble=true
        showOneTimeQueriesOptionTip=true
        showOneTimeTranslationUpSellTip=false
        speaker_volume=255
        sso_domain=.zoom.us
        sso_gov_domain=.zoomgov.com
        supportCefProxyServer=false
        system.audio.type=default
        timeFormat12HoursEnable=false
        transcodingUI=true
        translationFreeTrialTipShowTime=0
        upcoming_meeting_header_image=
        useSystemTheme=false
        userEmailAddress=dustin.krysak@sysdig.com
        wp7SxMcjSJFBNLZxmvmhiZblEk02wF92Z97IxH70iwg%23=1687724404
        xwayland=true
        z7UzTv6fymc7VL7mkEr5yW%2BoMtcxRRzxQcv2wMwHwr0%23=1715974536
        znoEUQ3i3sNVespocs1Z51gOKhB8BpDvq9yP8N8oamk%23=1701381603
        zsHRLUSwqqaWPJNlEwmNAnzkqUIP1YEJyBli58yqS7k%23=1706257381

        [1VGa6fEsTQYEquYOdMv]
        j1V5NQSTWNQPlSB8TSaIgvM%23=1705948233

        [1dWSnwpyjLL7oBcI7Act3y3E]
        5KaNCWqBvVV42hp5gU%23=1704470418

        [6VWGf8gVqJ%2BbU8raEIePi%2BV]
        z\6Ve0DDvqs4yPlGDtQ%23=1699949476

        [9%2Bz5m%2BM0E3ehH3L8yDn62n]
        aXJfHnCnchbKau541hys%23=1714152744

        [9PqDj3LH3w1QNdh6]
        Jo2Jo06ouqi\CSINtnx8lhUKKs%23=1700503201

        [AS]
        showframewindow=true

        [BWwnu%2B]
        GweZFAFygbvnTUy9jl4xCq9\9M\T\Ws0guVI%23=1705948234

        [CodeSnippet]
        lastCodeType=0
        wrapMode=0

        [EiRqIx1wjUglr7ISPH18e3WoB]
        feN%2B8%2BCvvsg9faJu8%23=1701378974

        [HB]
        DtkoyBMpaOyJ%2BU5FcSncJ4VRB7a39p91VjF6YjoE%23=1717002845

        [IdXwZwfWMO]
        LX8xvOAWJTzobePTVcdsSALgecT\TjwU%23=1709829946

        [LkHv67jvj8VnQO8ZnECYsFmXtmgf]
        q%2BTUmGdE0OIRQg%23=1702569659

        [QcSmcZaZBeq56HepePkWwv1kIZbCdxJdsXY4ze9VQ]
        I%23=1694016554

        [Rnoy8ICRHiP%2BdqPd6YU]
        Y%2BkRxvgom7szyKWSlThMmH0%23=1704529762

        [U%2B9yrZt]
        uG80\W3iTeoULNGiaROdk\3iAFAYoPR\QGw%23=1701378972

        [WFtfzrtX7OyOF6Ejkv1PfZ]
        zhgi97Ed%2Bwigp5RYVvIQ%23=1717180201

        [WczlOfRELvnSbRUqAHQGr73z%2BXzXfZM3j21]
        X0psb\s%23=1716990997

        [XguVCiSiKPwzHxOyf0rWrf4I3ya5VYgOO4]
        3ko7sVJs%23=1717090192

        [ZI3hs3nIBfsN0IVt7kpB0]
        AbrpWHeHRX8eWGlR552FY%23=1702455471

        [ZayQOxp]
        TW\W1gibSOACm7PstbMz5a20HNIXv6wMEFY%23=1702338012

        [b]
        Mq6AomC%2BcHyZnm7vQvFYE9D6ouq4R2h%2BzGO\xf%2BZw%23=1704355201

        [chat.recent]
        recentlast.session=

        [ismp8Wfc81OcBTf2KGWFyX]
        k103UqkQc\aGeIjJUMvU%23=1709829947

        [l8yw94omVUaKegm8ma0gdpj]
        m4GMaVWLzAeXVeZ80x8%23=1702512095

        [mx6lMrhFQUJ7jX37%2Blg1%2BhcqFjh%2BTP]
        XFiY5KV3Mw60%23=1699550926

        [n0e86LkJJ1AHuTlwIp5bbyq2Z8jcQ9q5d]
        YLIh5OddQ%23=1716911163

        [nU4cbW42%2BUpcozbAchpMQCjrF5O7nt7tAeuK8N]
        A8Vk%23=1700503202

        [pom22GEtPbBL%2BPGorGy0yjV4cr2vq%2Bn6xd0Btv]
        FYWw%23=1701474736

        [pvKc9SrvNy]
        UrM6djKC7sBYYhjF2xNCSHVpXDpFealQ%23=1712347324

        [qDevKS3cF8ZbdyA3jKk]
        4Ix4rvh1JmYxiXRjpSFufL4%23=1717002843

        [qsjIT%2BlPqeBCqNtqxAuMxjas70PNV7hAS7YL8lgyW]
        k%23=1706257384

        [s62mdPMKl9Se%2B7H9X4UrurDy3CcH81EKBW%2B]
        lE9noLk%23=1717570803

        [tIeF8ful228gJYAeu4hUCekS8czC15rd3Bgvmn6LH]
        I%23=1717180202

        [uXGHdajxGq1KWLui2nls3thPFn5ZDM0r]
        k9%2BimV8NTk%23=1715371146

        [z%2B6]
        w\sal\u4xxQy8RhPDPkz\mBN1l77K54jVna7TBU%23=1701707385

        [zoom_new_im]
        is_landscape_mode=true
        main_frame_pixel_pos_narrow="568,653"
        main_frame_pixel_pos_wide="1280,1000"

      '';
    };
  };
}
