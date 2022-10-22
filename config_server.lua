NDCore = exports["ND_Core"]:GetCoreObject()

function addMoney(source, amount)
    NDCore.Functions.AddMoney(amount, source, "cash")
end

function notifyCops(coords)
    local players = NDCore.Functions.GetPlayers()
    local departments = {
        ["SAHP"] = true,
        ["LSPD"] = true,
        ["BCSO"] = true
    }

    for player, playerData in pairs(players) do
        if departments[playerData.job] then
            TriggerClientEvent("ND_ATMRobbery:ReportRobbery", player, coords)
        end
    end
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

function notifyCops(coords)
    if not street then return end
    local players = NDCore.Functions.GetPlayers()
    local departments = {
        ["SAHP"] = true,
        ["LSPD"] = true,
        ["BCSO"] = true
    }

    for player, playerData in pairs(players) do
        if departments[playerData.job] then
            TriggerClientEvent("ND_ATMRobbery:ReportRobbery", player, coords)
        end
    end
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

function notifyCops(coords)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local job = xPlayer.getJob()
        if job == "police" then
            TriggerClientEvent("ND_ATMRobbery:ReportRobbery", xPlayers[i], coords)
        end
    end
end


-------------------------------------------------------------------------------
--                           QB FRAMEWORK                                    --
-------------------------------------------------------------------------------
QBCore = exports["qb-core"]:GetCoreObject()

function addMoney(source, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        Player.Functions.AddMoney("cash", amount, "ATM Robbery")
    end
end

function notifyCops(coords)
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            TriggerClientEvent("ND_ATMRobbery:ReportRobbery", v.PlayerData.source, coords)
        end
    end
end


]]
