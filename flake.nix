{
  description = "System packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "aarch64-darwin" "x86_64-linux" ];
    in {
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in {
          default = pkgs.buildEnv {
            name = "env";
            paths = with pkgs; [
              # CLI
              bat
              btop
              delta
              eza
              fd
              fzf
              jq
              lazygit
              ripgrep
              starship
              stow
              tldr
              tmux
              yazi
              zoxide

              # Fonts
              nerd-fonts.monaspace

              # Editor
              neovim

              # LSP
              lua-language-server          # lua
              markdown-oxide               # markdown
              rust-analyzer                # rust
              ty                           # python
              typescript-language-server   # js/ts
              vscode-langservers-extracted # json/html/css
              yaml-language-server         # yaml

              # Formatters
              prettierd                    # js/ts/json/html/css/md/yaml
              stylua                       # lua

              # Linters
              eslint_d                     # js/ts
              ruff                         # python

              # Tools
              tree-sitter
            ];
          };
        });
    };
}
