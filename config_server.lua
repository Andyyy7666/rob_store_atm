NDCore = exports["ND_Core"]:GetCoreObject()

function addMoney(source, amount)
    NDCore.Functions.AddMoney(amount, source, "cash")
end




--[[
-------------------------------------------------------------------------------
--                           OX Inventory                                    --
-------------------------------------------------------------------------------
function addMoney(source, amount)
    exports.ox_inventory:AddItem(source, "money", amount)
end


-------------------------------------------------------------------------------
--                           ND FRAMEWORK                                    --
-------------------------------------------------------------------------------
NDCore = exports["ND_Core"]:GetCoreObject()

function addMoney(source, amount)
    NDCore.Functions.AddMoney(amount, source, "cash")
end


-------------------------------------------------------------------------------
--                           ESX FRAMEWORK                                   --
-------------------------------------------------------------------------------
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function addMoney(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(amount)
end


-------------------------------------------------------------------------------
--                           QB FRAMEWORK                                    --
-------------------------------------------------------------------------------
QBCore = exports["qb-core"]:GetCoreObject()
local Player = QBCore.Functions.GetPlayer(source)
if Player then
    Player.Functions.AddMoney("cash", amount, "ATM Robbery")
end

]]