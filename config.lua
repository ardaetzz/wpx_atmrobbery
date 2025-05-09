Config = {}

-- General Settings
Config.Language = "en"        -- Language to be used for notifications and UI elements (e.g., "en", "tr"). Make sure locale files exist for the selected language.
Config.Framework = "qb"       -- Framework version being used ("qb" or "esx"). This script attempts to auto-detect, but manual setting is more reliable.
Config.InventoryType = "auto" -- Inventory system ("auto", "ox", "qb"). 'auto' will try to detect 'ox_inventory', then 'qb-inventory'.
Config.TargetType = "auto"    -- Targeting system ("auto", "ox", "qb"). 'auto' will try to detect 'ox_target', then 'qb-target'.

-- ATM Models
Config.ATMProps = {           -- List of ATM prop models that can be robbed.
    'prop_atm_01',
    'prop_atm_02',
    'prop_atm_03',
}

-- Robbery Settings
Config.RequiredItem = "advanced_circuit" -- Item name required to start the ATM robbery. This is the item's actual name in your inventory system.
Config.ConsumeItemOnSuccess = true     -- Whether the required item should be consumed after a successful robbery (true/false). It's always consumed on failure.
Config.RewardItemName = "money"          -- The name of the item given as a reward (e.g., "money", "markedbills"). Usually 'money' for cash.
Config.MinReward = 300                   -- Minimum amount of the reward item the player can receive.
Config.MaxReward = 2000                  -- Maximum amount of the reward item the player can receive.

Config.PoliceAlertChance = 90            -- Percentage chance (0-100) of alerting the police upon starting a robbery.
Config.PoliceAlertEvent = "police:client:alert" -- The client-side event to trigger for police alerts.
-- This script triggers this client-side event for all players (-1 target) when a police alert occurs.
-- Your police alert script (e.g., qb-policealerts, or a custom function in your qb-policejob/other police script) should listen for this event.
-- The event is triggered with the following arguments:
-- 1. coords (table): The coordinates of the robbery (e.g., {x = 123.45, y = 678.90, z = 30.25}).
-- 2. message (string): A short title for the alert (e.g., "ATM Robbery" - localized).
-- 3. description (string): A brief description of the alert (e.g., "An ATM robbery has been reported." - localized).
--
-- TO MAKE THIS COMPATIBLE WITH YOUR POLICE SYSTEM (e.g., qb-police and its alert system):
-- 1. Identify the CLIENT-SIDE event your police script uses to display new alerts.
--    For example, many 'qb-policealerts' or similar scripts might have an event like 'qb-policealerts:client:AddPoliceAlert'
--    or a more generic 'police:client:PoliceAlert', 'ps-dispatch:client:PoliceAlertFromExternal', etc.
-- 2. Change the value of Config.PoliceAlertEvent above to match that event name.
-- 3. IMPORTANT: Check if your police script's event expects the arguments in the same order and format (coords, message, description).
--    If it expects different arguments (e.g., a single table containing all info, different field names, or additional data like blip details),
--    you will need to modify the TriggerClientEvent call in 'server/main.lua' (around line 60-65) to match the expected signature.
--    Example of what you might find in server/main.lua to change:
--    TriggerClientEvent(Config.PoliceAlertEvent, -1, coords, GetLocale("police_alert_message"), GetLocale("police_alert_description"))
--    You might need to change it to something like:
--    local alertData = { code = "10-31", title = GetLocale("police_alert_message"), coords = coords, description = GetLocale("police_alert_description"), blip = true }
--    TriggerClientEvent(Config.PoliceAlertEvent, -1, alertData)
--    This depends entirely on YOUR specific police alert script's requirements.

Config.MinimumPolice = 1                 -- Minimum number of on-duty police officers required in the city to start a robbery. Set to 0 to disable this check.
Config.MinigameCircles = 3               -- Number of circles for the default 'ps-ui' circle minigame (if used).
Config.MinigameSeconds = 15              -- Duration in seconds for the default 'ps-ui' circle minigame (if used).

-- Cooldown Settings
Config.ATMCooldown = 300                 -- Cooldown time in seconds for an ATM after it has been successfully robbed before it can be robbed again.
Config.FailedATMCooldown = 60            -- Cooldown time in seconds for an ATM if a robbery attempt fails (only if Config.RemoveCooldownOnFail is false).
Config.RemoveCooldownOnFail = true       -- If true, there will be no ATM-specific cooldown after a failed robbery attempt. The ATM can be tried again immediately.
Config.PlayerCooldown = 5                -- Cooldown time in seconds for a player after they attempt a robbery (successful or failed) before they can rob another ATM.

-- Localization for Notifications (These are keys for the locale files, not the messages themselves unless GetLocale fails)
Config.Notify = {
    no_item = "no_item",                            -- Locale key for "You don't have %s!"
    minigame_start_error = "minigame_start_error",  -- Locale key for "Failed to start minigame."
    success_message = "success_message",            -- Locale key for "$%s stolen!"
    fail_message = "fail_message",                  -- Locale key for "You failed, %s broke."
    atm_cooldown = "atm_cooldown",                  -- Locale key for "This ATM was recently robbed. Try again in %s seconds."
    player_cooldown = "player_cooldown"             -- Locale key for "You recently committed a robbery. Try again in %s seconds."
}
