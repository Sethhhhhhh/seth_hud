--[[
    name: vgui.lua
]]--

local colBackground = SethHUD.Utils.Colors[ "Degrade" ]
local colText = SethHUD.Utils.Colors[ "Text" ]
local strMat = SethHUD.Utils.Materials[ "LeftDegrade" ]

surface.CreateFont( "SethHUD:Fonts:Button", { font = 'BigNoodleTitling', size = math.Round( ScrH() *.023 ), weight = 500, italic = true  } )
surface.CreateFont( "SethHUD:Fonts:VoteTitle", { font = 'BigNoodleTitling', size = math.Round( ScrH() *.025 ), weight = 500, italic = true  } )
surface.CreateFont( "SethHUD:Fonts:VoteText", { font = 'Purista', size = math.Round( ScrH() *.018 ), weight = 500, italic = true  } )

--[[
    name: SHUDFrame.lua
]]--

local PANEL = {}

function PANEL:Paint( intW, intH )
    surface.SetDrawColor( colBackground )
    surface.SetMaterial( strMat )
    surface.DrawTexturedRect( 0, 0, intW, intH )
end

vgui.Register( "SHUD_Frame", PANEL, "EditablePanel" )

--[[
    name: SHUDButton
]]--

local PANEL = {}

function PANEL:Init()
    self:SetText( "" )
    self.strText = "Label"
end

function PANEL:SetButtonText( strText )
    self.strText = strText
end

function PANEL:Paint( intW, intH )
    draw.SimpleText( self.strText, "SethHUD:Fonts:Button", intW *.5, intH *.5, colText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    if self.Hovered then
        surface.SetDrawColor( Color( 255, 255, 255, 20 ) )
        surface.DrawRect( 0, 0, intW, intH )
    end
end

vgui.Register( "SHUD_Button", PANEL, "DButton" )

--[[
    name: SHUDVoteFrame
]]--

local PANEL = {}

function PANEL:Init()
    self.intTime = 0
    self.strQuestion = "Question"

    self.pnlButtonYes = vgui.Create( "SHUD_Button", self )
    self.pnlButtonYes:SetButtonText( "✔  ".. SethHUD.Utils.Language[ SethHUD.CustomerConfig.Language ][ "VoteYes" ] )

    self.pnlButtonNo = vgui.Create( "SHUD_Button", self )
    self.pnlButtonNo:SetButtonText( SethHUD.Utils.Language[ SethHUD.CustomerConfig.Language ][ "VoteNo" ].. "  ✖" )
end

function PANEL:SetTime( intTime )
    self.intTime = intTime
end

function PANEL:SetQuestion( strQuestion )
    self.strQuestion = strQuestion
end

function PANEL:PerformLayout( intW, intH )
    self.pnlButtonYes:SetSize( intH *.5, intH *.22 )
    self.pnlButtonYes:SetPos( 5, intH -self.pnlButtonYes:GetTall() -10 )

    self.pnlButtonNo:SetSize( intH *.5, intH *.22 )
    self.pnlButtonNo:SetPos( 5 +self.pnlButtonYes:GetWide() +5, intH -self.pnlButtonNo:GetTall() -10 )
end


function PANEL:PaintOver( intW, intH )
    draw.SimpleText( SethHUD.Utils.Language[ SethHUD.CustomerConfig.Language ][ "VoteTime" ], "SethHUD:Fonts:VoteTitle", 10, intH *.07, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
    draw.SimpleText( self.intTime.. " ".. SethHUD.Utils.Language[ SethHUD.CustomerConfig.Language ][ "VoteSecond" ], "SethHUD:Fonts:VoteText", 8, intH *.22, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

    draw.SimpleText( SethHUD.Utils.Language[ SethHUD.CustomerConfig.Language ][ "VoteQuestion" ], "SethHUD:Fonts:VoteTitle", 10, intH *.39, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
    draw.SimpleText( self.strQuestion, "SethHUD:Fonts:VoteText", 10, intH *.53, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
end

vgui.Register( "SHUD_VoteFrame", PANEL, "SHUD_Frame" )
