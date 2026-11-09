{
    description = "A very basic NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        kvim = { 
            url = "github:LibreKosei/kvim"; 
        };

        nix-minecraft.url = "github:Infinidoge/nix-minecraft";

        icon-browser.url = "github:Aylur/icon-browser";
        
        pebble-icon-theme = {
            url = "github:fleugle/Pebble-Icon-Theme-flake";
        };

        freesmLauncher = {
            url = "github:FreesmTeam/FreesmLauncher";
        };

        noctalia = {
            url = "github:noctalia-dev/noctalia";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        umbriel.url = "github:noctalia-dev/umbriel/cachix";
    };

    outputs = { self, nixpkgs, noctalia, umbriel, kvim, ... }@inputs: 
    let
        system = "x86_64-linux";
        lib = nixpkgs.lib;
    in
    {
        # overlays.default = import ./overlays inputs;
        nixosConfigurations.nixos = lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs; };
            modules = [
                noctalia.nixosModules.default
                umbriel.nixosModules.default
                kvim.nixosModules.default
                ./hosts/laptop/configuration.nix                
                ./modules/default.nix
                # { nixpkgs.overlays = [ (import ./overlays inputs) ]; }
            ];
        };
    };
}
