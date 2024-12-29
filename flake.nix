{
  description = "helium, the portable nixOS setup with hyprland in USB SSD stick";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Recommended by hyprland
    # https://www.reddit.com/r/NixOS/comments/1hkr6ir/flake_update_introduced_the_recommended/
    hyprland-qtutils = {
      url = "github:hyprwm/hyprland-qtutils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprpanel the status bar
    # Version pinned.
    # https://github.com/Jas-SinghFSU/HyprPanel/issues/655
    # https://github.com/Jas-SinghFSU/HyprPanel/issues/666
    hyprpanel = {
      url = "github:jas-singhfsu/hyprpanel/ba7e0dfd52172c9c63ee11da689dce49cf76ae1f";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theme control
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
