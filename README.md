# Gmod Net Library Debug
A lua script to debug/print net messages and console commands in Garry's Mod. 

## What does this do?
This script prints net messages and ran console commands to your server's console to allow you to debug issues such as net exploits which are commonly abused if an addon is written poorly.

## How can I tell if there's an issue?
Most of the time, if a player is attempting to run a net message crash exploit, it'll simply spam the vunverable net message which will be obvious in the console. 

## If I find a net message exploit, how can I fix it?
Simply removing the addon or fixing the code will solve it. 

## Installation
1. Download the `hexanenetlibrarydebug.lua` script.
2. Add/upload it to your servers `garrysmod/lua/autorun/server` directory.
3. Restart the server and you'll start to see the net messages appear. These are normal. Keep the script on the server and check back to your console when you believe one is being abused. 
