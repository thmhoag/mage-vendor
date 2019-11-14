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
	DEFAULT_CHAT_FRAME:AddMessage("Player name found: " .. playerInfo[6]);
end

onLoad()