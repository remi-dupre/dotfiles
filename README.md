Crontab
-------

```crontab
@reboot /home/remi/scripts/update-wallpaper.py
```


Custom services
---------------

#### ProtonMail

```
systemctl enable --user --now protonmail-bridge
```

#### Bluetooth headset's controls

```
systemctl enable --user --now mpris-proxy
```
