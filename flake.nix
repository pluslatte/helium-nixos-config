{
  description = "helium-nixos-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
        "${host}" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit system;
            inherit host;
            inherit username;
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
