--[[
    name: seth_hud.lua
]]--

SethHUD = SethHUD or {}
SethHUD.strPath = "seth_hud/shared/"

if SERVER then
	for k, v in pairs( file.Find( SethHUD.strPath.. '*.lua', 'LUA' ) ) do
        AddCSLuaFile( SethHUD.strPath.. v )
		include( SethHUD.strPath.. v )
	end

	SethHUD.strPath = 'seth_hud/server/'
	for k, v in pairs( file.Find( SethHUD.strPath.. '*.lua', 'LUA' ) ) do
		include( SethHUD.strPath.. v )
	end

	SethHUD.strPath = 'seth_hud/client/'
	for k, v in pairs( file.Find( SethHUD.strPath.. '*.lua', 'LUA' ) ) do
		AddCSLuaFile( SethHUD.strPath.. v )
	end
end

if CLIENT then
    SethHUD.strPath = 'seth_hud/shared/'
	for k, v in pairs( file.Find( SethHUD.strPath.. '*.lua', 'LUA' ) ) do
		include( SethHUD.strPath.. v )
	end

	SethHUD.strPath = 'seth_hud/client/'
	for k, v in pairs( file.Find( SethHUD.strPath.. '*.lua', 'LUA' ) ) do
		include( SethHUD.strPath.. v )
	end
end