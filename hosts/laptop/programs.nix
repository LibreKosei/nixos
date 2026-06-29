{ config, pkgs, inputs, ...}:
{
    programs = { 
        obs-studio = {
            enable = true;
            enableVirtualCamera = true;
            plugins = with pkgs.obs-studio-plugins; [
                obs-pipewire-audio-capture
                obs-gstreamer
            ];
        };

        zsh = {
            enable = true;
        };

        nh = {
            enable = true;
            clean.enable = true;
            clean.extraArgs = "--keep-since 4d --keep 3";
            flake = "/home/kosei/nixos";
        };
        
        # Compositor
        hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
            xwayland.enable = true;
            withUWSM = true;
        };

        hyprlock.enable = true;

        niri = {
            enable = true;
        };

        tmux = {
            enable = true;
            baseIndex = 1;
            keyMode = "vi";
            shortcut = "a";
        };

        direnv = {
            enable = true;
        };
    };
}
