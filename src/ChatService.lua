local _, Addon = ...

local MV = MageVendor
local Events = MV.Events

function Events:CHAT_MSG_SAY(...)
	processChat(...)
end

function Events:CHAT_MSG_YELL(...)
	processChat(...)
end

function Events:CHAT_MSG_WHISPER(...)
	processChat(...)
end

function processChat(...)
	local timestamp = time()

	if not MV.Options.Enabled then return end
	if not select(12, ...) then return end -- don't use player-less chat events

	playerInfo = {GetPlayerInfoByGUID(select(12, ...))}
	playerClass = playerInfo[2]
	if string.lower(playerClass) == "mage" then return end -- don't allow mages

	text = select(1, ...)
	wantsPort = checkWantsPort(text)
	if not wantsPort then
		return
	end

	playerName = playerInfo[6]
	MV:Msg("Player " .. playerName .. " wants port!")

	if not canInvite() then
		MV.Error("Unable to invite " .. playerName .. "!")
		return
	end

	InviteUnit(playerName)
end

function checkWantsPort(msg)
	if(msg ~= "") then msg = string.lower(msg) end;
	
	containsWtb = string.find(msg, "wtb")
	containsPort = string.find(msg, "port")
	return containsWtb and containsPort
end

function canInvite()
	return not IsInGroup(1) or UnitIsGroupLeader(MV.PlayerName)
end