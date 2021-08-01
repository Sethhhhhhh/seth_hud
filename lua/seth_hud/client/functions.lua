--[[
    name: functions.lua
]]--

SethHUD.Functions = SethHUD.Functions or {}

function SethHUD.Functions:GetPersonalInformation()
    local tblInformations = {
        {
            name = self:GetLanguage( "HealthName" ),
            material = SethHUD.Utils.Materials[ "Health" ],
            textColor = Color( 216, 209, 3 ),
            value = function()
                return math.Clamp( LocalPlayer():Health() or 0, 0, LocalPlayer():GetMaxHealth() ).. " / ".. LocalPlayer():GetMaxHealth()
            end
        },
        {
            name = self:GetLanguage( "ArmorName" ),
            material = SethHUD.Utils.Materials[ "Armor" ],
            textColor = Color( 216, 209, 3 ),
            value = function()
                return math.Clamp( LocalPlayer():Armor() or 0, 0, SethHUD.CustomerConfig.MaxArmor ).. " / ".. SethHUD.CustomerConfig.MaxArmor
            end
        },
    }

    if SethHUD.CustomerConfig.ShowHunger then
        tblInformations[ #tblInformations +1 ] = {
            name = self:GetLanguage( "HungerName" ),
            material = SethHUD.Utils.Materials[ "Hunger" ],
            textColor = SethHUD.Utils.Colors[ "Text" ],
            value = function()
                return math.Round( math.Clamp( LocalPlayer():getDarkRPVar( "Energy" ) or 0, 0, 999 ) ) .. " / ".. SethHUD.CustomerConfig.MaxHunger
            end
        }
    end

    return tblInformations
end

function SethHUD.Functions:GetAdditionalInformation()
    local tblInformations = {
        {
            name = LocalPlayer():GetName() or "",
            material = SethHUD.Utils.Materials[ "Identity" ],
            textColor = Color( 216, 209, 3 ),
            value = function()
                return LocalPlayer():getDarkRPVar( "job" ) or ""
            end
        },
        {
            name = self:GetLanguage( "MoneyName" ),
            material = SethHUD.Utils.Materials[ "Money" ],
            textColor = SethHUD.Utils.Colors[ "Text" ],
            value = function()
                return DarkRP.formatMoney( LocalPlayer():getDarkRPVar( "money" ) or 0 ).. " (".. DarkRP.formatMoney( LocalPlayer():getDarkRPVar( "salary" ) or 0 ).. ")"                                                                                                                                                                                 /* 76561198180318085 */                                                
            end
        },
    }

    if SethHUD.CustomerConfig.ShowGunLicense then
        tblInformations[ #tblInformations +1 ] = {
            name = self:GetLanguage( "GunLicenseName" ),
            material = SethHUD.Utils.Materials[ "GunLicense" ],
            value = function()
                if LocalPlayer():getDarkRPVar( "HasGunlicense" ) or false then
                    return self:GetLanguage( "GunLicenseValueYes" )
                else
                    return self:GetLanguage( "GunLicenseValueNo" )
                end
            end
        }
    end

    return tblInformations
end

function SethHUD.Functions:DrawTexture( mat, x, y, w, h, color )
    surface.SetDrawColor( color or Color( 255, 255, 255 ) )
    surface.SetMaterial( mat )
    surface.DrawTexturedRect( x, y, w, h )
end

function SethHUD.Functions:HUDPaint()
    if !IsValid( LocalPlayer() ) then return end

    local intW, intH = ScrW(), ScrH()
    local fntTitle = "SethHUD:Fonts:Title"
    local fntValue = "SethHUD:Fonts:Value"

    self:DrawBaseHUD( intW, intH, fntTitle, fntValue )
    self:DrawAdditionalHUD( intW, intH, fntTitle, fntValue )
    self:DrawAmmo( intW, intH, fntTitle, fntValue )
    self:DrawAgenda( intW, intH, fntTitle, fntValue )
    self:UpdateNotify()
    self:DrawPlayerTime( intW, intH, fntTitle, fntValue )
    self:CheckLockdownWanted()
end

function SethHUD.Functions:DrawBaseHUD( intW, intH, fntTitle, fntValue )
    local intBoxWeight, intBoxHeight = intW *.4, intH *.06
    local intSpacing = 0
    local intMaterialSize = 32
    local tblPersonalInformation = self:GetPersonalInformation() or {}
    

    self:DrawTexture( SethHUD.Utils.Materials[ "LeftDegrade" ], 0, intH -intBoxHeight, intBoxWeight, intBoxHeight, SethHUD.Utils.Colors[ "Degrade" ] )

    for intKey, tblData in pairs( tblPersonalInformation ) do
        self:DrawTexture( tblData.material, intBoxHeight *.5 -intMaterialSize *.5 +intSpacing, intH -intBoxHeight *.5 -intMaterialSize *.5, intMaterialSize, intMaterialSize, SethHUD.Utils.Colors[ "Material" ] )
        surface.SetFont( fntTitle )
        draw.SimpleText( tblData.name, fntTitle, intBoxHeight *.5 -intMaterialSize *.5 +intMaterialSize +10 +intSpacing, intH -intBoxHeight *.5 -select( 2, surface.GetTextSize( tblData.name ) ) *.4 +intH *.002, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
        surface.SetFont( fntValue )
        draw.SimpleText( tblData.value(), fntValue, intBoxHeight *.5 -intMaterialSize *.5 +intMaterialSize +10 +intSpacing, intH -intBoxHeight *.5 +select( 2, surface.GetTextSize( tblData.name ) ) *.4 +intH *.002, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

        intSpacing = intSpacing +intW *.1
    end
end

function SethHUD.Functions:DrawAdditionalHUD( intW, intH, fntTitle, fntValue )
    if !SethHUD.CustomerConfig.ShowAdditionalHUD then return end
    local intBoxWeight, intBoxHeight = intW *.4, intH *.06
    local intSpacing = 0
    local intMaterialSize = 32
    local tblAdditionalInformation = self:GetAdditionalInformation() or {}

    self:DrawTexture( SethHUD.Utils.Materials[ "RightDegrade" ], intW -intBoxWeight, intH -intBoxHeight, intBoxWeight, intBoxHeight, SethHUD.Utils.Colors[ "Degrade" ] )

    for intKey, tblData in pairs( tblAdditionalInformation ) do
        self:DrawTexture( tblData.material, intW -( intBoxHeight *.5 +intMaterialSize *.5 ) -intSpacing, intH -intBoxHeight *.5 -intMaterialSize *.5, intMaterialSize, intMaterialSize, SethHUD.Utils.Colors[ "Material" ] )
        surface.SetFont( fntTitle )
        draw.SimpleText( tblData.name, fntTitle, intW -( intBoxHeight *.5 -intMaterialSize *.5 ) -intMaterialSize -10 -intSpacing, intH -intBoxHeight *.5 -select( 2, surface.GetTextSize( tblData.name ) ) *.4 +intH *.002, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
        surface.SetFont( fntValue )
        draw.SimpleText( tblData.value(), fntValue, intW -( intBoxHeight *.5 -intMaterialSize *.5 ) -intMaterialSize -10 -intSpacing, intH -intBoxHeight *.5 +select( 2, surface.GetTextSize( tblData.name ) ) *.4 +intH *.002, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )

        intSpacing = intSpacing +intW *.1
    end
end

function SethHUD.Functions:DrawAmmo( intW, intH, fntTitle, fntValue )
    local intBoxWeight, intBoxHeight = intW *.25, intH *.06
    local intMaterialSize = 32
    local entWeapon, intTotalAmmo, intAmmoClip, strWeaponName
    local pPlayer = LocalPlayer()
	if !IsValid( pPlayer:GetActiveWeapon() ) then return end
	  
    entWeapon = pPlayer:GetActiveWeapon()
    intTotalAmmo = pPlayer:GetAmmoCount( entWeapon:GetPrimaryAmmoType() ) or pPlayer:GetAmmoCount( entWeapon:GetSecondaryAmmoType() ) or pPlayer:GetAmmoCount( entWeapon:Ammo1() )
    intAmmoClip = entWeapon:Clip1()
    strWeaponName = entWeapon:GetPrintName()
	if intAmmoClip < 0 or SethHUD.Utils.WeaponBlackList[ entWeapon:GetClass() ] then return end
    
    self:DrawTexture( SethHUD.Utils.Materials[ "LeftDegrade" ], 0, intH -intBoxHeight *2 -5, intBoxWeight, intBoxHeight, SethHUD.Utils.Colors[ "Degrade" ] )
    self:DrawTexture( SethHUD.Utils.Materials[ "Ammo" ], intBoxHeight *.5 -intMaterialSize *.5, intH -intBoxHeight *1.58 -intMaterialSize *.5, intMaterialSize, intMaterialSize, SethHUD.Utils.Colors[ "Material" ] )
    surface.SetFont( fntTitle )
    draw.SimpleText( strWeaponName, fntTitle, intBoxHeight *.5 -intMaterialSize *.5 +intMaterialSize +10, intH -intBoxHeight *1.6 -select( 2, surface.GetTextSize(strWeaponName ) ) *.4 +intH *.002, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    surface.SetFont( fntValue )
    draw.SimpleText( intAmmoClip.. " / ".. intTotalAmmo, fntValue, intBoxHeight *.5 -intMaterialSize *.5 +intMaterialSize +10, intH -intBoxHeight *1.6 +select( 2, surface.GetTextSize( intAmmoClip.. " / ".. intTotalAmmo ) ) *.4 +intH *.002, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
end

function SethHUD.Functions:DrawAgenda( intW, intH, fntTitle, fntValue )
    if !SethHUD.CustomerConfig.ShowAgenda then return end

    local intSpacing = intW *.02
    if !LocalPlayer():getAgendaTable() then return end
    local strAgendaTitle = LocalPlayer():getAgendaTable()[ "Title" ]
    local strAgendaText = DarkRP.textWrap( ( LocalPlayer():getDarkRPVar( "agenda" ) or "" ):gsub( "//", "\n" ):gsub( "\\n", "\n" ), "SethHUD:Fonts:Value", math.Round( intW *.2 ) )
    if !strAgendaText or strAgendaText == "" then return end
    draw.SimpleText( strAgendaTitle, fntTitle, intW -intSpacing, intSpacing *.8, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
    surface.SetFont( fntTitle )
    draw.DrawNonParsedText( strAgendaText, fntValue, intW -intSpacing, intSpacing *.8 +select( 2, surface.GetTextSize( "SethHUD:Fonts:Title" ) ), SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
end

function SethHUD.Functions:GetLanguage( strKey, intKey )
    return intKey and SethHUD.Utils.Language[ SethHUD.CustomerConfig.Language ][ strKey ][ intKey ] or SethHUD.Utils.Language[ SethHUD.CustomerConfig.Language ][ strKey ]
end

function SethHUD.Functions:TimeToString( intTime )
    local intTime = intTime
    local intSecondes = intTime % 60
    intTime = math.floor( intTime / 60 )
    local intMinutes = intTime % 60
    intTime = math.floor( intTime / 60 )
    local intHours = intTime % 24
    intTime = math.floor( intTime / 24 )
    local intDays = intTime % 7
    
    return string.format( "%i".. self:GetLanguage( "PlayerTimeFormat", 1 ).. " %02i".. self:GetLanguage( "PlayerTimeFormat", 2 ).. " %02i".. self:GetLanguage( "PlayerTimeFormat", 3 ).. " %02i".. self:GetLanguage( "PlayerTimeFormat", 4 ), intDays, intHours, intMinutes, intSecondes )
end

function SethHUD.Functions:DrawPlayerTime( intW, intH, fntTitle, fntValue )
    if !SethHUD.CustomerConfig.ShowPlayerTime then return end

    local intBoxWeight, intBoxHeight = intW *.2, intH *.06
    local intMaterialSize = 32
    local strTime = self:TimeToString( CurTime() -LocalPlayer().intPlayerTime )

    self:DrawTexture( SethHUD.Utils.Materials[ "LeftDegrade" ], 0, 0, intBoxWeight, intBoxHeight, SethHUD.Utils.Colors[ "Degrade" ] )
    self:DrawTexture( SethHUD.Utils.Materials[ "PlayerTime" ], intBoxHeight *.5 -intMaterialSize *.5, intBoxHeight *.5 -intMaterialSize *.5, intMaterialSize, intMaterialSize, SethHUD.Utils.Colors[ "Degrade" ] )

    surface.SetFont( fntTitle )
    draw.SimpleText( self:GetLanguage( "PlayerTimeName" ), fntTitle, intBoxHeight *.5 +intMaterialSize *.5 +10, intBoxHeight *.5 -select( 2, surface.GetTextSize( self:GetLanguage( "PlayerTimeName" ) ) ) *.4, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    surface.SetFont( fntValue )
    draw.SimpleText( strTime, fntValue, intBoxHeight *.5 +intMaterialSize *.5 +10, intBoxHeight *.5 +select( 2, surface.GetTextSize( strTime ) ) *.4, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
end

function SethHUD.Functions:DrawHeadHUD( pPlayer )
    if !SethHUD.CustomerConfig.ShowHeadHUD then return end
    if LocalPlayer() == pPlayer then return end
    if !IsValid( LocalPlayer() ) or !LocalPlayer():Alive() or !IsValid( pPlayer ) or !pPlayer:Alive() then return end
    if pPlayer:GetColor().a == "0" then return end
    if LocalPlayer():GetPos():DistToSqr( pPlayer:GetPos() ) > 100000 then return end

    local vecPos = pPlayer:GetPos() +Vector( 0, 0, pPlayer:OBBMaxs().z *1.15 ) 
    local angRotate = Angle( 0, LocalPlayer():EyeAngles().y - 90, 90 )
    local matPlayer = SethHUD.Utils.tblPlayerSpeaking[ pPlayer ] and SethHUD.Utils.Materials[ "Speaker" ] or ( pPlayer:IsSuperAdmin() or pPlayer:IsAdmin() ) and SethHUD.Utils.Materials[ "Admin" ] or SethHUD.Utils.Materials[ "User" ]
    local strWantedReason = pPlayer:getDarkRPVar( "wantedReason" )
    
    local intPlayerNameY, intPlayerJobY, intPlayerValueY
    if !SethHUD.CustomerConfig.ShowHeadHUDValues and !SethHUD.CustomerConfig.ShowHeadHUDJob then 
        intPlayerNameY = 30
    elseif SethHUD.CustomerConfig.ShowHeadHUDValues and SethHUD.CustomerConfig.ShowHeadHUDJob then
        intPlayerNameY, intPlayerJobY, intPlayerValueY = 10, 32, 45
    elseif !SethHUD.CustomerConfig.ShowHeadHUDValues and SethHUD.CustomerConfig.ShowHeadHUDJob then
        intPlayerNameY, intPlayerJobY = 20, 43
    else
        intPlayerNameY, intPlayerValueY = 20, 35
    end

    cam.Start3D2D( vecPos, angRotate, .1 )
        self:DrawTexture( matPlayer, -64 -15, -5, 64, 64, SethHUD.Utils.Colors[ "Material" ] )

        if SethHUD.CustomerConfig.ShowHeadHUDValues then
            surface.SetDrawColor( SethHUD.Utils.Colors[ "Health" ] )
            surface.DrawRect( 0, intPlayerValueY, math.Clamp( pPlayer:Health() *1.2, 0, 100 ), 5 )

            surface.SetDrawColor( SethHUD.Utils.Colors[ "Armor" ] )
            surface.DrawRect( 0, intPlayerValueY +8, math.Clamp( pPlayer:Armor() *1.2, 0, 100 ), 5 )
        end
        
        draw.SimpleText( pPlayer:GetName(), "SethHUD:Fonts:HeadTitle", 0, intPlayerNameY, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
        if SethHUD.CustomerConfig.ShowHeadHUDJob then
            draw.SimpleText( pPlayer:getDarkRPVar( "job" ), "SethHUD:Fonts:HeadValue", 0, intPlayerJobY, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
        end

        if pPlayer:isWanted() and SethHUD.CustomerConfig.ShowWantedHeadHUD then
            draw.SimpleTextOutlined( self:GetLanguage( "WantedName" ), "SethHUD:Fonts:HeadWanted", 0, -80, Color( 200, 100, 100 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 150, 25, 25 ) )
            draw.SimpleTextOutlined( strWantedReason, "SethHUD:Fonts:HeadValue", 0, -50, Color( 200, 100, 100 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 150, 25, 25 ) )
        end
    cam.End3D2D()
end

function SethHUD.Functions:DoorInfo( entDoor )
    local tblDoorTeams = entDoor:getKeysDoorTeams()
    local tblDoorGroup = entDoor:getKeysDoorGroup()
    local strOwner = entDoor:isKeysOwned() or tblDoorTeams or tblDoorGroup or entDoor:getKeysNonOwnable()
    local strTitle = entDoor:getKeysTitle()
    local tblDoorInfo = {}
    
    if strOwner == entDoor:isKeysOwned() then
        tblDoorInfo[ "Owner" ] = entDoor:getDoorOwner():Nick()
        for intPlayer, v in pairs( entDoor:getKeysCoOwners() or {} ) do
            
            local pPlayer = Entity( intPlayer )
            if !IsValid( pPlayer ) or !pPlayer:IsPlayer() then continue end
            tblDoorInfo[ "CoOwners" ] = tblDoorInfo[ "CoOwners" ] or {}
            tblDoorInfo[ "CoOwners" ][ #tblDoorInfo[ "CoOwners" ] +1 ] = pPlayer:Nick()
        end
    elseif tblDoorTeams then
        for intTeam, _ in pairs( tblDoorTeams ) do
            if !intTeam or !RPExtraTeams[ intTeam ] then continue end
            tblDoorInfo[ "Owner" ] = tblDoorInfo[ "Owner" ] or {}
            tblDoorInfo[ "Owner" ][ #tblDoorInfo[ "Owner" ] +1 ] = RPExtraTeams[ intTeam ].name
        end
    elseif tblDoorGroup then
        tblDoorInfo[ "Owner" ] = tblDoorGroup
    elseif entDoor:getKeysNonOwnable() then
        tblDoorInfo[ "Owner" ] = DarkRP.getPhrase("keys_unowned")
    else
        tblDoorInfo[ "Owner" ] = DarkRP.getPhrase("keys_unowned")
    end
    
    
    for strKey, typeValue in pairs( tblDoorInfo ) do
        if strKey == "Owner" and !istable( tblDoorInfo[ "Owner" ] ) then
            surface.SetFont( "SethHUD:Fonts:Title" )
            draw.DrawNonParsedText( typeValue, "SethHUD:Fonts:DoorDisplayTitle", 0, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
        elseif tblDoorInfo[ "Owner" ] and istable( tblDoorInfo[ "Owner" ] ) then
            local intSpacing = 0
            for _, strName in pairs( tblDoorInfo[ "Owner" ] ) do
                draw.DrawNonParsedText( strName, "SethHUD:Fonts:DoorDisplayValue", 0, 30+intSpacing, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
                intSpacing = intSpacing +25
            end
        end
        if strKey == "CoOwners" then
            local intSpacing = 0
            for _, strName in pairs( tblDoorInfo[ "CoOwners" ] ) do
                draw.DrawNonParsedText( strName, "SethHUD:Fonts:DoorDisplayValue", 0, 30+intSpacing, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
                intSpacing = intSpacing +25
            end
        end
    end
end

function SethHUD.Functions:GetDoorInfos( entDoor )
    local tblDoorInfos = {}
    if entDoor.getKeysTitle then
        tblDoorInfos[ "Title" ] = entDoor:getKeysTitle()
    end
    if entDoor.getDoorOwner then
        local strOwner = entDoor:getDoorOwner()
        if IsValid( strOwner ) then
            tblDoorInfos[ "Owner" ] = strOwner
        end
    end
    if entDoor:getKeysCoOwners() then
        tblDoorInfos[ "CoOwners" ] = entDoor:getKeysCoOwners() or {}
    end
    if entDoor:getKeysDoorGroup() then
        tblDoorInfos[ "GroupAllowed" ] = {}
        table.insert( tblDoorInfos[ "GroupAllowed" ], entDoor:getKeysDoorGroup() )
        
    elseif entDoor:getKeysDoorTeams() then
        tblDoorInfos[ "GroupAllowed" ] = {}
        for intKey, _ in pairs( entDoor:getKeysDoorTeams() or {} ) do
            if !RPExtraTeams[ intKey ] then continue end
            table.insert( tblDoorInfos[ "GroupAllowed" ], RPExtraTeams[ intKey ].name )
        end
    end

    return tblDoorInfos
end

function SethHUD.Functions:GetDoorPos( entDoor )
    local vecDimension = entDoor:OBBMaxs() -entDoor:OBBMins()
    local vecCenter = entDoor:OBBCenter()
    local intMinimum, intKey
    local vecNorm, angRotate, vecPos, intDot
    
    for i = 1, 3 do
        if !intMinimum or vecDimension[ i ] <= intMinimum then
            intKey = i
            intMinimum = vecDimension[ i ]
        end
    end

    vecNorm = Vector()
    vecNorm[ intKey ] = 1
    angRotate = Angle( 0, vecNorm:Angle().y +90, 90 )

    if entDoor:GetClass() == "prop_door_rotating" then
        vecPos = Vector( vecCenter.x, vecCenter.y, 15 ) +angRotate:Up() *( intMinimum /6 )
    else
        vecPos = vecCenter + Vector( 0, 0, 20 ) +angRotate:Up() *( ( intMinimum *.5 ) -0.1 )
    end

    local angRotateNew = entDoor:LocalToWorldAngles( angRotate )
    intDot = angRotateNew:Up():Dot( LocalPlayer():GetShootPos() -entDoor:WorldSpaceCenter() )

    if intDot < 0 then
        angRotate:RotateAroundAxis( angRotate:Right(), 180 )

        vecPos = vecPos -( 2 *vecPos *-angRotate:Up() )
        angRotateNew = entDoor:LocalToWorldAngles( angRotate )
    end
    vecPos = entDoor:LocalToWorld( vecPos )

    return vecPos, angRotateNew
end

function SethHUD.Functions:DrawDoor()
    if !SethHUD.CustomerConfig.ShowDoorDisplay then return end
    local pPlayer = LocalPlayer()
    if !IsValid( pPlayer ) or !pPlayer:IsPlayer() then return end

    local entDoor = pPlayer:GetEyeTrace() and pPlayer:GetEyeTrace().Entity
    if entDoor:IsVehicle() then return end
    if !entDoor or !IsValid( entDoor ) then return end
    if pPlayer:GetPos():DistToSqr( entDoor:GetPos() ) > 100000 then return end
    if !entDoor.isDoor or !entDoor:isKeysOwnable() then return end
    if !entDoor.getKeysNonOwnable then return end
    

    local vecPos, angRotate = self:GetDoorPos( entDoor )
    if !vecPos or !angRotate then return end

    local tblDoorInfos = self:GetDoorInfos( entDoor )
    local strTitle = tblDoorInfos[ "Title" ]
    local entOwner = tblDoorInfos[ "Owner" ]
    local tblCoOwners = tblDoorInfos[ "CoOwners" ]
    local tblGroup = tblDoorInfos[ "GroupAllowed" ]
    local strTitle = entOwner and strTitle or entOwner and self:GetLanguage( "DoorDisplayPropertyOwned" ) or entDoor:getKeysNonOwnable() and self:GetLanguage( "DoorDisplayPropertyUnavailable" ) or self:GetLanguage( "DoorDisplayPropertyUnOwned" )
    local intAlphaTo = 255 -( pPlayer:GetPos():DistToSqr( entDoor:GetPos() ) *.001 ) *4.8

    cam.Start3D2D( vecPos, angRotate, .1 )
        if !tblGroup or #tblGroup <= 0 then
            
            draw.SimpleText( strTitle, "SethHUD:Fonts:DoorDisplayTitle", 0, 10, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

            if entOwner then
                draw.SimpleText( entOwner:Nick(), "SethHUD:Fonts:DoorDisplayValue", 0, 45, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
                
                if tblCoOwners and #tblCoOwners >= 1 then
                    local intSpacing = 0
                    for _, pPlayer in pairs( tblCoOwners ) do
                        if IsValid(pPlayer) then
                            draw.SimpleText( pPlayer:Nick(), "SethHUD:Fonts:DoorDisplayValue", 0, 70 +intSpacing, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
                        end

                        intSpacing = intSpacing +25
                    end
                end
                if entDoor:isKeysAllowedToOwn( LocalPlayer() ) and !entDoor:isKeysOwnedBy( LocalPlayer() ) then
                    draw.SimpleText( self:GetLanguage( "DoorDisplayAllowedToCoOwn" ), "SethHUD:Fonts:DoorDisplayValue", 0, -10, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
                end
            elseif !entOwner and !entDoor:getKeysNonOwnable() then
                draw.SimpleText( self:GetLanguage( "DoorDisplayAllowedToOwn" ), "SethHUD:Fonts:DoorDisplayValue", 0, -10, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
            end
        else
            draw.SimpleText( self:GetLanguage( "DoorDisplayPropertyOwned" ), "SethHUD:Fonts:DoorDisplayTitle", 0, 10, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
            local intSpacing = 0
            for _, strGroup in pairs( tblGroup ) do
                draw.SimpleText( strGroup, "SethHUD:Fonts:DoorDisplayValue", 0, 50 +intSpacing, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
                intSpacing = intSpacing +25
            end
        end
    cam.End3D2D()
end

function SethHUD.Functions:DrawLockdownWantedNotify( strTitle, strValue )
    local intW, intH = ScrW(), ScrH()
    local intBoxH = intH *.15
    
    self:DrawTexture( SethHUD.Utils.Materials[ "RightDegrade" ], intW *.5 - intW *.5, intH *.5 -intBoxH *.5, intW, intBoxH, SethHUD.Utils.Colors[ "Degrade" ] )
    self:DrawTexture( SethHUD.Utils.Materials[ "LeftDegrade" ], 0, intH *.5 -intBoxH *.5, intW, intBoxH, SethHUD.Utils.Colors[ "Degrade" ] )

    surface.SetFont( "SethHUD:Fonts:WarningTitle" )
    draw.SimpleText( strTitle, "SethHUD:Fonts:WarningTitle", intW * .5, intH * .5 -select( 2, surface.GetTextSize( strTitle ) ) *.25, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    surface.SetFont( "SethHUD:Fonts:WarningValue" )
    draw.SimpleText( strValue, "SethHUD:Fonts:WarningValue", intW * .5, intH * .5 +select( 2, surface.GetTextSize( strValue ) ) *.7, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

local bolIsWanted, bolLockdownActive, bolEventWanted, bolEventLockdown, intOldWantedTime, intOldLockdownTime = false, false, false, false
local bolSoundStart = false
function SethHUD.Functions:CheckLockdownWanted()
    local pPlayer = LocalPlayer()
    local bolPlayerWanted = pPlayer:getDarkRPVar( "wanted" ) or false
    local bolPlayerLockdown = GetGlobalBool( "DarkRP_LockDown" )

    if bolIsWanted != bolPlayerWanted and !bolEventLockdown then
        bolEventWanted = true
        intOldWantedTime = intOldWantedTime or CurTime()
        if CurTime() < intOldWantedTime +SethHUD.CustomerConfig.ShowCustomWarningTime then
            intOldWantedTime = intOldWantedTime or CurTime()
            
            if !bolSoundStart then
                pPlayer:EmitSound( "Town.d1_town_02_elevbell1", 100, 100 )
                bolSoundStart = true
            end
            self:DrawLockdownWantedNotify( self:GetLanguage( "WantedName" ), bolPlayerWanted and pPlayer:getDarkRPVar( "wantedReason" ) or !bolPlayerWanted and self:GetLanguage( "NotWanted" ) ) 
        else
            bolIsWanted = bolPlayerWanted
            intOldWantedTime = nil
            bolSoundStart = false
            bolEventWanted = false
        end
    elseif bolIsWanted != bolPlayerWanted and bolEventLockdown then
        intOldWantedTime = CurTime()
    end

    if bolLockdownActive != bolPlayerLockdown and !bolEventWanted then
        bolEventLockdown = true
        intOldLockdownTime = intOldLockdownTime or CurTime()
        if CurTime() < intOldLockdownTime +SethHUD.CustomerConfig.ShowCustomWarningTime then
            intOldLockdownTime = intOldLockdownTime or CurTime()
            
            if !bolSoundStart then
                pPlayer:EmitSound( "Town.d1_town_02_elevbell1", 100, 100 )
                bolSoundStart = true
            end
            self:DrawLockdownWantedNotify( self:GetLanguage( "LockdownName" ), bolPlayerLockdown and self:GetLanguage( "LockdownStart" ) or !bolPlayerLockdown and self:GetLanguage( "LockdownStop" ) )
        else
            bolLockdownActive = bolPlayerLockdown
            intOldLockdownTime = nil
            bolSoundStart = false
            bolEventLockdown = false
        end
    elseif bolLockdownActive != bolPlayerLockdown and bolEventWanted then
        intOldLockdownTime = CurTime()
    end
end

function SethHUD.Functions:DrawNotify( strMessage, intTime, intX, intY, intW )
    local intH = ScrH()
    local fntTitle = "SethHUD:Fonts:Title"
    local fntValue = "SethHUD:Fonts:Value"

    local intStartH = intH *.2
    local intMaterialSize = 32
    local intBoxHeight = intH *.06

    self:DrawTexture( SethHUD.Utils.Materials[ "RightDegrade" ], intX, intStartH +intY, intW, intBoxHeight, SethHUD.Utils.Colors[ "Degrade" ] )
    self:DrawTexture( SethHUD.Utils.Materials[ "Notify" ], intX +intW -intBoxHeight *.5 -intMaterialSize *.5, intStartH +intY +intBoxHeight *.5 -intMaterialSize *.5, intMaterialSize, intMaterialSize, SethHUD.Utils.Colors[ "Degrade" ] )
    
    surface.SetFont( fntTitle )
    draw.SimpleText( self:GetLanguage( "NotifyName" ), fntTitle, intX +intW -intBoxHeight *.5 -intMaterialSize *.5 -10, intStartH +intY +intBoxHeight *.5 -select( 2, surface.GetTextSize( self:GetLanguage( "NotifyName" ) ) ) *.4, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
    surface.SetFont( fntValue )
    draw.SimpleText( strMessage, fntValue, intX +intW -intBoxHeight *.5 -intMaterialSize *.5 -10, intStartH +intY +intBoxHeight *.5 +select( 2, surface.GetTextSize( strMessage ) ) *.4, SethHUD.Utils.Colors[ "Text" ], TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
end

function SethHUD.Functions:CreateNotify( strMessage, intTime )
    surface.SetFont( "SethHUD:Fonts:Value" )
    local intBoxWeight = select( 1, surface.GetTextSize( strMessage ) ) +ScrH() *.06 +32
    local intNotificationW = select( 1, surface.GetTextSize( self:GetLanguage( "NotifyName" ) ) ) +ScrH() *.06 +32
    if intBoxWeight < intNotificationW then
        intBoxWeight = intNotificationW 
    end
    

    table.insert( SethHUD.Utils.tblNotifications, 1, {
        message = strMessage,
        time = CurTime() +intTime,
        x = ScrW() +intBoxWeight,
        y = ScrH() *.8,
        w = intBoxWeight,
    })
end

function SethHUD.Functions:UpdateNotify()
    for intKey, tblData in pairs( SethHUD.Utils.tblNotifications ) do
        self:DrawNotify( tblData.message, tblData.time, tblData.x, tblData.y, tblData.w )

        tblData.x = Lerp( FrameTime() *10, tblData.x, tblData.time >CurTime() and ScrW() -tblData.w or ScrW() +tblData.w )
        tblData.y = Lerp( FrameTime() *10, tblData.y, ( intKey -1 ) *ScrH() *.065 )
        
        if math.ceil( tblData.x ) <= -tblData.w and tblData.time < CurTime() then
            table.remove( SethHUD.Utils.tblNotifications, intKey )
        end
    end
end

if SethHUD.CustomerConfig.CustomNotify then
    function notification.AddLegacy( strMessage, intType, intTime )
        SethHUD.Functions:CreateNotify( strMessage, intTime )
    end
end

local tblQuestionVGUI = {}
local intPanel = 0
local tblVoteVGUI = {}
local intStartH = ScrH() *.06 +5
local function MessageDoVote( tblData )
    surface.SetFont( "SethHUD:Fonts:VoteText" )
    local intW, intH = ScrW(), ScrH()
    local pPlayer = LocalPlayer()
    
    local strQuestion = string.Replace( tblData:ReadString(), "\n", " " )
    local intVote = tblData:ReadShort()
    local intTimeLeft = tblData:ReadFloat()
    if intTimeLeft == 0 then
        intTimeLeft = 100
    end
    local intOldTime = CurTime()

    if !IsValid( pPlayer ) then return end
    pPlayer:EmitSound( "Town.d1_town_02_elevbell1", 100, 100 )

    local pnlBase = vgui.Create( "SHUD_VoteFrame" )
    pnlBase:SetSize( select( 1, surface.GetTextSize( strQuestion ) ) +100, intH *.15 )
    pnlBase:SetPos( 0, intStartH +intPanel )
    pnlBase:SetQuestion( strQuestion )
    function pnlBase.pnlButtonYes:DoClick()
        pPlayer:ConCommand( "vote " .. intVote .. " yea\n" ) 
        pnlBase:Remove()
    end
    function pnlBase.pnlButtonNo:DoClick()
        pPlayer:ConCommand( "vote " .. intVote .. " nay\n" ) 
        pnlBase:Remove()
    end
    function pnlBase:OnRemove()
        intPanel = intPanel -intH *.15 -5
        tblVoteVGUI[ intVote .. "vote" ] = nil

        local intNumber = 0
        for _, pnl in SortedPairs( tblVoteVGUI ) do
            pnl:SetPos( 0, intStartH +intNumber )
            intNumber = intNumber +intH *.15 +5
        end

        for _, pnl in SortedPairs( tblQuestionVGUI ) do
            pnl:SetPos( 0, intStartH +intNumber )
            intNumber = intNumber +( intH *.15 +5 ) *2 
        end
    end
    function pnlBase:Think()
        local intTime = DarkRP.getPhrase( "time", math.Clamp( math.ceil( intTimeLeft - ( CurTime() - intOldTime ) ), 0, 9999 ) )
        self:SetTime( string.sub( intTime, 6, string.len( intTime ) ) )
        if intTimeLeft - ( CurTime() -intOldTime ) <= 0 then
            self:Remove()
        end
    end

    intPanel = intPanel +intH *.15 +5
    tblVoteVGUI[ intVote.. "vote" ] = pnlBase
end

local function KillVoteVGUI( tblData )
    local intVote = tblData:ReadShort()

    if tblVoteVGUI[ intVote.. "vote" ] and tblVoteVGUI[ intVote .. "vote" ]:IsValid() then
        tblVoteVGUI[ intVote.. "vote" ]:Close()
    end
end

local function MsgDoQuestion( strMessage )
    local pPlayer = LocalPlayer()
    if !IsValid( pPlayer ) then return end
    local intW, intH = ScrW(), ScrH()

    local strQuestion = string.Replace( strMessage:ReadString(), "\n", " " )
    local strQuestionID = strMessage:ReadString()
    local intTimeLeft = strMessage:ReadFloat()
    if intTimeLeft == 0 then
        intTimeLeft = 100
    end
    local intOldTime = CurTime()

    pPlayer:EmitSound( "Town.d1_town_02_elevbell1", 100, 100 )
    local pnlBase = vgui.Create( "SHUD_VoteFrame" )
    pnlBase:SetSize( select( 1, surface.GetTextSize( strQuestion ) ) +50, intH *.15 )
    pnlBase:SetPos( 0, intStartH +intPanel )
    pnlBase:SetQuestion( strQuestion )
    pnlBase:SetKeyboardInputEnabled( false )
    pnlBase:SetMouseInputEnabled( true )
    pnlBase:SetVisible( true )
    function pnlBase:OnRemove()
        intPanel = intPanel -intH *.15 -5
        tblQuestionVGUI[ strQuestionID.. "ques" ] = nil 

        local intSpacing = 0
        for _, pnlQuestion in SortedPairs( tblVoteVGUI ) do
            pnlQuestion:SetPos( 0, intStartH +intSpacing )
            intSpacing = intSpacing +intH *.15 +5
        end
        
        for _, pnlQuestion in SortedPairs( tblQuestionVGUI ) do
            pnlQuestion:SetPos( 0, intStartH +intSpacing )
            intSpacing = intSpacing +( intH *.15 +5 ) *2 
        end
    end

    function pnlBase:Think()
        self:SetTime( DarkRP.getPhrase( "time", math.Clamp( math.ceil( intTimeLeft - ( CurTime() - intOldTime ) ), 0, 9999 ) ) )
        if intTimeLeft - (CurTime() - intOldTime) <= 0 then
            pnlBase:Remove()
        end
    end

    function pnlBase.pnlButtonYes:DoClick()
        pPlayer:ConCommand( "ans " .. strQuestionID .. " 1\n" ) 
        pnlBase:Remove()
    end
    function pnlBase.pnlButtonNo:DoClick()
        pPlayer:ConCommand( "ans " .. strQuestionID .. " 2\n" ) 
        pnlBase:Remove()
    end

    intPanel = intPanel +intH *.15 +5
    tblQuestionVGUI[ strQuestionID .. "ques" ] = pnlBase
end

local function KillQuestionVGUI( strMessage )
    local strQuestionID = msg:ReadString()

    if tblQuestionVGUI[ strQuestionID .. "ques" ] and tblQuestionVGUI[ strQuestionID .. "ques" ]:IsValid() then
        tblQuestionVGUI[ strQuestionID .. "ques" ]:Close()
    end
end

local function DoVoteAnswerQuestion( pPlayer, cmdCommand, tblArgs )
    if not tblArgs[ 1 ] then return end

    local intVote = 0
    if tonumber( tblArgs[ 1 ] ) == 1 or string.lower( tblArgs[ 1 ] ) == "yes" or string.lower( tblArgs[ 1 ] ) == "true" then intVote = 1 end

    for intKey, pnl in pairs( tblVoteVGUI ) do
        if IsValid( pnl ) then
            local intID = string.sub( intKey, 1, -5 )
            tblVoteVGUI[ intKey ]:Close()
            RunConsoleCommand( "vote", intID, intVote )
            return
        end
    end

    for intKey, pnl in pairs( tblQuestionVGUI ) do
        if IsValid( pnl ) then
            local intID = string.sub( intKey, 1, -5 )
            tblQuestionVGUI[ intKey ]:Close()
            RunConsoleCommand( "ans", intID, intVote )
            return
        end
    end
end

hook.Add( "DarkRPFinishedLoading", "HOOKS:SethHUD:DarkRPFinishedLoading", function()
    if !SethHUD.CustomerConfig.ShowCustomVote then return end
    usermessage.Hook( "DoVote", MessageDoVote )
    usermessage.Hook( "KillVoteVGUI", KillVoteVGUI )
    usermessage.Hook( "DoQuestion", MsgDoQuestion )
    usermessage.Hook( "KillQuestionVGUI", KillQuestionVGUI )
    concommand.Add( "rp_vote", DoVoteAnswerQuestion )
end)

-- Clean some DarkRP bugs with notify
local function DisplayNotify( tblMsg )
    local strText = tblMsg:ReadString()
    GAMEMODE:AddNotify( strText, tblMsg:ReadShort(), tblMsg:ReadLong())
    surface.PlaySound("buttons/lightswitch2.wav")

    -- Log to client console
    MsgC( Color( 255, 20, 20, 255 ), "[DarkRP] ", Color(200, 200, 200, 255), strText, "\n" )
end
usermessage.Hook( "_Notify", DisplayNotify )