if GetResourceState("ND_Core") == "started" then
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
elseif GetResourceState("es_extended") == "started" then
    ESX = exports['es_extended']:getSharedObject()

    function addMoney(source, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addMoney(amount)
    end

    function notifyCops(coords)
        if not street then return end
        local xPlayers = ESX.GetExtendedPlayers("job", "police")
        for i=1, #xPlayers do
            TriggerClientEvent("ND_ATMRobbery:ReportRobbery", xPlayers[i].source, coords)
        end
    end
elseif GetResourceState("qb-core") == "started" then
    QBCore = exports["qb-core"]:GetCoreObject()

    function addMoney(source, amount)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end
        Player.Functions.AddMoney("cash", amount)
    end

    function notifyCops(coords)
        local players = QBCore.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            if v and v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
                TriggerClientEvent("ND_ATMRobbery:ReportRobbery", v.PlayerData.source, coords)
            end
        end
    end
end