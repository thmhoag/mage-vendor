MageVendor = {
    Name = GetAddOnMetadata("MageVendor", "Title"),
	Version = GetAddOnMetadata("MageVendor", "Version"),
	Events = {},
	Options = {}
}

local MV = MageVendor

function MV:Msg(msg)
    DEFAULT_CHAT_FRAME:AddMessage("\124cff00FF00[" .. self.Name .. "]\124r " .. msg)
end

function MV:AnnounceStatus()
    if MV.Options.Enabled then
        MV:Msg("Enabled!")
    else
        MV:Msg("Disabled!")
    end
end

function MV.Events.ADDON_LOADED(self, ...)
    local name = (select(1, ...))
    if name ~= MV.Name then return end
    if type(_G["MAGEVENDOR"]) ~= "table" then
        _G["MAGEVENDOR"] = {}
    end
    self.Options = _G["MAGEVENDOR"]
    if type(self.Options.Enabled) ~= "boolean" then
        self.Options.Enabled = false
	end

    self.PlayerName = UnitName("player")
    self:Msg("AddOn Loaded! - v" .. self.Version)
end
