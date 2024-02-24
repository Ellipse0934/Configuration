{ config, pkgs, ... }:

{
  imports  = [ ./editor.nix ];
  home.username = "aditya";
  home.homeDirectory = "/home/aditya";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;

  #fonts.fontconfig.enable = true;
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
    gpgme
    fzf
    openssh
    unzip
    dig 

    # Programming Software
    nixfmt
    go
    hugo
    julia
    libgcc
    gcc9
    gnumake
    gdb
    silver-searcher
    appimage-run
    boost
    cmakeWithGui
    docker-compose
    redis
    glibc
 
    # User Applications
    thunderbird
    librewolf
    discord
    telegram-desktop
    transmission-qt
    vlc
    brave
    wpsoffice

    # # Other
    # # font declaration is a little iffy due to KDE
    #   (nerdfonts.override {
    #       fonts = [
    #          "AnonymousPro"
    #          "Hack"
    #          "CascadiaCode"
    #      ];
    #   })
  ];

  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins;[
       nord 
    ];
    extraConfig = "run-shell ${pkgs.tmuxPlugins.nord}/share/tmux-plugins/nord/nord.tmux";
  };

  programs.kitty = {
    font = {
        name = "CaskaydiaCove Nerd Font";
        size = 18.0;
    };
    enable = true;
    shellIntegration.enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Ellipse0934";
    userEmail = "7466364+Ellipse0934@users.noreply.github.com";
    extraConfig = {
        diff.tool = "vimdiff";
        difftool.prompt = false;
        init.defaultBranch = "master";
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    shellAliases = {
      jl = "julia --banner=no";
      vi = "nvim";
      dt = "date --iso-8601=s";
      configit = "git --git-dir=$HOME/code/config --work-tree=$HOME/.config";
    };
    initExtra = ''
            bindkey -e
            bindkey "^[[1;5C" forward-word
            bindkey "^[[1;5D" backward-word
            bindkey "^[[3~" delete-char
      	    export PS1="%1~ $ "
            export LANG=en_US.UTF-8
  	'';
  };

  home.file = {
    ".julia/config/repl.jl".source = ./julia/repl.jl;
    ".julia/config/startup.jl".source = ./julia/startup.jl;
    ".ssh/config".text = ''
      Host github.com
          User Ellipse0934
          IdentityFile ~/.ssh/github
      Host Nextcloud
          Hostname nc.aditya.in 
          User ec2-user
          IdentityFile ~/.ssh/lightsail.pem
    '';
  };
  
 # home.packages.vimPlugins.image-nvim.overrideAttrs = (oa: {
 #   propagatedBuildInputs = with pkgs; [
 #     lua
 #     luajitPackages.magick
 #   ];
 # });

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
