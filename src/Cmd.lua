MageVendor.Command = {
    Slash = {
        "magevendor",
        "mv"
    },
    Commands = {}
}

local MV = MageVendor
local Cmd = MV.Command

-- Argument #1 (command) can be either string or a table.
function Cmd:Register(command, func)
    if type(command) == "string" then
        command = {command}
    end
    for _,v in pairs(command) do
        if not self:HasCommand(v) then
            if v ~= "__DEFAULT__" then v = v:lower() end
            self.Commands[v] = func
        end
    end
end

function Cmd:HasCommand(command)
    for k,_ in pairs(self.Commands) do
        if k == command then return true end
    end
    return false
end

function Cmd:GetCommand(command)
    local cmd = self.Commands[command]
    if cmd then return cmd else return self.Commands["__DEFAULT__"] end
end

function Cmd:HandleCommand(command, args)
    local cmd = self:GetCommand(command)
    if cmd then
        cmd(args)
    else
        MV:Msg(("%q is not a valid command."):format(command))
    end
end

Cmd:Register("__DEFAULT__", function(args)
    MV:Msg("v" .. MV.Version .. "  -- /mv help for more info")
end)

Cmd:Register({"version", "v"}, function(args)
    MV:Msg("v" .. MV.Version)
end)

Cmd:Register({"help", "h"}, function(args)
    MV:Msg("Welcome to MageVendor!")
    MV:Msg("/mv toggle - Toggle on/off")
    MV:Msg("/mv status - Print current status")
    MV:Msg("/mv version - Print version")
    MV:Msg("/mv help - Print this help message")
end)


Cmd:Register({"toggle"}, function(args)
    MV.Options.Enabled = not MV.Options.Enabled
    MV:AnnounceStatus()
end)

Cmd:Register({"enable", "on"}, function(args)
    MV.Options.Enabled = true
    MV:AnnounceStatus()
end)

Cmd:Register({"disable", "off"}, function(args)
    MV.Options.Enabled = false
    MV:AnnounceStatus()
end)

Cmd:Register({"status"}, function(args)
    MV:AnnounceStatus()
end)

for i,v in ipairs(Cmd.Slash) do
    _G["SLASH_" .. MV.Name .. i] = "/" .. v
end

SlashCmdList[MV.Name] = function(msg, editBox)
    msg = MV.Tools:Trim(msg)
    local args = MV.Tools:Split(msg)
    local cmd = args[1]
    local t = {}
    if #args > 1 then
        for i=2,#args do
            table.insert(t, args[i])
        end
    end
    Cmd:HandleCommand(cmd, t)
end