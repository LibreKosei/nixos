{
    description = "A very basic NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

        hyprland.url = "github:hyprwm/Hyprland/v0.55.0";

        kvim = { 
            url = "github:LibreKosei/kvim"; 
        };

        quickshell = {
            url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-minecraft.url = "github:Infinidoge/nix-minecraft";

        concord.url = "github:chojs23/concord";

        mangowm = {
            url = "github:mangowm/mango";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        herdr.url = "github:ogulcancelik/herdr/v0.7.1";
        icon-browser.url = "github:Aylur/icon-browser";
        
        nix4nvchad = {
            url = "github:nix-community/nix4nvchad";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.nvchad-starter.follows = "nvchad-starter";
        };

        nvchad-starter = {
            url = "github:LibreKosei/nvchad";
            flake = false;
        };
        
        pebble-icon-theme = {
            url = "github:fleugle/Pebble-Icon-Theme-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, hyprland, ... }@inputs: 
    let
        system = "x86_64-linux";
        lib = nixpkgs.lib;
    in
    {
        overlays.default = import ./overlays inputs;
        nixosConfigurations.nixos = lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs; };
            modules = [
                hyprland.nixosModules.default
                ./hosts/laptop/configuration.nix                
                ./modules/default.nix
                { nixpkgs.overlays = [ (import ./overlays inputs) ]; }
            ];
        };
    };
}
