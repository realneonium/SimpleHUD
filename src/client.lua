local NDCore = nil
if GetResourceState("ND_Core") == "started" then
    NDCore = exports["ND_Core"]
end

local cash = ""
local bank = ""

function text(text, x, y, scale, font)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextOutline()
    SetTextJustification(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

if NDCore then
    AddEventHandler("playerSpawned", function()
        local selectedCharacter = NDCore.getPlayer()
        if not selectedCharacter then return end
        cash = selectedCharacter.cash
        bank = selectedCharacter.bank
    end)

    AddEventHandler("onResourceStart", function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then return end
        Wait(3000)
        local selectedCharacter = NDCore.getPlayer()
        if not selectedCharacter then return end
        cash = selectedCharacter.cash
        bank = selectedCharacter.bank
    end)

    RegisterNetEvent("ND:setCharacter")
    AddEventHandler("ND:setCharacter", function(character)
        local selectedCharacter = character
        if not selectedCharacter then return end
        cash = selectedCharacter.cash
        bank = selectedCharacter.bank
    end)

    RegisterNetEvent("ND:updateCharacter")
    AddEventHandler("ND:updateCharacter", function(character)
        local selectedCharacter = character
        if not selectedCharacter then return end
        cash = selectedCharacter.cash
        bank = selectedCharacter.bank
    end)

    RegisterNetEvent("ND:updateMoney")
    AddEventHandler("ND:updateMoney", function(updatedCash, updatedBank)
        cash = updatedCash
        bank = updatedBank
    end)
end

CreateThread(function()
    while true do
        Wait(0)
        if NDCore then
            text("💵", 0.885, 0.028, 0.35, 7)
            text("💳", 0.885, 0.068, 0.35, 7)
            text("~g~$~w~".. cash, 0.91, 0.03, 0.55, 7)
            text("~b~$~w~".. bank, 0.91, 0.07, 0.55, 7)
        end
    end
end)
