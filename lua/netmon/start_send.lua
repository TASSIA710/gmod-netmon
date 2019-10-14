
-- == [[   NetMon -> Start & Send   ]] == --
-- by TASSIA

local started





-- == net.Start Function == --
local start = net.Start

function net.Start(messageName, unreliable)

	-- Call the original function
	start(messageName, unreliable)

	started = messageName

end
-- == net.Start Function == --





-- == net.Send Function == --
local send = net.Send

function net.Send(ply)

	-- Call the original function
	send(ply)

	local clients
	if istable(ply) then clients = ply
	elseif isentity(ply) then clients = {ply}
	else clients = {} end

	netmon.LogSend(started, (net.BytesWritten() or 0)*8, clients)

end
-- == net.Send Function == --





-- == net.SendOmit Function == --
local sendOmit = net.SendOmit

function net.SendOmit(ply)

	-- Call the original function
	sendOmit(ply)

	netmon.LogSend(started, (net.BytesWritten() or 0)*8, {})

end
-- == net.SendOmit Function == --





-- == net.SendPAS Function == --
local sendPAS = net.SendPAS

function net.SendPAS(position)

	-- Call the original function
	sendPAS(position)

	netmon.LogSend(started, (net.BytesWritten() or 0)*8, {})

end
-- == net.SendPAS Function == --





-- == net.SendPVS Function == --
local sendPVS = net.SendPVS

function net.SendPVS(position)

	-- Call the original function
	sendPVS(position)

	netmon.LogSend(started, (net.BytesWritten() or 0)*8, {})

end
-- == net.SendPVS Function == --





-- == net.Broadcast Function == --
local broadcast = net.Broadcast

function net.Broadcast()

	-- Call the original function
	broadcast()

	netmon.LogSend(started, (net.BytesWritten() or 0)*8, {})

end
-- == net.Broadcast Function == --
