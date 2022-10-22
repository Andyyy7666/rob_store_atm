local ATM_DECOR = "DADDY_ANDY"

function SetBrokenATM(atm, status)
    DecorSetBool(atm, ATM_DECOR, status)
end

function GetBrokenATM(atm)
    if not DecorExistOn(atm, ATM_DECOR) then
        return false
    end
	return DecorGetBool(atm, ATM_DECOR)
end

function getPtfx(ptfx)
    while not HasNamedPtfxAssetLoaded(ptfx) do
        RequestNamedPtfxAsset(ptfx)
        Wait(10)
    end
    UseParticleFxAssetNextCall(ptfx)
end

RegisterNetEvent("ND_ATMRobbery:money", function(atm)
    if not DoesEntityExist(atm) then return end

    -- get entity net id.
    local count = 0
    local netid = NetworkGetNetworkIdFromEntity(atm)
    while not NetworkDoesNetworkIdExist(netid) do
        Wait(10)
        netid = NetworkGetNetworkIdFromEntity(atm)
        count = count + 1
        if count == 100 then return end
    end

    -- reward the player money on the server.
    TriggerServerEvent("ND_ATMRobbery:rob", netid)

    -- play the money spraying effect.
    local heading = GetEntityHeading(atm)
    getPtfx("scr_xs_celebration")
    local pfx = StartParticleFxLoopedOnEntity("scr_xs_money_rain", atm, -0.1, -0.3, 0.75, -90.0, heading - 180.0, heading, 1.0, false, false, false)
    Wait(15000)
    StopParticleFxLooped(pfx, 0)
end)

CreateThread(function()
    DecorRegister(ATM_DECOR, 2)
    while true do
        Wait(1500)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local atm = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 15.0, `prop_atm_01`, false, false, false)
        if atm then
            local atmHealth = GetEntityHealth(atm)
            if atmHealth == 0 then
                NetworkRegisterEntityAsNetworked(atm)
                local broken = GetBrokenATM(atm)
                if not broken then
                    SetBrokenATM(atm, true)
                    TriggerEvent("ND_ATMRobbery:money", atm)
                end
            end
        end
    end
end)