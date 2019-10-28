
-- == [[   NetMon -> Autorun   ]] == --
-- by TASSIA

if SERVER and (ConVarExists("netmon") and GetConVar("netmon"):GetBool()) then
	include('netmon/init.lua')
end
