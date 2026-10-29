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

        yazi = {
            enable = true;
            plugins = with pkgs.yaziPlugins; {
                drag.package = drag;
                bookmarks.package = bookmarks;
                clipboard.package = clipboard;
            };
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
        };

        umbriel = {
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

        noctalia = {
            enable = true;
            systemd.enable = true;
        };

        dconf = {
            enable = true;
        };
    };
}
