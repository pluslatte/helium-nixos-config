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

    # Hyprpanel
    hyprpanel = {
      url = "github:jas-singhfsu/hyprpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "helium";
      username = "latte";
    in
    {
      nixosConfigurations = {
        "${host}" =
          let
            # Workaround https://stackoverflow.com/questions/77585228/how-to-allow-unfree-packages-in-nix-for-each-situation-nixos-nix-nix-wit
            pkgs = import nixpkgs {
              inherit system;
              config = {
                allowUnfree = true;
                allowUnfreePredicate = _: true;
              };
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit system;
              inherit host;
              inherit username;
              inherit pkgs; # Ensure "same" nixpkgs is used.
            };
            modules = [
              ./nixos/configuration.nix

              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = {
                  inherit system;
                  inherit host;
                  inherit username;
                  hyprland-qtutils = inputs.hyprland-qtutils;
                  hyprpanel = inputs.hyprpanel;
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
