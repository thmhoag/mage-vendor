local _, Addon = ...

local MV = MageVendor
local Events = MV.Events

function Events:CHAT_MSG_SAY(...)
	local timestamp = time()

	if not MV.Options.Enabled then return end
	if not select(12, ...) then return end -- don't use player-less chat events

	playerInfo = {GetPlayerInfoByGUID(select(12, ...))}
	text = select(1, ...)
	wantsPort = checkWantsPort(text)
	if not wantsPort then
		return
	end

	playerName = playerInfo[6]
	MV:Msg("Player " .. playerName .. " wants port!")
	InviteUnit(playerName)
end

function checkWantsPort(msg)
	if(msg ~= "") then msg = string.lower(msg) end;
	
	containsWtb = string.find(msg, "wtb")
	containsPort = string.find(msg, "port")
	return containsWtb and containsPort
end
