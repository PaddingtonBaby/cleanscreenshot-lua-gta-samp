script_name('CLEANSCREEN')
script_author('medved')
script_version('2.1')

local vkeys   = require 'vkeys'
local memory  = require 'memory'

function main()
    while not isSampAvailable() or not isSampfuncsLoaded() do
        wait(100)
    end

    sampAddChatMessage("CleanScreenshot is loaded :P", 0xFFFFFF)

    while true do
        wait(0)
        if wasKeyPressed(vkeys.VK_F3) then
            -- F3
            disableHUDAndRadar()
            wait(200)
            takeScreenshot()
            wait(200)
            enableHUDAndRadar()
        elseif wasKeyPressed(vkeys.VK_F2) then
            -- F2
            disableHUDAndChat()
            wait(200)
            takeScreenshot()
            wait(200)
            enableHUDAndChat()
        end
    end
end

function disableHUDAndChat()
    displayHud(false)
    sampSetChatDisplayMode(0)
end

function enableHUDAndChat()
    displayHud(true)
    sampSetChatDisplayMode(2)
end

function disableHUDAndRadar()
    displayHud(false)
    -- 2 - radar ne active
    writeMemory(12216172, 1, 2, true)
end

function enableHUDAndRadar()
    displayHud(true)
    -- 0 - radar active
    writeMemory(12216172, 1, 0, true)
end

function takeScreenshot()
    local screenshotAddress = sampGetBase() + 0x119CBC
    if screenshotAddress then
        memory.setuint8(screenshotAddress, 1)
    else
        sampAddChatMessage("Ошибка: невозможно создать скриншот.", 0xFF0000)
    end
end
