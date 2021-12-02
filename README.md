Crontab
-------

```crontab
@reboot /home/remi/scripts/update-wallpaper.py
```


Custom services
---------------

```
systemctl enable --user --now protonmail-bridge
systemctl enable --user --now mpris-proxy
systemctl enable --user --now nm-applet
```
