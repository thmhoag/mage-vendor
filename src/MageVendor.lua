MageVendor = {
    Name = GetAddOnMetadata("MageVendor", "Title"),
	Version = GetAddOnMetadata("MageVendor", "Version"),
	Events = {},
	Options = {}
}

local MV = MageVendor

function MV:Msg(msg)
    DEFAULT_CHAT_FRAME:AddMessage("\124cff40E0D0[" .. self.Name .. "]\124r " .. msg)
end

function MV:Error(msg)
    MV.Msg("\124cffFA8072" .. msg .. "\124r")
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

    -- always start disabled for now
    self.Options.Enabled = false

    if type(self.Options.MarkWhenGrouped) ~= "boolean" then
        self.Options.MarkWhenGrouped = true
	end

    self.PlayerName = UnitName("player")
    self:Msg("AddOn Loaded! - v" .. self.Version)
end
