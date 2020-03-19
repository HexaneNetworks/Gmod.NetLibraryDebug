-- Gmod Net Library Debug
-- https://github.com/HexaneNetworks/gmod-netlibrary-debug
-- v2.1
-- March 2020

hexanenetlibrarydebug = hexanenetlibrarydebug or {}

hexanenetlibrarydebug.antiNetSpam = {}
hexanenetlibrarydebug.flaggedNetPlayers = {}

hexanenetlibrarydebug.antiConSpam = {}
hexanenetlibrarydebug.flaggedConPlayers = {}

hexanenetlibrarydebug.net = {
    "UKT_MOMOS", "Sandbox_ArmDupe", "Fix_Keypads", "memeDoor",
    "Remove_Exploiters", "noclipcloakaesp_chat_text", "fellosnake", "NoNerks",
    "BackDoor", "kek", "OdiumBackDoor", "cucked", "ULogs_Info", "Ulib_Message",
    "m9k_addons", "Sbox_itemstore", "rcivluz", "Sbox_darkrp", "_Defqon", "something",
    "random", "strip0", "killserver", "DefqonBackdoor", "fuckserver", "cvaraccess",
    "rconadmin", "_CAC_ReadMemory", "nostrip", "DarkRP_AdminWeapons",
    "enablevac", "SessionBackdoor", "LickMeOut", "MoonMan", "Im_SOCool", "fix",
    "idk", "ULXQUERY2", "ULX_QUERY2", "jesuslebg", "zilnix", "ÃžÃ ?D)â—˜",
    "disablebackdoor", "oldNetReadData", "SENDTEST", "Sandbox_GayParty",
    "nocheat", "_clientcvars", "_main", "ZimbaBackDoor", "stream", "waoz", "DarkRP_UTF8",
    "bdsm", "ZernaxBackdoor", "anticrash", "audisquad_lua", "dontforget", "noprop", "thereaper",
    "0x13"
}

timer.Create("hexanenetlibrarydebug.CleanSpam", 1,0, function()
    hexanenetlibrarydebug.antiNetSpam = {}
    hexanenetlibrarydebug.flaggedNetPlayers = {}

    hexanenetlibrarydebug.antiConSpam = {}
    hexanenetlibrarydebug.flaggedConPlayers = {}
end)

function net.Incoming(len, client)
    local i = net.ReadHeader()
    local name = util.NetworkIDToString(i)

    if not name then
        return
    end

    local plySteamid = IsValid(client) and client:SteamID() or "UNKNOWN STEAMID"
    local plyNick = IsValid(client) and client:Nick() or "UNKNOWN PLAYER NAME"
    local plyIP = IsValid(client) and client:IPAddress() or "UNKNOWN IP"

    local antiNetSpam = hexanenetlibrarydebug.antiNetSpam
    local flaggedNetPlayers = hexanenetlibrarydebug.flaggedNetPlayers

    antiNetSpam[plySteamid] =  antiNetSpam[plySteamid] or {}
    antiNetSpam[plySteamid][name] = (antiNetSpam[plySteamid][name] or 0) + 1

    if antiNetSpam[plySteamid][name] > 10 then 

        if not flaggedNetPlayers[plySteamid] then 
            ServerLog(string.format("Net spam attempted on Net Message: %s Client: %s (STEAMID: %s) (IP: %s) \n", name, plyNick, plySteamid, plyIP))
        end

        flaggedNetPlayers[plySteamid] = true
    end

    local func = net.Receivers[name:lower()]

    if not func then
        ServerLog(string.format("No receiving function for '%s' (net msg #%d) Client: %s (STEAMID: %s) (IP: %s) \n", name, i, plyNick, plySteamid, plyIP))
        return
    end

    len = len - 16

    local curString = !table.HasValue(hexanenetlibrarydebug.net, name) and "Net message '%s' (%d) received (%.2fkb (%db)) Client: %s (STEAMID: %s) (IP: %s) \n" or "Net message '%s' (%d) received (%.2fkb (%db)) Client: %s (STEAMID: %s) (IP: %s) [ Exploitable String ] \n"
 
    ServerLog(string.format(curString, name, i, len/8/1024, len/8, plyNick, plySteamid, plyIP))

    local status, error = pcall( function() func(len, client) end )
    
    if not status then
        ServerLog(string.format("Error during net message (%s). Reasoning: %s \n", name, error))
    end

end

hexanenetlibrarydebug.crun = hexanenetlibrarydebug.crun or concommand.Run

function concommand.Run(ply, cmd, args)
    if !IsValid(ply) then return hexanenetlibrarydebug.crun(ply,cmd,args) end
    if !cmd then return hexanenetlibrarydebug.crun(ply,cmd,args) end
    
    local plySteamid = IsValid(ply) and ply:SteamID() or "UNKNOWN STEAMID"
    local plyNick = IsValid(ply) and ply:Nick() or "UNKNOWN PLAYER NAME"
    local plyIP = IsValid(ply) and ply:IPAddress() or "UNKNOWN IP"

    local antiConSpam = hexanenetlibrarydebug.antiConSpam
    local flaggedConPlayers = hexanenetlibrarydebug.flaggedConPlayers

    antiConSpam[plySteamid] =  antiConSpam[plySteamid] or {}
    antiConSpam[plySteamid][cmd] = (antiConSpam[plySteamid][cmd] or 0) + 1

    local temp = (args and args ~= "" and #args != 0) and " "..table.concat(args, " ") or "None"

    if antiConSpam[plySteamid][cmd] > 10 then 
        
        if not flaggedConPlayers[plySteamid] then 
            ServerLog("Player " .. "'"..plyNick.."'" .. " ("..plySteamid.. ") " .. "("..plyIP..")" .. " has attempted to concommand spam with command: " .. cmd .. " args: " .. temp .. ". \n")
        end

        flaggedConPlayers[plySteamid] = true
    end

    ServerLog("Player " .. "'"..plyNick.."'" .. " ("..plySteamid.. ") " .. "("..plyIP..")" .. " has executed this command: " .. cmd .. " args: " .. temp .. ". \n")


    return hexanenetlibrarydebug.crun(ply, cmd, args)
end
