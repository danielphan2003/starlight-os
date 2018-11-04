{ config, pkgs, ... }:

{
  imports = [
    ./sxhkd.nix
  ];
  services.xserver.windowManager = {
    bspwm = {
      enable = true;
      configFile = "/etc/bspwmrc";
    };
    default = "bspwm";
  };
  environment.etc.bspwmrc = {
    mode = "0645";
    text = ''
#!/usr/bin/env zsh

# xrdb
function get_xrdb() {
  xrdb -query | grep "$1" | awk '{print $2}' | tail -n1
}
      
if [ -e "/etc/X11/Xresources" ]; then
  xrdb /etc/X11/Xresources
fi
if [ -e "$HOME/.Xresources" ]; then
  xrdb -merge "$HOME/.Xresources"
fi

# pointer
xsetroot -cursor_name left_ptr

# border color
bspc config normal_border_color "$(get_xrdb background)"
bspc config focused_border_color "$(get_xrdb color12)"
bspc config border_width         3 
bspc config window_gap           0
bspc config split_ratio          0.50 
bspc config borderless_monocle   true 
bspc config gapless_monocle      true
bspc config single_monocle       true
bspc config focus_follows_pointer false

# polybar
#for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#  MONITOR=$m polybar --reload archi3 &
#done

# background image
#if [ -e "$HOME/.fehbg" ]; then
#  source "$HOME/.fehbg"
#else
#  feh --bg-tile "$HOME/Pictures/basket.png"
#fi
      
if [ -e "$HOME/.config/bspwm/bspwmrc" ]; then
  "$HOME/.config/bspwm/bspwmrc"
fi
    '';
  };
}
