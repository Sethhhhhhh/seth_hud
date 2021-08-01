--[[
    name: utils.lua
]]--

SethHUD.Utils = SethHUD.Utils or {}
SethHUD.Utils.tblPlayerSpeaking = SethHUD.Utils.tblPlayerSpeaking or {}
SethHUD.Utils.tblNotifications = SethHUD.Utils.tblNotifications or {}
SethHUD.Utils.strMaterialPath = "materials/seth_hud/"

-- languages
SethHUD.Utils.Language = {}
SethHUD.Utils.Language[ "EN" ] = {
    [ "IdentityName" ] = "Identity",
    [ "MoneyName" ] = "Money",
    [ "HealthName" ] = "Health",
    [ "ArmorName" ] = "Armor",
    [ "HungerName" ] = "Hunger",
    [ "GunLicenseName" ] = "Gun license",
    [ "GunLicenseValueNo" ] = "You do not have your gun license",
    [ "GunLicenseValueYes" ] = "You have your gun license",
    
    [ "LockdownName" ] = "Lockdown",
    [ "LockdownStart" ] = "The mayor has initiated a Lockdown, please return to your homes!",
    [ "LockdownStop" ] = "The lockdown has ended!",
    [ "WantedName" ] = "Wanted",
    [ "NotWanted" ] = "You are not wanted!",
    
    [ "NotifyName" ] = "Notification",
    [ "PlayerTimeName" ] = "Session Time",
    [ "PlayerTimeFormat" ] = { "d", "h", "m", "s" },
    
    [ "VoteTime" ] = "Time",
    [ "VoteSecond" ] = "second(s)",
    [ "VoteQuestion" ] = "Question",
    [ "VoteYes" ] = "Yes",
    [ "VoteNo" ] = "No",

    [ "DoorDisplayPropertyOwned" ] = "Property owned",
    [ "DoorDisplayPropertyUnOwned" ] = "Property available",
    [ "DoorDisplayPropertyUnavailable" ] = "Property unavailable", 
    [ "DoorDisplayAllowedToCoOwn" ] = "Press F2 to co-own",
    [ "DoorDisplayAllowedToOwn" ] = "Press F2 to purchase", 
}
SethHUD.Utils.Language[ "FR" ] = {
    [ "IdentityName" ] = "Identité",
    [ "MoneyName" ] = "Argent",
    [ "HealthName" ] = "Santé",
    [ "ArmorName" ] = "Armure",
    [ "HungerName" ] = "Faim",
    [ "GunLicenseName" ] = "Licence d'arme",
    [ "GunLicenseValueNo" ] = "Vous n'avez pas votre license d'arme",
    [ "GunLicenseValueYes" ] = "Vous avez votre license d'arme",

    [ "LockdownName" ] = "Couvre feu",
    [ "LockdownStart" ] = "Le maire a initié un couvre feu, veuillez rentrer chez vous!",
    [ "LockdownStop" ] = "Le couvre feu a été stoppé!",
    [ "WantedName" ] = "Rechercher",
    [ "NotWanted" ] = "Vous n'êtes plus recherché!",
    
    [ "NotifyName" ] = "Notification",
    [ "PlayerTimeName" ] = "Temps de jeu",
    [ "PlayerTimeFormat" ] = { "j", "h", "m", "s" },

    [ "VoteTime" ] = "Temps",
    [ "VoteSecond" ] = "seconde(s)",
    [ "VoteQuestion" ] = "Question",
    [ "VoteYes" ] = "Oui",
    [ "VoteNo" ] = "Non",

    [ "DoorDisplayPropertyOwned" ] = "Proriété achetée",
    [ "DoorDisplayPropertyUnOwned" ] = "Propriété disponible",
    [ "DoorDisplayPropertyUnavailable" ] = "Propriété indisponible",
    [ "DoorDisplayAllowedToCoOwn" ] = "Appuyez sur F2 pour être copropriétaire",
    [ "DoorDisplayAllowedToOwn" ] = "Appuyez sur F2 pour acheter", 
}
SethHUD.Utils.Language[ "DE" ] = {
    [ "IdentityName" ] = "Identität",
    [ "MoneyName" ] = "Geld",
    [ "HealthName" ] = "Leben",
    [ "ArmorName" ] = "Rüstung",
    [ "HungerName" ] = "Hunger",
    [ "GunLicenseName" ] = "Waffen Lizenz",
    [ "GunLicenseValueNo" ] = "Du hast keine Waffen Lizenz",
    [ "GunLicenseValueYes" ] = "Du hast eine Waffen Lizenz",
   
    [ "LockdownName" ] = "Lockdown",
    [ "LockdownStart" ] = "Der Bürgermeister hat eine Stadt Sperre eingerichtet. Bleib im Haus!",
    [ "LockdownStop" ] = "Stadt Sperre beendet!",
    [ "WantedName" ] = "Gesucht",
    [ "NotWanted" ] = "Du wirst nicht Gesucht!",
   
    [ "NotifyName" ] = "Nachricht",
    [ "PlayerTimeName" ] = "Spielzeit",
    [ "PlayerTimeFormat" ] = { "d", "h", "m", "s" },
   
    [ "VoteTime" ] = "Zeit",
    [ "VoteSecond" ] = "Sekunden",
    [ "VoteQuestion" ] = "Frage",
    [ "VoteYes" ] = "Ja",
    [ "VoteNo" ] = "Nein",
 
    [ "DoorDisplayPropertyOwned" ] = "Gekauft von",
    [ "DoorDisplayPropertyUnOwned" ] = "Verfügbar",
    [ "DoorDisplayPropertyUnavailable" ] = "Nicht Kaufbar",
    [ "DoorDisplayAllowedToCoOwn" ] = "Drücke F2 um einen Co-Owner hinzuzufügen",
    [ "DoorDisplayAllowedToOwn" ] = "Drücke F2 zum Kaufen",
}
SethHUD.Utils.Language[ "RU" ] = {
    [ "IdentityName" ] = "Личность",
    [ "MoneyName" ] = "Деньги",
    [ "HealthName" ] = "Здоровье",
    [ "ArmorName" ] = "Броня",
    [ "HungerName" ] = "Голод",
    [ "GunLicenseName" ] = "Лицензия",
    [ "GunLicenseValueNo" ] = "У вас нет лицензии на оружие",
    [ "GunLicenseValueYes" ] = "У вас есть лицензия на оружие",
   
    [ "LockdownName" ] = "Комендантский час",
    [ "LockdownStart" ] = "Мэр установил комендантский час, пожалуйста возвращайтесь домой!",
    [ "LockdownStop" ] = "Комендантский час закончен!",
    [ "WantedName" ] = "Розыск",
    [ "NotWanted" ] = "Вы не разыскиваетесь!",
   
    [ "NotifyName" ] = "Уведомление",
    [ "PlayerTimeName" ] = "Время сессии",
    [ "PlayerTimeFormat" ] = { "d", "h", "m", "s" },
   
    [ "VoteTime" ] = "Время",
    [ "VoteSecond" ] = "секунд(ы)",
    [ "VoteQuestion" ] = "Вопрос",
    [ "VoteYes" ] = "Да",
    [ "VoteNo" ] = "Нет",
 
    [ "DoorDisplayPropertyOwned" ] = "Занято",
    [ "DoorDisplayPropertyUnOwned" ] = "Свободно",
    [ "DoorDisplayPropertyUnavailable" ] = "Недоступно",
    [ "DoorDisplayAllowedToCoOwn" ] = "Нажмите F2 для получения ключей",
    [ "DoorDisplayAllowedToOwn" ] = "Нажмите F2 для покупки",
}
SethHUD.Utils.Language[ "PL" ] = {
    [ "IdentityName" ] = "Identyfikacja",
    [ "MoneyName" ] = "Pieniadze",
    [ "HealthName" ] = "Zdrowie",
    [ "ArmorName" ] = "Pancerz",
    [ "HungerName" ] = "Glod",
    [ "GunLicenseName" ] = "Licencja",
    [ "GunLicenseValueNo" ] = "Nie posiadasz licencji na bron",
    [ "GunLicenseValueYes" ] = "Posiadasz licencje na bron",
 
    [ "LockdownName" ] = "Lockdown",
    [ "LockdownStart" ] = "Prezydent wlaczyl lockdown! Powroc do swojego domu!",
    [ "LockdownStop" ] = "Lockdown zostal zakonczony!",
    [ "WantedName" ] = "Poszukiwany",
    [ "NotWanted" ] = "Nie jestes poszukiwany!",
   
    [ "NotifyName" ] = "Notyfikacja",
    [ "PlayerTimeName" ] = "Dlugosc sesji",
    [ "PlayerTimeFormat" ] = { "d", "h", "m", "s" },
   
    [ "VoteTime" ] = "Czas",
    [ "VoteSecond" ] = "sekund(y)",
    [ "VoteQuestion" ] = "Pytanie",
    [ "VoteYes" ] = "Tak",
    [ "VoteNo" ] = "Nie",
 
    [ "DoorDisplayPropertyOwned" ] = "Posiadalosc zajeta",
    [ "DoorDisplayPropertyUnOwned" ] = "Posiadlosc dostepna",
    [ "DoorDisplayPropertyUnavailable" ] = "Posiadlosc niedostepna",
    [ "DoorDisplayAllowedToCoOwn" ] = "Wcisnij F2 aby byc wspolwlascicielem drzwi",
    [ "DoorDisplayAllowedToOwn" ] = "Wcisnij F2 aby zakupic drzwi",
}
SethHUD.Utils.Language[ "TR" ] = {
    [ "IdentityName" ] = "Kimlik",
    [ "MoneyName" ] = "Para",
    [ "HealthName" ] = "Can",
    [ "ArmorName" ] = "Zirh",
    [ "HungerName" ] = "Aclik",
    [ "GunLicenseName" ] = "Silah Ruhsati",
    [ "GunLicenseValueNo" ] = "Silah lisansin yok",
    [ "GunLicenseValueYes" ] = "Silah lisansin var",
   
    [ "LockdownName" ] = "Sokaga Cikma Yasagi",
    [ "LockdownStart" ] = "Belediye Baskani sokaga cikma yasagi ilan etti. Lutfen evlerinize donun!",
    [ "LockdownStop" ] = "The lockdown has ended!",
    [ "WantedName" ] = "Araniyor",
    [ "NotWanted" ] = "Artik aranmiyorsun!",
   
    [ "NotifyName" ] = "Bildirim",
    [ "PlayerTimeName" ] = "Sunucuda bulunma suren",
    [ "PlayerTimeFormat" ] = { "g", "s", "dk", "sn" },
   
    [ "VoteTime" ] = "Zaman",
    [ "VoteSecond" ] = "Saniye",
    [ "VoteQuestion" ] = "Soru",
    [ "VoteYes" ] = "Evet",
    [ "VoteNo" ] = "Hayir",
 
    [ "DoorDisplayPropertyOwned" ] = "Mulk Sahipli",
    [ "DoorDisplayPropertyUnOwned" ] = "Mulk Sahipsiz",
    [ "DoorDisplayPropertyUnavailable" ] = "Mulk mevcut degil",
    [ "DoorDisplayAllowedToCoOwn" ] = "F2'ye basarak ortak sahip ol",
    [ "DoorDisplayAllowedToOwn" ] = "F2'ye basarak satin al",
}

-- Colors
SethHUD.Utils.Colors = {
    [ "Degrade" ] = Color( 255, 255, 255 ),
    [ "Text" ] = Color( 255, 255, 255 ),
    [ "Material" ] = Color( 255, 255, 255 ),
    [ "Health" ] = Color( 255, 150, 150, 200 ),
    [ "Armor" ] = Color( 150, 150, 255, 200 )
}

-- Materials
SethHUD.Utils.Materials = {
    [ "LeftDegrade" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_left_degrade.png" ),
    [ "RightDegrade" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_right_degrade.png" ),
    [ "Ammo" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_ammo.png" ),
    [ "Armor" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_armor.png" ),
    [ "GunLicense" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_gunlicense.png" ),
    [ "Health" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_health.png" ),
    [ "Hunger" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_hunger.png" ),
    [ "Identity" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_identity.png" ),
    [ "Lockdown" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_lockdown.png" ),
    [ "Money" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_money.png" ),
    [ "Notify" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_notify.png" ),
    [ "PlayerTime" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_playertime.png" ),
    [ "Wanted" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_wanted.png" ),
    [ "Notify" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_notify.png" ),
    [ "User" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_user.png" ),
    [ "Admin" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_admin.png" ),
    [ "Speaker" ] = Material( SethHUD.Utils.strMaterialPath.. "mat_speaker.png" ),
}

-- Fonts
surface.CreateFont( "SethHUD:Fonts:Title", { font = 'BigNoodleTitling', size = math.Round( ScrH() *.026 ), weight = 500 } )
surface.CreateFont( "SethHUD:Fonts:Value", { font = 'Purista', size = math.Round( ScrH() *.02 ), weight = 500, italic = true  } )
surface.CreateFont( "SethHUD:Fonts:HeadTitle", { font = 'BigNoodleTitling', size = 38, weight = 500 } )
surface.CreateFont( "SethHUD:Fonts:HeadValue", { font = 'Purista', size = 24, weight = 500, italic = true  } )
surface.CreateFont( "SethHUD:Fonts:HeadWanted", { font = 'BigNoodleTitling', size = 60, weight = 500 } )
surface.CreateFont( "SethHUD:Fonts:DoorDisplayTitle", { font = 'BigNoodleTitling', size = 40, weight = 500 } )
surface.CreateFont( "SethHUD:Fonts:DoorDisplayValue", { font = 'Purista', size = 24, weight = 500, italic = true  } )
surface.CreateFont( "SethHUD:Fonts:WarningTitle", { font = 'BigNoodleTitling', size = math.Round( ScrH() *.08 ), weight = 500 } )
surface.CreateFont( "SethHUD:Fonts:WarningValue", { font = 'Purista', size = math.Round( ScrH() *.04 ), weight = 500, italic = true  } )

-- Disabled darkrp & base hud ( True to disabled / false to activated )
SethHUD.Utils.DisabledDarkRPBaseHUD = {
    [ "CHudHealth" ] = true,
	[ "CHudBattery" ] = true,
	[ "DarkRP_Hungermod" ] = true,
	[ "DarkRP_HUD" ] = true,
    [ "DarkRP_LocalPlayerHUD" ] = true,
    [ "CHudSecondaryAmmo" ] = true,
    [ "CHudAmmo" ] = true,
    [ "CHudVoiceStatus" ] = true,
    [ "DarkRP_ZombieInfo" ] = true,
    [ "DarkRP_EntityDisplay" ] = true,
}

-- Colors correction
SethHUD.Utils.HealthColor = {
    [ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 1,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

SethHUD.Utils.WeaponBlackList = {
    [ "weapon_physcannon" ] = true,
}

