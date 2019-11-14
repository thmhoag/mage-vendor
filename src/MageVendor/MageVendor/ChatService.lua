local _, Addon = ...
local version = "0.1.0";

function ChatService_OnLoad(self)
	InitializeEventHandlers()

	SlashCmdList["MageVendor"] = ChatService_SlashHandler;
	SLASH_MageVendor1 = "/magevendor";
	SLASH_MageVendor2 = "/mv";
end

function ChatService_SlashHandler(msg)
	if(msg ~= "") then msg = string.lower(msg) end;
	if(msg == "show") then
		DEFAULT_CHAT_FRAME:AddMessage("MageVendor seems to be present");
	else
		DEFAULT_CHAT_FRAME:AddMessage("MageVendor: v" .. version);
	end
end

local frame, events = CreateFrame("Frame"), {};
function InitializeEventHandlers()
	frame:SetScript("OnEvent", function(self, event, ...)
		events[event](self, ...);
	end);

	for e, v in pairs(events) do
		frame:RegisterEvent(e); -- Register all events for which handlers have been defined
	end
end

function events:PLAYER_ENTERING_WORLD(...)
	DEFAULT_CHAT_FRAME:AddMessage("MageVendor loaded");
end

function events:PLAYER_LEAVING_WORLD(...)
 -- handle PLAYER_LEAVING_WORLD here
end

function events:CHAT_MSG_SAY(...)
	local timestamp = time()
	if not select(12, ...) then return end -- don't use player-less chat events

	playerInfo = {GetPlayerInfoByGUID(select(12, ...))}
	DEFAULT_CHAT_FRAME:AddMessage("Player name found: " .. playerInfo[6]);
end
