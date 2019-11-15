local MV = MageVendor

MV.OptionsFrame = {
    Panel = CreateFrame("Frame")
}

local Opt = MV.OptionsFrame
local panel = Opt.Panel

panel.name = MV.Name
panel:Hide()

-- Dirty hack to give a name to option checkboxes
local checkCounter = 0

local function checkbox(label, description, onclick)
    local check = CreateFrame("CheckButton", "MageVendorOptCheck" .. checkCounter, panel, "InterfaceOptionsCheckButtonTemplate")
    check:SetScript("OnClick", function(self)
        local checked = self:GetChecked()
        PlaySound(checked and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
        onclick(self, checked and true or false)
    end)
    check.label = _G[check:GetName() .. "Text"]
    check.label:SetText(label)
    check.tooltipText = label
    check.tooltipRequirement = description
    checkCounter = checkCounter + 1
    return check
end

local function button(text, tooltip, onclick)
    local btn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    btn:SetText(text)
    btn.tooltipText = tooltip
    btn:SetScript("OnClick", function(self) onclick(self) end)
    btn:SetHeight(24)
    return btn
end

local function HideBlizzOptions()
    HideUIPanel(InterfaceOptionsFrame)
    HideUIPanel(GameMenuFrame)
end

function Opt:Open()
    ShowUIPanel(InterfaceOptionsFrame)
    InterfaceOptionsFrame_OpenToCategory(panel)
end

function Opt:Show()
    local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(MV.Name)

    local mvEnabled = checkbox("Enable",
        "Turns automated invites on or off (defaults to disabled on startup)",
        function(check, checked)
            MV.Options.Enabled = checked
        end)
    mvEnabled:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -16)

    local function init()
        mvEnabled:SetChecked(MV.Options.Enabled)
    end

    init()

    self:SetScript("OnShow", init)
end

panel:SetScript("OnShow", function(self) Opt.Show(self) end)

InterfaceOptions_AddCategory(panel)
