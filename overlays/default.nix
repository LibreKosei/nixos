inputs: final: prev: {
    nvchad = 
        (inputs.nix4nvchad.packages.${prev.stdenv.hostPlatform.system}.default.override {
            extraPackages = with prev; [
                ripgrep
                stylua
                lua-language-server
                bash-language-server
                # HTML and CSS
                vscode-langservers-extracted
                # QML Language Server
                kdePackages.qtdeclarative 

                # Typescript
                typescript-language-server
            ];  
        })
        .overrideAttrs (old: {
            nativeBuildInputs = old.nativeBuildInputs ++ [ prev.kdePackages.wrapQtAppsHook ];
        });
}
