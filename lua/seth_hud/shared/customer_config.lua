--[[
    name: customer_config.lua
]]--

SethHUD.CustomerConfig = SethHUD.CustomerConfig or {}

-- CLIENT Config
if CLIENT then 
    -- Select your language
    SethHUD.CustomerConfig.Language = "EN" --[[
        Select lanquage
        EN = English
        FR = French
        RU = Russian
        DE = German
        PL = Polish
    ]]--

    SethHUD.CustomerConfig.ShowPlayerTime = true -- Show( true ) or Hide( false ) Session time
    SethHUD.CustomerConfig.ShowAgenda = true -- Show( true ) or Hide( false ) Agenda
    SethHUD.CustomerConfig.ShowHunger = true -- Show( true ) or Hide( false ) Hunger

    SethHUD.CustomerConfig.ShowAdditionalHUD = true -- Show( true ) or Hide( false ) additional HUD ( Lockdown, Wanted, GunLicense )
    SethHUD.CustomerConfig.ShowLockdown = true -- Show( true ) or Hide( false ) Lockdown on the hud
    SethHUD.CustomerConfig.ShowWanted = true -- Show( true ) or Hide( false ) Wanted on the hud
    SethHUD.CustomerConfig.ShowGunLicense = true -- Show( true ) or Hide( false ) GunLicense on the hud

    
    SethHUD.CustomerConfig.ShowHeadHUD = true -- Show( true ) or Hide( false ) entity display( player only )
    SethHUD.CustomerConfig.ShowWantedHeadHUD = true -- Show( true ) or Hide( false ) Wanted on entity display
    SethHUD.CustomerConfig.ShowHeadHUDJob = true -- Show( true ) or Hide( false ) Job on entity display
    SethHUD.CustomerConfig.ShowHeadHUDValues = true -- Show( true ) or Hide( false ) Health and Armor on entity display

    -- Show( true ) or Hide( false ) to use custom notify ( restart the server to update this feature )
    SethHUD.CustomerConfig.CustomNotify = true

    -- Show( true ) or Hide( false ) health effects
    SethHUD.CustomerConfig.HealthEffects = true

    -- Show( true ) or Hide( false ) door display
    SethHUD.CustomerConfig.ShowDoorDisplay = true

    -- Show( true ) or Hide( false ) custom vote system ( restart the server to update this feature )
    SethHUD.CustomerConfig.ShowCustomVote = true
    
    SethHUD.CustomerConfig.ShowCustomWarningTime = 10 -- Time of custom wanted, lockdown notify

    -- Set the maximum of HP, Armor and hunger
    SethHUD.CustomerConfig.MaxHP = 100
    SethHUD.CustomerConfig.MaxArmor = 100
    SethHUD.CustomerConfig.MaxHunger = 100
end

-- SERVER Config
if SERVER then
    -- Enable( true ) or Disable( false ) fastdll
    SethHUD.CustomerConfig.FastDLL = true
end