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
        niri = {
            enable = true;
            package = pkgs.niri-unstable;
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

        noctalia = {
            enable = true;
            systemd.enable = true;
        };
    };
}
