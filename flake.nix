{
    description = "A very basic NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

        hyprland.url = "github:hyprwm/Hyprland/v0.55.0";

        kvim = { 
            url = "github:LibreKosei/kvim"; 
            inputs.nixpkgs.follows = "nixpkgs";
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
    };

    outputs = { self, nixpkgs, hyprland, ... }@inputs: 
    let
        system = "x86_64-linux";
        lib = nixpkgs.lib;
    in
    {
        nixosConfigurations.nixos = lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs; };
            modules = [
                hyprland.nixosModules.default
                ./hosts/laptop/configuration.nix                
                ./modules/default.nix
            ];
        };
    };
}
