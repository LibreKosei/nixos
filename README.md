# NixOS configuration with Nix Flake

> [!CAUTION]
> Make sure to replace **hardware-configuration.nix** file with the one for your computer, otherwise it might break!

This is my own simple NixOS configuration managed with Nix Flake, but without Home Manager. Copy and use it at your risk, or use it as reference. 
Configuration files are managed by `dotbot`, a simple tool for symlinking. I use it because I found it easier than GNU Stow. 


## Installation

To use this config (in a vm or actual machine)
1. Make sure you have nix flakes enabled. This can be done via setting `nix.settings.experimental-features = [ "nix-command" "flakes" ];` in your `configuration.nix` file.
2. Clone this repo
3. `cd` to the directory, and replace the `hardware-configuration.nix` file with the one from `/etc/nixos/hardware-configuration.nix`
4. Run `sudo nixos-rebuild switch --flake .`
5. Optionally, if you want to use my configuration for Hyprland, neovim, zsh, etc, then run `dotbot -c install.conf.yaml`. This will symlink the contents inside the `config/` directory to respective location.



