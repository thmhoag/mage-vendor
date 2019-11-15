local MV = MageVendor
local Events = MV.Events

function MV:OnEvent(_, event, ...)
    if self.Events[event] then
        self.Events[event](self, ...)
    end
end

MV.Frame = CreateFrame("Frame")

for k,_ in pairs(MV.Events) do
    MV.Frame:RegisterEvent(k)
end

MV.Frame:SetScript("OnEvent", function(_, event, ...) MV:OnEvent(_, event, ...) end)