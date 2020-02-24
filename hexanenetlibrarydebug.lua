-- Gmod Net Library Debug
-- https://github.com/HexaneNetworks/gmod-netlibrary-debug
-- June 2019

hexanenetlibrarydebug = hexanenetlibrarydebug or {}

hexanenetlibrarydebug.antiNetSpam = {}
hexanenetlibrarydebug.flaggedPlayers = {}

timer.Create("CleanNetSpam", 1,0, function()
    hexanenetlibrarydebug.antiNetSpam = {}
    hexanenetlibrarydebug.flaggedPlayers = {}
end)

function net.Incoming(len, client)
		local i = net.ReadHeader()
		local name = util.NetworkIDToString(i)

		if not(name) and IsValid(client) then
		
			ServerLog(string.format("Unpooled message name for net msg #%d Client: %s (STEAMID: %s) \n", i, client:Nick(), client:SteamID()))
			
			return
			
		elseif not(name) then
		
			return
			
		end

        local plySteamid = client:SteamID()
        --[[ Implement an anti-net spam feature to stop people from attempting to lag the server. ]]--

        antiNetSpam[plySteamid] =  antiNetSpam[plySteamid] or {}
        antiNetSpam[plySteamid][name] = (antiNetSpam[plySteamid][name] or 0) + 1

        if antiNetSpam[plySteamid][name] > 10 and not hexanenetlibrarydebug.flaggedPlayers[plySteamid] then 
            hexanenetlibrarydebug.flaggedPlayers[plySteamid] = true
            ServerLog(string.format("Net spam attempted on Net Message: %s Client: %s (STEAMID: %s) \n", name, client:Nick(), client:SteamID()))
			return
        end

        --[[ Before the client is able to get a response from the target addon. ]]--

		local func = net.Receivers[name:lower()]

		if not(func) and IsValid(client)  then
			
			ServerLog(string.format("No receiving function for '%s' (net msg #%d) Client: %s (STEAMID: %s) \n", name, i, client:Nick(), client:SteamID()))
			return
			
		elseif not(func) then
		
			return
			
		end

		len = len - 16
		
		if not table.HasValue(hexanenetlibrarydebug.net, name) then
		
			if (IsValid(client) and (client.LastMSG or 0) < CurTime() - 0.25) then
				
				ServerLog(string.format("Net message '%s' (%d) received (%.2fkb (%db)) Client: %s (STEAMID: %s) \n", name, i, len/8/1024, len/8, client:Nick(), client:SteamID()))
				client.LastMSG = CurTime()
				
			elseif (client.LastMSG or 0) < CurTime() - 0.25 then
				
				ServerLog(string.format("Net message '%s' (%d) received (%.2fkb (%db)) Client: %s (STEAMID: %s) \n", name, i, len/8/1024, len/8, "UNKNOWN", "UNKNOWN"))
			
			end
			
		else
		
			if (IsValid(client) and (client.LastMSG or 0) < CurTime() - 0.25) then
				
				ServerLog(string.format("Net message '%s' (%d) received (%.2fkb (%db)) Client: %s (STEAMID: %s) [ Exploitable String ] \n", name, i, len/8/1024, len/8, client:Nick(), client:SteamID()))
				client.LastMSG = CurTime()

			elseif (client.LastMSG or 0) < CurTime() - 0.25 then
				
				ServerLog(string.format("Net message '%s' (%d) received (%.2fkb (%db)) Client: %s (STEAMID: %s) [ Exploitable String ] \n" , name, i, len/8/1024, len/8, "UNKNOWN", "UNKNOWN"))
			
			end
		
		end
		
		status, error = pcall( function() func(len, client) end )
		
		if not status then
			
			
			ServerLog(string.format("Error during net message (%s). Reasoning: %s \n", name, error))

	end
end

hexanenetlibrarydebug.crun = hexanenetlibrarydebug.crun or concommand.Run

	function concommand.Run(ply, cmd, args)
		if !IsValid(ply) then return hexanenetlibrarydebug.crun(ply,cmd,args) end
		if !cmd then return hexanenetlibrarydebug.crun(ply,cmd,args) end
		
		if args and args ~= "" and #args != 0 then
		
			ServerLog(ply:Name() .. "( "..ply:SteamID().." )" .. "has executed this command: " .. cmd .. " " .. table.concat(args, " ") .. ". \n")
			
		else
		
			ServerLog(ply:Name() .. "( "..ply:SteamID().." )" .. " has executed this command: " .. cmd .. ". \n")
			
		end
		
		return hexanenetlibrarydebug.crun(ply, cmd, args)
	
end
