util.AddNetworkString("war_panel")
util.AddNetworkString("declare_war")
util.AddNetworkString("end_war")

hook.Add("ShowHelp", "open_war_panel", function(ply)
    net.Start("war_panel")
    net.Send(ply)
end)

net.Receive("declare_war", function(len, ply) 
    local teamDeclaring = net.ReadString() 
    local teamReceiving = net.ReadString()
    local reason = net.ReadString()
    if teamDeclaring == "United States Marine" or teamDeclaring == "PLA Soldier" or teamDeclaring == "Russian Soldier" then
        PrintMessage(HUD_PRINTTALK, teamDeclaring .. " (" .. ply:GetName() .. ")" .. " has declared war on " .. teamReceiving .. " for: " .. reason)
    else
        ply:PrintMessage(HUD_PRINTTALK, "You must be a member of an army to declare war")
    end

    timer.Simple(1800, function()
        PrintMessage(HUD_PRINTTALK, "War between " .. teamDeclaring .. " and " .. teamReceiving .. " is now over!")
    end)
end)

net.Receive("end_war", function(len, ply) 
    local teamDeclaring = net.ReadString() 
    local teamReceiving = net.ReadString()
    if teamDeclaring == "United States Marine" or teamDeclaring == "PLA Soldier" or teamDeclaring == "Russian Soldier" then
        PrintMessage(HUD_PRINTTALK, teamDeclaring .. " (" .. ply:GetName() .. ")" .. " has ended their war on " .. teamReceiving)
    else
        ply:PrintMessage(HUD_PRINTTALK, "You must be a member of an army to end war")
    end
end)