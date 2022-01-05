require "Items/Distributions"
require "Items/ProceduralDistributions"

SWWS_Distributions = SWWS_Distributions or {}
SWWS_Distributions.fixLocations = SWWS_Distributions.fixLocations or {} 

-------------------------------------------------------
-- WEATHER STATION LOOT TABLES -- 
-- If you're making a new map that supports weather
-- stations, copy this file, remove the Knox Country
-- specific weather station room defs, and add the ones
-- specific to your own modification.
-------------------------------------------------------

table.insert(SWWS_Distributions.fixLocations, "SWWS_FixLocation_Muld")
table.insert(SWWS_Distributions.fixLocations, "SWWS_FixLocation_Rivs")
table.insert(SWWS_Distributions.fixLocations, "SWWS_FixLocation_Zulu")
table.insert(SWWS_Distributions.fixLocations, "SWWS_FixLocation_Rose")
table.insert(SWWS_Distributions.fixLocations, "SWWS_FixLocation_West")

-------------------------------------------------------
-- MAP DEFAULT --
-- Default map of weather stations to be added to the
-- loot tables in your map.
-------------------------------------------------------
SWWS_Distributions.itemRegister =     "SWWS_KnoxCountry_Register"
-------------------------------------------------------
-- MAP ANNOTATED --
-- An annotated version of your weather station map,
-- used to display a secret station, for examlpe.
-- Set to nil if your map does not include any secret
-- weather stations. 
-------------------------------------------------------
SWWS_Distributions.itemRegisterAnnotated =   "SWWS_KnoxCountry_RegisterAnnotated"
-------------------------------------------------------
-- DIAGNOSTIC MANUAL --
-- The diagnostic manual for looking up error codes. 
-------------------------------------------------------
SWWS_Distributions.itemDiagnosticManual =   "SWWS_Core_DiagnosticManual"
-------------------------------------------------------

local function SWWS_Distributions_Insert(item, target, weight)
    table.insert(ProceduralDistributions.list[target].items, item)
    table.insert(ProceduralDistributions.list[target].items, weight)
end

local function SWWS_KnoxCountry_PreDistributionMerge()
    
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "ShelfGeneric", 0.05)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "ToolStoreBooks", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "LivingRoomShelf", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "LivingRoomShelfNoTapes", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "EngineerTools", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "CrateMagazines", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "BookstoreBooks", 2)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "BookstoreMisc", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "LibraryBooks", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "FilingCabinetGeneric", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "OfficeDesk", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "OfficeDeskHome", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "OfficeDrawers", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegister, "DeskGeneric", 0.1)

    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "ShelfGeneric", 0.01)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "ToolStoreBooks", 0.01)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "LivingRoomShelf", 0.01)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "LivingRoomShelfNoTapes", 0.01)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "EngineerTools", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "CrateMagazines", 0.01)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "BookstoreBooks", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "BookstoreMisc", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "LibraryBooks", 0.5)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "FilingCabinetGeneric", 0.01)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "OfficeDesk", 0.01)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "OfficeDeskHome", 0.01)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "OfficeDrawers", 0.01)
    SWWS_Distributions_Insert(SWWS_Distributions.itemRegisterAnnotated, "DeskGeneric", 0.01)
    
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "ShelfGeneric", 0.05)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "ToolStoreBooks", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "LivingRoomShelf", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "LivingRoomShelfNoTapes", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "EngineerTools", 2)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "CrateMagazines", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "ElectronicStoreMagazines", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "BookstoreBooks", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "BookstoreMisc", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "LibraryBooks", 1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "FilingCabinetGeneric", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "OfficeDesk", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "OfficeDeskHome", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "OfficeDrawers", 0.1)
    SWWS_Distributions_Insert(SWWS_Distributions.itemDiagnosticManual, "DeskGeneric", 0.1)

    ProceduralDistributions.list["SWWS_WeatherStation_Items"] = {
        rolls = 4,
        items = {
            SWWS_Distributions.itemRegister, 16,
            SWWS_Distributions.itemRegisterAnnotated, 4,
            SWWS_Distributions.itemDiagnosticManual, 16
        }
    }

    local distributions = {
        Bag_SurvivorBag = {
            items = {
                SWWS_Distributions.itemRegister, 10,
                SWWS_Distributions.itemRegisterAnnotated, 7,
                SWWS_Distributions.itemDiagnosticManual, 5,   
            }
        },
        Bag_InmateEscapedBag = {
            items = {
                SWWS_Distributions.itemRegister, 10,
                SWWS_Distributions.itemRegisterAnnotated, 7,
                SWWS_Distributions.itemDiagnosticManual, 1,
            }
        },
        inventorymale = {
            items = {
                SWWS_Distributions.itemRegister, 0.05,
                SWWS_Distributions.itemRegisterAnnotated, 0.05,
                SWWS_Distributions.itemDiagnosticManual, 0.01,
            }
        },
        inventorymale = {
            items = {
                SWWS_Distributions.itemRegister, 0.05,
                SWWS_Distributions.itemRegisterAnnotated, 0.05,
                SWWS_Distributions.itemDiagnosticManual, 0.01,
            }
        }
    }

    for i,v in ipairs(SWWS_Distributions.fixLocations) do
        distributions[v] = {
            crate = {
                procedural = true,
                procList = {
                    {name="SWWS_WeatherStation_Items", min=1, max=2, forceForItems="swws_industrial_0_1;swws_industrial_3"},
                    {name="CrateOfficeSupplies", min=0, max=99},
                }
            },
            counter = {
                procedural = true,
                procList = {
                    {name="SWWS_WeatherStation_Items", min=1, max=2, forceForItems="swws_industrial_0_1;swws_industrial_3"},
                    {name="OfficeCounter", min=0, max=99},
                }
            },
            desk = {
                procedural = true,
                procList = {
                    {name="SWWS_WeatherStation_Items", min=1, max=2, forceForItems="swws_industrial_0_1;swws_industrial_3"},
                    {name="OfficeDesk", min=0, max=99, weightChance=100},
                    {name="PoliceDesk", min=0, max=99, forceForRooms="policestorage"},
                }
            },
            fridge = {
                procedural = true,
                procList = {
                    {name="OfficeFridge", min=0, max=99},
                }
            },
            metal_shelves = {
                procedural= true,
                procList = {
                    {name="SWWS_WeatherStation_Items", min=1, max=2, forceForItems="swws_industrial_0_1;swws_industrial_3"},
                    {name="OfficeShelfSupplies", min=0, max=99},
                }
            },
            filingcabinet = {
                procedural = true,
                procList = {
                    {name="SWWS_WeatherStation_Items", min=1, max=2, forceForItems="swws_industrial_0_1;swws_industrial_3"},
                    {name="FilingCabinetGeneric", min=0, max=99},
                }
            },
        }
    end

    table.insert(Distributions, distributions)

end
Events.OnPreDistributionMerge.Add(SWWS_KnoxCountry_PreDistributionMerge);