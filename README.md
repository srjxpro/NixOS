# My-NixOS
- My NixOS configuration with Flakes and Home-manager

# Steps
```
1. Copy configuration.nix to /etc/nixos/configuration.nix
2. Run "sudo nixos-rebuild switch"
3. Make a directory - "mkdir ~/.nixos"
4. Run "nix flake init" and "nix run home-manager/master -- init --switch ."
5. Copy /etc/nixos modules:
   - "sudo cp /etc/nixos/configuration.nix ." and
   - "sudo cp /etc/nixos/hardware-configuration.nix ."
6. Edit flake.nix and then configuration.nix - **remove xserver from service.desktop and display manager.
7. Edit home.nix
8. Finally run "sudo nixos-rebuild switch --flake ."
9. And We're good to go.
```
