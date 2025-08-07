ElevatorZone = {}

onPlayerLoaded(function()
    RunTargetThread()
end, true)

function RunTargetThread()
    CreateThread(function()
        for k,v in pairs(Config.Elevators) do
            if v.Floors then
                for d,j in pairs(v.Floors) do
                    ElevatorZone["ElevatorZone"..k..d..j.Coords.x] =
                    createBoxTarget(
                       {
                           "ElevatorZone"..k..d..j.Coords.x,
                           j.Coords,
                           2.0,
                           2.0,
                           {
                               name = "ElevatorZone"..k..d..j.Coords.x,
                               heading = j.Coords.w,
                               debugPoly = Config.System.Debug,
                               minZ = j.Coords.z - 1,
                               maxZ = j.Coords.z + 1,
                           },
                       },
                    {
                       {
                            action = function()
                                PrepElevatorUI(k,v,d)
                            end,
                            icon = "fas fa-hand",
                            label = Config.ElevatorLabel,
                        },
                    }, 1.5)
                end
            end
        end
    end)
end

local function TeleportToFloor(x, y, z, h,Label)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
    Wait(1000)
    SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
    SetEntityHeading(PlayerPedId(), h)
    if Config.UseElevatorSound then
        TriggerEvent('InteractSound_CL:PlayOnOne',Config.UseElevatorSound,Config.SoundVolume)
    end
    Wait(100)
    DoScreenFadeIn(1000)
end

function PrepElevatorUI(elevatorID, elevatorOptions, floorID)
    local options = Config.Elevators[elevatorID]
    if options.JobCode and not hasJob(options.JobCode) then return end
    local floors = elevatorOptions.Floors
    local current = floorID
    local elevator = elevatorID
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open-elevator",
        CurrentFloor = current,
        Floors = floors,
        UIPosition = Config.UIPosition,
    })
end

RegisterNUICallback('go-to-floor', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
    local floor = data.floor
    local Label = floor.Label
    local Coords = floor.Coords
    local x = Coords.x
    local y = Coords.y
    local z = Coords.z
    local w = Coords.w
    TeleportToFloor(x,y,z,w,Label)
end)

AddEventHandler('onResourceStop', function(t) if t ~= GetCurrentResourceName() then return end
	for k in pairs(ElevatorZone) do removeZoneTarget(k) end
end)