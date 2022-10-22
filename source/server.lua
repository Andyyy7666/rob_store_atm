NDCore = exports["ND_Core"]:GetCoreObject()

local dollarBills = {
    5,
    10,
    20,
    50,
    100
}

RegisterNetEvent("ND_ATMRobbery:rob", function(netid)
    local src = source

    -- check if the atm exists.
    local count = 0
    local atm = NetworkGetEntityFromNetworkId(netid)
    while not atm do
        Wait(10)
        atm = NetworkGetEntityFromNetworkId(netid)
        count = count + 1
        if count == 100 then return end
    end
    if not atm or not DoesEntityExist(atm) then return end

    -- get the atm coords and the players ped.
    local coords = GetEntityCoords(atm)
    local ped = GetPlayerPed(src)
    if not ped or not coords then return end

    -- reward money every 1.5 seconds for 15 seconds if they're near the atm.
    local player = NDCore.Functions.GetPlayer(src)
    for i=1, 10 do
        local pedCoords = GetEntityCoords(GetPlayerPed(src))
        if #(pedCoords - coords) < 3.5 then
            local amount = dollarBills[math.random(1, #dollarBills)]
            addMoney(src, amount)
        end
        Wait(1500)
    end
end)