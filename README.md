# Disable-Radar
A source mod plugin simply made to remove the radar on the top right section in game.

## Game Supported
- CS:GO

## ConVars
- sm_disableradar_enabled - Should we show radar on top-left. (0 off, 1 on)

## How to Install
- Donwload Disable-Radar and decompile the .zip, then add Disable-Radar.smx in /csgo/addons/sourcemod/plugins

## Updates

| Version | Change-Log          |
| ------- | ------------------ |
| 4.2.0   | Added if (client && GetClientTeam(client) > 1 || GetClientTeam(client) < 1) |
