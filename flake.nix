{
  description = "Dotfiles packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = pkgs.buildEnv {
        name = "dotfiles-packages";
        paths = with pkgs; [
          bat
          eza
          fd
          ripgrep
          lazygit
          yazi
          zoxide
          delta
          fzf
          neovim
          starship
          tmux
          unison
          fish
          stow
          nerd-fonts.monaspace
        ];
      };
    };
}
