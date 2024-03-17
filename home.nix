{ config, pkgs, ... }:

let 
  pythonPackages = ps: with ps; [
      jupyter
      ipython
      pylint
      pandas
      matplotlib
      web3
      setuptools
  ];
  user-config = import ./user.nix;
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = user-config.username;
  home.homeDirectory = user-config.homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Adds the 'hello' command to your environment. It prints a friendly
    # "Hello, world!" when run.
    pkgs.hello

    fio
    slack
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.rider
    dotnet-sdk_7
    xclip

    #(steam.override { extraPkgs = pkgs: [ openssl_1_1 ]; }).run
    #steam-run

    (python3.withPackages pythonPackages)

    nix-index
    tmux
    aria
    jq
  ];



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
  #  /etc/profiles/per-user/amirul/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      l = "ls -l";
      e = "nvim";
      tls = "tmux ls";
      ta = "tmux a -t";
      tn = "tmux new -s";
      cp = "cp --reflink=auto";
      edt = "nvim ~/.config/home-manager/home.nix && home-manager switch";
      edtsh = "nvim shell.nix";
      edtsystem = "sudo nvim /etc/nixos/configuration.nix && sudo nixos-rebuild switch";
      update = "sudo nixos-rebuild switch";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  programs.neovim = {
    enable = true;
  };

  programs.go = {
    enable = true;
    goPath = "go";
  };

  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1v" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
}

