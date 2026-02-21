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
              eza
              fd
              ripgrep
              fzf
              zoxide
              delta
              lazygit
              yazi
              stow
              tmux
              starship

              # Fonts
              nerd-fonts.monaspace

              # Editor
              neovim

              # LSP
              lua-language-server          # lua
              ty                           # python
              rust-analyzer                # rust
              typescript-language-server   # js/ts
              vscode-langservers-extracted # json/html/css
              markdown-oxide               # markdown
              yaml-language-server         # yaml

              # Formatters
              stylua                       # lua
              prettierd                    # js/ts/json/html/css/md/yaml

              # Linters
              eslint_d                     # js/ts
              ruff                         # python
            ];
          };
        });
    };
}
