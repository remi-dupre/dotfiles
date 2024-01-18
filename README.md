**Unmaintained : I moved to NixOS : https://github.com/remi-dupre/nix-config**

Crontab
-------

```crontab
@reboot /home/remi/scripts/update-wallpaper.py
```


Custom services
---------------

```
systemctl enable --user --now protonmail-bridge
```
