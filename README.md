# Simple nixos setup

### Installation

1. Replace ``hardware-configuration.nix``.
2. Change configs to your user.
3. Insert host-specific modules (both in nixos and home manager cfgs).
4. Comment custom phpstorm desktop entry in home.nix if you haven't got custom flake.
5. ```
   nixos-rebuild switch --flake .
   home-manager switch --flake .
   ```
