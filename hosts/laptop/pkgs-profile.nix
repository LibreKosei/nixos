{ pkgs, inputs, ...}:
let 
    system = pkgs.stdenv.hostPlatform.system;
in
{
    bluetooth = with pkgs; [
        overskride
        bluez
    ];

    audio = with pkgs; [
        pavucontrol
        helvum
    ];

    shell = with pkgs; [
        zsh
        zsh-fzf-tab
        zsh-autosuggestions
        zsh-syntax-highlighting
        eza
        lazygit
        yazi
        fzf
        zoxide
        starship
        stow
    ];

    browsers = with pkgs; [
        firefox
        ungoogled-chromium
        brave
    ];

    editors = with pkgs; [
        inputs.kvim.packages.${system}.default
    ];

    desktop = with pkgs; [
        xournalpp
        obsidian
        signal-desktop
        libreoffice
    ];

    qtPackages = with pkgs.kdePackages; [
        qt6ct
        dolphin
    ];

    misc = with pkgs; [
        addwater
        (inputs.quickshell.packages.${system}.default.withModules [
            pkgs.kdePackages.kirigami
            pkgs.kdePackages.qtmultimedia
            pkgs.kdePackages.qt5compat
        ])
    ];

    network = with pkgs; [
        tailscale
        trayscale
    ];
}
