{
  description = "helium, the portable nixOS setup with hyprland in USB SSD stick";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Recommended by hyprland
    # https://www.reddit.com/r/NixOS/comments/1hkr6ir/flake_update_introduced_the_recommended/
    hyprland-qtutils = {
      url = "github:hyprwm/hyprland-qtutils";
    };

    # Hyprpanel the status bar
    hyprpanel = {
      url = "github:jas-singhfsu/hyprpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theme control
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # My preconfigured neovim
    nixvim = {
      url = "github:pluslatte/nixvim-config";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      host = "helium";
      username = "latte";
    in
    {
      nixosConfigurations = {
        "${host}" =
          let
            # Workaround
            # https://stackoverflow.com/questions/77585228/how-to-allow-unfree-packages-in-nix-for-each-situation-nixos-nix-nix-wit
            pkgs = import nixpkgs {
              inherit system;
              config = {
                allowUnfree = true;
                allowUnfreePredicate = _: true;
              };
              overlays = [
                inputs.hyprpanel.overlay
              ];
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit system;
              inherit host;
              inherit username;
              inherit pkgs; # Ensure "same" nixpkgs being used.
            };
            modules = [
              ./nixos/configuration.nix

              stylix.nixosModules.stylix

              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = {
                  inherit system;
                  inherit host;
                  inherit username;
                  hyprpanel = inputs.hyprpanel;
                  hyprland-qtutils = inputs.hyprland-qtutils;
                  nixvim = inputs.nixvim;
                };
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users."${username}" = import ./home-manager/home.nix;
              }
            ];
          };
      };
    };
}
