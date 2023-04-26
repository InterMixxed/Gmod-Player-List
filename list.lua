local function CopyToClipboard(text)
    SetClipboardText(text)
end
 
local function AddPlayerToList(list, ply)
    local line = list:AddLine(ply:Nick(), ply:SteamID(), ply:GetUserGroup())
    line.OnRightClick = function()
        local menu = DermaMenu()
        menu:AddOption("Copy Name", function() CopyToClipboard(ply:Nick()) end)
        menu:AddOption("Copy SteamID", function() CopyToClipboard(ply:SteamID()) end)
        menu:AddOption("Copy Role", function() CopyToClipboard(ply:GetUserGroup()) end)
        menu:Open()
    end
end
 
local frame = vgui.Create("DFrame")
frame:SetTitle("Player List")
frame:SetSize(400, 500)
frame:Center()
frame:MakePopup()
 
local list = vgui.Create("DListView", frame)
list:SetSize(frame:GetWide(), frame:GetTall() - 25)
list:SetPos(0, 25)
 
list:AddColumn("Name")
list:AddColumn("SteamID")
list:AddColumn("Role")
 
for _, ply in pairs(player.GetAll()) do
    AddPlayerToList(list, ply)
end
 
concommand.Add("player_list", function()
    frame:SetVisible(true)
end)
