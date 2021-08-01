--[[
    name: hooks.lua
]]--

hook.Add( "HUDShouldDraw", "HOOKS:SethHUD:HUDShouldDraw", function( strName )
    if SethHUD.Utils.DisabledDarkRPBaseHUD[ strName ] then return false end
end)

hook.Add( "HUDPaint", "HOOKS:SethHUD:HUDPaint", function()
    SethHUD.Functions:HUDPaint()
end)

hook.Add( "InitPostEntity", "HOOKS:SethHUD:InitPostEntity", function()
    if !SethHUD.CustomerConfig.ShowPlayerTime then return end
    LocalPlayer().intPlayerTime = CurTime()
end)

hook.Add( "PostPlayerDraw", "HOOKS:SethHUD:PostPlayerDraw", function( pPlayer )
    SethHUD.Functions:DrawHeadHUD( pPlayer )
end)

hook.Add( "PlayerStartVoice", "HOOKS:SethHUD:PlayerStartVoice", function( pPlayer )
    SethHUD.Utils.tblPlayerSpeaking[ pPlayer ] = true
end)

hook.Add( "PlayerEndVoice", "HOOKS:SethHUD:PlayerEndVoice", function( pPlayer )
    SethHUD.Utils.tblPlayerSpeaking[ pPlayer ] = nil
end)

hook.Add( "RenderScreenspaceEffects", "HOOKS:SethHUD:RenderScreenspaceEffects", function()
    if !SethHUD.CustomerConfig.HealthEffects then return end

    local intHp, intMaxHp = LocalPlayer():Health(), 100
	local intHpColorModify = math.Clamp( intHp /intMaxHp *2 - 1, 0, 1 )
	local intHpMotionBlur = math.Clamp( intHp /intMaxHp /1, .05, 1 )
    
	SethHUD.Utils.HealthColor[ "$pp_colour_colour" ] = intHpColorModify

	DrawColorModify( SethHUD.Utils.HealthColor )
	DrawMotionBlur( intHpMotionBlur, 1, 0.001 )
end)

hook.Add( "PostDrawOpaqueRenderables", "HOOKS:SethHUD:PostDrawOpaqueRenderables", function()
    SethHUD.Functions:DrawDoor()
end)