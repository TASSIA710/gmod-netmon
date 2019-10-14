
-- == [[   NetMon -> Initialization   ]] == --
-- by TASSIA

netmon = {}



-- Create file
file.CreateDir('netmon')
netmon.fileText = file.Open('netmon/'..os.date('!%d-%m-%y %H-%M-%S')..'_plain.txt', 'a', 'DATA')
netmon.fileBinary = file.Open('netmon/'..os.date('!%d-%m-%y %H-%M-%S')..'_binary.txt', 'ab', 'DATA')



-- Create flush timer
timer.Create('FlushNetMonFiles', 10, 0, function()
	netmon.fileText:Flush()
	netmon.fileBinary:Flush()
end)



-- Include files
include('incoming.lua')
include('start_send.lua')



-- Define constants
local TYPE_LOG_RECEIVE = 0x4A
local TYPE_LOG_SEND = 0x4B
local TYPE_LOG_SEND_OMIT = 0x4C





-- == Utility Functions == --
local function playerToString(ply)
	return ply:Nick() .. ' (' .. ply:UserID() .. '/' .. ply:SteamID() .. '/' .. ply:IPAddress() .. ')'
end
-- == Utility Functions == --





-- == LogSend Function == --
function netmon.LogSend(message, length, clients)

	local messageBytes = {string.byte(message)}



	netmon.fileBinary:WriteByte(TYPE_LOG_SEND)
	netmon.fileBinary:WriteDouble(SysTime())
	netmon.fileBinary:WriteUShort(length)

	netmon.fileBinary:WriteByte(table.Count(messageBytes))
	for i = 1, table.Count(messageBytes) do
		netmon.fileBinary:WriteByte(messageBytes[i])
	end

	netmon.fileBinary:WriteByte(table.Count(clients))
	for _, ply in pairs(clients) do

		local playerNameByte = {string.byte(ply:Nick())}
		local playerSteamIDBytes = {string.byte(ply:SteamID())}
		local playerIPAddressBytes = {string.byte(ply:IPAddress())}
		local playerUserID = ply:UserID()

		netmon.fileBinary:WriteByte(table.Count(playerNameByte))
		for i = 1, table.Count(playerNameByte) do
			netmon.fileBinary:WriteByte(playerNameByte[i])
		end

		netmon.fileBinary:WriteByte(table.Count(playerSteamIDBytes))
		for i = 1, table.Count(playerSteamIDBytes) do
			netmon.fileBinary:WriteByte(playerSteamIDBytes[i])
		end

		netmon.fileBinary:WriteByte(table.Count(playerIPAddressBytes))
		for i = 1, table.Count(playerIPAddressBytes) do
			netmon.fileBinary:WriteByte(playerIPAddressBytes[i])
		end

		netmon.fileBinary:WriteUShort(playerUserID)

	end



	netmon.fileText:Write('['..os.date('!%d-%m-%y %H-%M-%S')..'] -> '..message..'\n')
	print('['..os.date('!%d-%m-%y %H-%M-%S')..'] -> '..message)

end
-- == LogSend Function == --





-- == LogReceive Function == --
function netmon.LogReceive(message, length, client)

	local messageBytes = {string.byte(message)}
	local playerNameByte = {string.byte(client:Nick())}
	local playerSteamIDBytes = {string.byte(client:SteamID())}
	local playerIPAddressBytes = {string.byte(client:IPAddress())}
	local playerUserID = client:UserID()



	netmon.fileBinary:WriteByte(TYPE_LOG_RECEIVE)
	netmon.fileBinary:WriteDouble(SysTime())
	netmon.fileBinary:WriteUShort(length)

	netmon.fileBinary:WriteByte(table.Count(messageBytes))
	for i = 1, table.Count(messageBytes) do
		netmon.fileBinary:WriteByte(messageBytes[i])
	end

	netmon.fileBinary:WriteByte(table.Count(playerNameByte))
	for i = 1, table.Count(playerNameByte) do
		netmon.fileBinary:WriteByte(playerNameByte[i])
	end

	netmon.fileBinary:WriteByte(table.Count(playerSteamIDBytes))
	for i = 1, table.Count(playerSteamIDBytes) do
		netmon.fileBinary:WriteByte(playerSteamIDBytes[i])
	end

	netmon.fileBinary:WriteByte(table.Count(playerIPAddressBytes))
	for i = 1, table.Count(playerIPAddressBytes) do
		netmon.fileBinary:WriteByte(playerIPAddressBytes[i])
	end

	netmon.fileBinary:WriteUShort(playerUserID)



	netmon.fileText:Write('['..os.date('!%d-%m-%y %H-%M-%S')..'] <- '..message..'\n')
	print('['..os.date('!%d-%m-%y %H-%M-%S')..'] <- '..message)

end
-- == LogReceive Function == --
