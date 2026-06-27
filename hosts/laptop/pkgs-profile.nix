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
        crosspipe
    ];

    shell = with pkgs; [
        zsh
        zsh-fzf-tab
        zsh-autosuggestions
        zsh-syntax-highlighting
        eza
        yazi
        fzf
        zoxide
        starship
        inputs.concord.packages.${system}.default
        brightnessctl
        killall
        htop
        libnotify
        fyi
    ];

    workflow = with pkgs; [
        chezmoi
        git
        stow
        lazygit
        gnumake
        dotbot
        inputs.herdr.packages.${system}.default
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
	      kitty
	      foot
        (prismlauncher.override {
            additionalPrograms = [ ffmpeg ];
            additionalLibs = [ glfw3-minecraft ];
            jdks = [
                jdk21
                jdk17
            ];
         })
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

    icons = with pkgs; [
        papirus-icon-theme
        adwaita-icon-theme
    ];

    wayland = with pkgs; [
        wl-clipboard
        hyprshot
    ];
}
