inputs: final: prev: {
    nvchad = 
        (inputs.nix4nvchad.packages.${prev.stdenv.hostPlatform.system}.default.override {
            extraPackages = with prev; [
                ripgrep
                stylua
                lua-language-server
                bash-language-server
                nixd
            ];  
        });
}
