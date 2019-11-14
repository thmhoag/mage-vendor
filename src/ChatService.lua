local _, Addon = ...

local frame, events = CreateFrame("Frame"), {};
function onLoad()
	frame:SetScript("OnEvent", function(self, event, ...)
		events[event](self, ...);
	end);

	for e, v in pairs(events) do
		frame:RegisterEvent(e); -- Register all events for which handlers have been defined
	end
end 

local ChatService = CreateFrame("Frame");
ChatService:SetScript("OnEvent", function(self, event, ...)
	if self[event] then
		self[event](self, ...);
	end
end);

function events:CHAT_MSG_SAY(...)
	local timestamp = time()
	if not select(12, ...) then return end -- don't use player-less chat events

	playerInfo = {GetPlayerInfoByGUID(select(12, ...))}
	text = select(1, ...)
	wantsPort = checkWantsPort(text)
	if not wantsPort then
		return
	end

	playerName = playerInfo[6]
	DEFAULT_CHAT_FRAME:AddMessage("Player " .. playerName .. " wants port!");

	InviteUnit(playerName)
end

function checkWantsPort(msg)
	if(msg ~= "") then msg = string.lower(msg) end;
	
	containsWtb = string.find(msg, "wtb")
	containsPort = string.find(msg, "port")
	return containsWtb and containsPort
end

onLoad()