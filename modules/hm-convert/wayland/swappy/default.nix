{ pkgs, config, inputs, ... }: {

  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=$HOME/Pictures/Screenshots
    save_filename_format=ss-%Y%m%d-%H%M%S.png
    show_panel=true
    line_size=5
    text_size=20
    text_font=sans-serif
    paint_mode=arrow
    early_exit=true
    fill_shape=false
  '';

}
