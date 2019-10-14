
-- == [[   NetMon -> Incoming   ]] == --
-- by TASSIA





-- == net.Incoming Function == --
function net.Incoming(len, client)

	local id = net.ReadHeader()
	local name = util.NetworkIDToString(id)

	if not name then
		return
	end

	len = len - 16

	netmon.LogReceive(name, len, client)

	local receiver = net.Receivers[string.lower(name)]
	if not receiver then
		return
	end

	receiver(len, client)

end
-- == net.Incoming Function == --
