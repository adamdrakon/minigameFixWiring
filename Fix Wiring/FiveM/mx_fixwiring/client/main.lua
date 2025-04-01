-- How to use
-- CircuitGame('x', 'y', 'scale', 'tamanho do jogo em vmin', '1.ogg', function()
--     run something
-- end)

-- parameters
-- x = position on screen
-- y = position on screen
-- scale = game size on screen in scale (Normally 1.0)
-- sound_name = audio name + format (example 1.ogg)

-- TriggerEvent example
-- TriggerEvent("Mx::StartMinigameElectricCircuit", '50%', '50%', '1.0', '30vmin', '1.ogg', function()
--     print("^2>>>>>>  Success  <<<<<<^7")
-- end, function()
--     print("^1>>>>>>  Cancelled  <<<<<<^7")
-- end)

-- exports example
-- exports.mx_fixwiring:CircuitGame('50%', '50%', '1.0', '30vmin', '1.ogg', function()
--     print("^2>>>>>>  Success  <<<<<<^7")
-- end, function()
--     print("^1>>>>>>  Cancelled  <<<<<<^7")
-- end)

-- command example
-- /startgame 50% 50% 1.0 30vmin 1.ogg

local SuccessFunction, CancelledFunction = nil, nil

local function CloseNui()
    local ped = PlayerPedId()
    ClearPedTasks(ped)

    SetNuiFocus(false, false)
    SendNUIMessage({
        ui = 'ui',
        NuiOpen = false,
    })
end

RegisterNUICallback('electric_circuit_completed', function(data, cb)
    if SuccessFunction then SuccessFunction() end
    CloseNui()
    cb('ok')
end)

RegisterNUICallback('CloseNui', function(data, cb)
    if CancelledFunction then CancelledFunction() end
    CloseNui()
    cb('ok')
end)

local function CircuitGame(x, y, scale, size_game, sound_name, onSuccess, onCancel)
    SetNuiFocus(true,true)
    SendNUIMessage({
        ui = 'ui',
        NuiOpen = true,
        x = x,
        y = y,
        scale = scale,
        size_game = size_game,
        sound_name = sound_name,
        name_resource = GetCurrentResourceName()
    })
    SuccessFunction = onSuccess
    CancelledFunction = onCancel
end
exports('CircuitGame', CircuitGame)

RegisterNetEvent('Mx::StartMinigameElectricCircuit', function(x, y, scale, size_game, sound_name, onSuccess, onCancel)
    CircuitGame(x, y, scale, size_game, sound_name, onSuccess, onCancel)
end)

-- Uncomment the following command if you need it available for testing.
--[[RegisterCommand('startgame', function(src, args, cmd) 
    TriggerEvent("Mx::StartMinigameElectricCircuit", args[1], args[2], args[3], args[4], args[5], function()
        print("^2>>>>>>  Success  <<<<<<^7")
    end, function()
        print("^1>>>>>>  Cancelled  <<<<<<^7")
    end)
end, false)]]