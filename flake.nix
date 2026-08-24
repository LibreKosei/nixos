{
    description = "A very basic NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        hyprland.url = "github:hyprwm/Hyprland/v0.56.0";

        kvim = { 
            url = "github:LibreKosei/kvim"; 
        };

        quickshell = {
            url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-minecraft.url = "github:Infinidoge/nix-minecraft";

        mangowm = {
            url = "github:mangowm/mango";
            inputs.nixpkgs.follows = "nixpkgs";
        };

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

        niri = {
            url = "github:sodiboo/niri-flake?rev=6bb99ff875919f03ea6054026619d999061e1170";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        matugen = {
            url = "github:/InioX/Matugen";
        };

        freesmLauncher = {
            url = "github:FreesmTeam/FreesmLauncher";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        noctalia = {
            url = "github:noctalia-dev/noctalia";
        };
    };

    outputs = { self, nixpkgs, hyprland, niri, noctalia, ... }@inputs: 
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
                niri.nixosModules.niri
                noctalia.nixosModules.default
                ./hosts/laptop/configuration.nix                
                ./modules/default.nix
                { nixpkgs.overlays = [ (import ./overlays inputs) niri.overlays.niri ]; }
            ];
        };
    };
}
