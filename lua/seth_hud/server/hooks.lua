--[[
    name: hooks.lua
]]--

hook.Add( "playerWanted", "HOOKS:SethHUD:playerWanted", function( entCriminal, entActor )
    if IsValid( entCriminal ) and IsValid( entActor ) then
        return true
    end
end)

hook.Add( "playerUnWanted", "HOOKS:SethHUD:playerUnWanted", function( entCriminal, entActor )
    if IsValid( entCriminal ) and IsValid( entActor ) then
        return true
    end
end)
