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

function Events:GROUP_JOINED(...)
	markSelf(...)
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

function canInvite()
	return not IsInGroup(1) or UnitIsGroupLeader(MV.PlayerName)
end

function markSelf(...)
	if not MV.Options.MarkWhenGrouped then return end

	SetRaidTarget("player", 8)
end

local buyPhrases = {
	"wtb",
	"can i get",
	"plz",
	"pls",
	"please",
	"buy",
	"lf",
	"need",
	"want"
}

local function msgContainsWtbPhrase(msg)
	for _, p in ipairs(buyPhrases) do
		if string.match(msg, p) ~= nil then
			return true
		end
	end

	return false
end

local portPhrases = {
	"port",
	"tele",
	"teleport",
	"org",
	"orgimmar",
	"tb",
	"thunder bluff",
	"uc",
	"undercity"
}

local function msgContainsPortPhrase(msg)
	for _, p in ipairs(portPhrases) do
		if string.match(msg, p) ~= nil then
			return true
		end
	end

	return false
end

local blackListedPhrases = {
	"wts"
}

local function msgContainsBlackListedPhrase(msg)
	for _, p in ipairs(blackListedPhrases) do
		if string.match(msg, p) ~= nil then
			return true
		end
	end

	return false
end

function checkWantsPort(msg)
	if(msg ~= "") then msg = string.lower(msg) end;
	
	containsWtb = msgContainsWtbPhrase(msg)
	containsPort = msgContainsPortPhrase(msg)
	containsBlackListed = msgContainsBlackListedPhrase(msg)
	return containsWtb and containsPort and not containsBlackListed
end