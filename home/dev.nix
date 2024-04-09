###################
# BASIC DEV TOOLS # Use nix shells for specialized tools
###################
{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    bun
    cargo-bloat
    cargo-edit
    cargo-udeps
    clang-tools
    cmake
    gcc
    man-pages
    man-pages-posix
    nix-output-monitor
    nixd
    nixpkgs-fmt
    psmisc
    python3
    ripgrep
    ruff
    (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
      extensions = [
        "clippy"
        "llvm-tools"
        "miri"
        "reproducible-artifacts"
        "rust-analyzer"
        "rust-src"
        "rustc-codegen-cranelift"
        "rustfmt"
      ];
      targets = [
        "wasm32-unknown-unknown"
      ];
    }))
    stack
  ];

  # Terminal emulator
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main.pad = "1x1 center";
      main.selection-target = "clipboard";
      scrollback.lines = 10000;
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };

  # Git
  programs.git = {
    enable = true;

    userName = "Winston Li";
    userEmail = "wli24.personal@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      github.user = "wli24";
      push.autoSetupRemote = true;
    };
  };

  programs.gh.enable = true;

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    coc.enable = true;
    coc.settings = {
      workspace.ignoredFolders = [
        "$HOME"
        "$HOME/.cargo/**"
        "$HOME/.rustup/**"
      ];
    };

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      trouble-nvim

      coc-eslint
      coc-explorer
      coc-clangd
      coc-css
      coc-json
      coc-highlight
      coc-html
      coc-rust-analyzer
      coc-pairs
      coc-pyright
      coc-snippets
      coc-svelte
      coc-tailwindcss
      coc-toml
      coc-tsserver
      coc-yaml

      vim-fugitive
      vim-nix
    ];

    extraLuaConfig = ''
      vim.wo.relativenumber = true
    '';
  };

  programs.tmux.enable = true;

  # Zsh
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      krabby random
    '';
  };
}
