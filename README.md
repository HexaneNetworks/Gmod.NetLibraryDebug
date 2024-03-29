# Gmod Net Library Debug
A lua script to debug/print net messages and console commands in Garry's Mod. 

## Installation Instructions
1. Download the latest release from https://github.com/HexaneNetworks/Gmod.NetLibraryDebug/releases
2. Extract the `Gmod.NetLibraryDebug` folder from the compressed file and upload it to your addons folder on your server.
3. Restart the server and you'll start to see the net messages appear. These are normal. Keep the script on the server and check back to your console when you believe one is being abused. 

## What does this do?
This script prints net messages and ran console commands to your server's console to allow you to debug issues such as net exploits which are commonly abused if an addon is written poorly.

## How can I tell if there's an issue?
Most of the time, if a player is attempting to run a net message crash exploit, it'll simply spam the vulnerable net message which will be obvious in the console. 

## If I find a net message exploit, how can I fix it?
Simply removing the addon or fixing the code will solve it. 

## Example Output

```
ServerLog: Player 'Hyro' (STEAM_0:1:53406071) (IP:27005) has executed this command: gm_spawn args:  models/props_lab/filecabinet02.mdl 0.00 000000000. 
ServerLog: Player 'Hyro' (STEAM_0:1:53406071) (IP:27005) has executed this command: gm_spawn args:  models/props_trainstation/clock01.mdl 0.00 000000000. 
ServerLog: Player 'Hyro' (STEAM_0:1:53406071) (IP:27005) has executed this command: gm_spawn args:  models/props_trainstation/TrackSign02.mdl 0.00 000000000. 
ServerLog: Player 'Hyro' (STEAM_0:1:53406071) (IP:27005) has executed this command: gm_spawn args:  models/props_junk/MetalBucket01a.mdl 0.00 000000000. 
ServerLog: Player 'Hyro' (STEAM_0:1:53406071) (IP:27005) has executed this command: gm_spawn args:  models/props_interiors/ElevatorShaft_Door01a.mdl 0.00 000000000. 
ServerLog: Player 'Hyro' (STEAM_0:1:53406071) (IP:27005) has executed this command: gmod_undo args: None. 
ServerLog: Player 'Hyro' (STEAM_0:1:53406071) (IP:27005) has executed this command: gmod_tool args:  balloon. 
ServerLog: Player 'Hyro' (STEAM_0:1:53406071) (IP:27005) has executed this command: gmod_tool args:  button. 
ServerLog: Player 'Hyro' (STEAM_0:1:53406071) (IP:27005) has executed this command: gmod_tool args:  duplicator. 
ServerLog: Player 'Hyro' (STEAM_0:1:53406071) (IP:27005) has executed this command: gmod_tool args:  dynamite. 
ServerLog: Player 'Hyro' (STEAM_0:1:53406071) (IP:27005) has executed this command: gmod_tool args:  emitter. 
ServerLog: Net message 'properties' (3) received (0.01kb (15b)) Client: Hyro (STEAMID: STEAM_0:1:53406071)
```

## Versions

### Current Version: 2.4

### 2.4 (13 May 2023)
- Updated the folder structure

### 2.3 (08 October 2020)
- Pass the argument string (argStr)

### 2.2 (19 March 2020)
- Raised Threshold for antinetspam

### 2.1 (19 March 2020)
- Added Player IP Logging

### 2.0 (19 March 2020)
- Complete Code Revamp

### 1.0 (28 June 2019)
- Initial Release

## Note
Some DRM's included with addons (specifically with gmodstore scripts) won't work when this script is installed on your server. If you experience issues with a DRM conflicting with this script, you'll have to remove this script or temporary disable the addon with DRM. "Xeon" DRM commonly abruptly breaks with scripts like these. 
