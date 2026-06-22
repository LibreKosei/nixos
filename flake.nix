{
    description = "A very basic NixOS configuration";

    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }@inputs: 
    let
        system = "x86_64-linux";
        lib = nixpkgs.lib;
        pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
        };
    in
    {
        nixosConfiguration = lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs; };
            modules = [
                
            ];
        };
    };
}
