{ config, pkgs, ... }:

{
  imports = [ ./editor.nix ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "aditya";
  home.homeDirectory = "/home/aditya";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;

  # git, zsh, nvim configured later
  home.packages = with pkgs; [
    # System Tools
    dmidecode
    neofetch # Bischebis
    xclip
    jq
    tmux
    dpkg
    exfat
    curl
    wget
    tree
    openssl

    # Programming Software
    nixfmt
    go
    hugo
    julia
    libgcc
    gcc9
    gdb

    # User Applications
    thunderbird
    librewolf
    discord
    telegram-desktop
    transmission-qt
    vlc
    brave

    # Other
    #   (nerdfonts.override{ 
    #       fonts = [
    #          "AnonymousPro"
    #          "Hack"
    #          "CascadiaCode"
    #      ];
    #   })
  ];

  programs.git = {
    enable = true;
    userName = "Ellipse0934";
    userEmail = "7466364+Ellipse0934@users.noreply.github.com";
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    shellAliases = {
      jl = "julia";
      vi = "nvim";
      dt = "date --iso-8601=s";
    };
    initExtra = ''
      	    export PS1="%1~ $ "
              bindkey -e
      	'';
  };

  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/aditya/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
    vi = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}