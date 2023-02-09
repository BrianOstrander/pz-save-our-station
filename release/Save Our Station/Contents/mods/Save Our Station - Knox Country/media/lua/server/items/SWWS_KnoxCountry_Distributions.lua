require "Items/Distributions"
require "Items/ProceduralDistributions"
require "Items/VehicleDistributions"

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

-- MISCELLANEOUS --
-- Various items added to the world for flavor.
-------------------------------------------------------
SWWS_Distributions.itemWswuCard =   "SWWS_KnoxCountry_WswuCard"
-------------------------------------------------------

local function SWWS_VehicleDistributions_Insert(item, target, weight)
    table.insert(VehicleDistributions[target].junk.items, item)
    table.insert(VehicleDistributions[target].junk.items, weight)
end

local function SWWS_Distributions_Insert(item, target, weight)
    table.insert(ProceduralDistributions.list[target].items, item)
    table.insert(ProceduralDistributions.list[target].items, weight)
end

local function SWWS_KnoxCountry_PreDistributionMerge()
    
    -- Insert items into existing distribution tables.

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

    -- Create a procedural distribution table for weather station items.

    -- ProceduralDistributions.list["SWWS_WeatherStation_Items"] = {
    --     rolls = 4,
    --     items = {
    --         SWWS_Distributions.itemRegister, 16,
    --         SWWS_Distributions.itemRegisterAnnotated, 4,
    --         SWWS_Distributions.itemDiagnosticManual, 16,
    --         SWWS_Distributions.itemWswuCard, 6,
    --     }
    -- }

    ProceduralDistributions.list["SWWS_WeatherStation_Desk_Items"] = {
        rolls = 4,
        items = {
            "BluePen", 8,
            "Glue", 2,
            "HolePuncher", 4,
            "Notebook", 20,
            "Notebook", 10,
            "Paperclip", 10,
            "PaperclipBox", 1,
            "Pen", 20,
            "Pen", 10,
            "Pencil", 20,
            "Pencil", 10,
            "RedPen", 8,
            "RubberBand", 6,
            "Scissors", 2,
            "Scotchtape", 4,
            "SheetPaper2", 20,
            "SheetPaper2", 20,
            "SheetPaper2", 10,
            "SheetPaper2", 10,
            "Staples", 4,
            "Stapler", 4,
        },
        junk = {
            rolls = 1,
            items = {
                SWWS_Distributions.itemRegister, 5,
                SWWS_Distributions.itemRegisterAnnotated, 25,
                SWWS_Distributions.itemDiagnosticManual, 25,
                SWWS_Distributions.itemWswuCard, 40,
            }
        }
    }

    ProceduralDistributions.list["SWWS_WeatherStation_Counter_Items"] = {
        rolls = 4,
        items = {
            "BluePen", 8,
            "Book", 10,
            "Eraser", 8,
            "Glue", 2,
            "HolePuncher", 4,
            "Magazine", 10,
            "MagazineCrossword1", 2,
            "MagazineCrossword2", 2,
            "MagazineCrossword3", 2,
            "MagazineWordsearch1", 2,
            "MagazineWordsearch2", 2,
            "MagazineWordsearch3", 2,
            "Notebook", 10,
            "Paperclip", 10,
            "PaperclipBox", 1,
            "Pen", 8,
            "Pencil", 10,
            "Radio.RadioBlack", 1,
            "Radio.RadioRed", 1,
            "RedPen", 8,
            "RubberBand", 6,
            "Scissors", 2,
            "Scotchtape", 4,
            "SheetPaper2", 20,
            "SheetPaper2", 10,
            "Stapler", 4,
            "Staples", 4,
        },
        junk = {
            rolls = 1,
            items = {
                SWWS_Distributions.itemRegister, 25,
                SWWS_Distributions.itemRegisterAnnotated, 1,
                SWWS_Distributions.itemDiagnosticManual, 25,
            }
        }
    }

    ProceduralDistributions.list["SWWS_WeatherStation_Drawers_Items"] = {
        rolls = 4,
        items = {
            "BluePen", 8,
            "Disc_Retail", 2,
            "Eraser", 8,
            "Glue", 2,
            "HolePuncher", 4,
            "LetterOpener", 1,
            "Magazine", 10,
            "MagazineCrossword1", 2,
            "MagazineCrossword2", 2,
            "MagazineCrossword3", 2,
            "MagazineWordsearch1", 2,
            "MagazineWordsearch2", 2,
            "MagazineWordsearch3", 2,
            "Newspaper", 10,
            "Notebook", 10,
            "Paperclip", 10,
            "PaperclipBox", 1,
            "Pen", 8,
            "Pencil", 10,
            "Radio.CDplayer", 1,
            "Radio.RadioBlack", 2,
            "Radio.RadioRed", 1,
            "RedPen", 8,
            "RubberBand", 6,
            "Scissors", 2,
            "Scotchtape", 4,
            "SheetPaper2", 20,
            "SheetPaper2", 10,
            "Stapler", 4,
            "Staples", 4,
        },
        junk = {
            rolls = 1,
            items = {
                SWWS_Distributions.itemRegister, 25,
                SWWS_Distributions.itemRegisterAnnotated, 5,
                SWWS_Distributions.itemDiagnosticManual, 25,
            }
        }
    }

    ProceduralDistributions.list["SWWS_WeatherStation_Bin_Items"] = {
        rolls = 4,
        items = {
            "BandageDirty", 1,
            "BeerCanEmpty", 2,
            "BeerEmpty", 1,
            "Cockroach", 2,
            "Cockroach", 2,
            "ElectronicsScrap", 2,
            "brokenglass_1_0", 1,
            "brokenglass_1_1", 1,
            "brokenglass_1_2", 1,
            "brokenglass_1_3", 1,
            "PopBottleEmpty", 2,
            "PopEmpty", 4,
            "ScrapMetal", 2,
            "SmashedBottle", 1,
            "TinCanEmpty", 4,
            "WaterBottleEmpty", 2,
            "WhiskeyEmpty", 1,
            "WineEmpty", 1,
            "WineEmpty2", 1,
        },
        junk = {
            rolls = 1,
            items = {
                SWWS_Distributions.itemRegister, 5,
                SWWS_Distributions.itemRegisterAnnotated, 50,
                SWWS_Distributions.itemDiagnosticManual, 5,
                "DeadMouse", 2,
                "DeadRat", 4,
                "Garbagebag", 100,
            }
        }
    }

    local distributions = {
        Bag_SurvivorBag = {
            items = {
                SWWS_Distributions.itemRegister, 10,
                SWWS_Distributions.itemRegisterAnnotated, 7,
                SWWS_Distributions.itemDiagnosticManual, 5,
                SWWS_Distributions.itemWswuCard, 2,
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
                SWWS_Distributions.itemWswuCard, 0.01,
            }
        },
        inventorymale = {
            items = {
                SWWS_Distributions.itemRegister, 0.05,
                SWWS_Distributions.itemRegisterAnnotated, 0.05,
                SWWS_Distributions.itemDiagnosticManual, 0.01,
                SWWS_Distributions.itemWswuCard, 0.01,
            }
        }
    }

    -- Available tables:
    --  SWWS_WeatherStation_Desk_Items
    --  SWWS_WeatherStation_Counter_Items
    --  SWWS_WeatherStation_Drawers_Items
    --  SWWS_WeatherStation_Bin_Items

    for i,v in ipairs(SWWS_Distributions.fixLocations) do
        distributions[v] = {
            crate = {
                procedural = true,
                procList = {
                    {name="SWWS_WeatherStation_Drawers_Items", min=1, max=99, forceForItems="swws_industrial_0_1;swws_industrial_0_3"},
                    {name="CrateOfficeSupplies", min=0, max=99},
                }
            },
            counter = {
                procedural = true,
                procList = {
                    {name="SWWS_WeatherStation_Counter_Items", min=1, max=99, forceForItems="swws_industrial_0_1;swws_industrial_0_3"},
                    {name="OfficeCounter", min=0, max=99},
                }
            },
            desk = {
                procedural = true,
                procList = {
                    {name="SWWS_WeatherStation_Desk_Items", min=1, max=99, forceForItems="swws_industrial_0_1;swws_industrial_0_3"},
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
                    {name="SWWS_WeatherStation_Drawers_Items", min=1, max=99, forceForItems="swws_industrial_0_1;swws_industrial_0_3"},
                    {name="OfficeShelfSupplies", min=0, max=99},
                }
            },
            filingcabinet = {
                procedural = true,
                procList = {
                    {name="SWWS_WeatherStation_Drawers_Items", min=1, max=99, forceForItems="swws_industrial_0_1;swws_industrial_0_3"},
                    {name="FilingCabinetGeneric", min=0, max=99},
                }
            },
            bin = {
                procedural = true,
                procList = {
                    {name="SWWS_WeatherStation_Bin_Items", min=1, max=99, forceForItems="swws_industrial_0_1;swws_industrial_0_3"},
                    {name="BinGeneric", min=0, max=99},
                }
            },
        }
    end

    -- Insert our distributions into the existing table.
    table.insert(Distributions, distributions)

    if not VehicleDistributions then
        print("SWWS: Error, VehicleDistributions has not been defined!")
    else

        -- Insert items to existing distribution tables.
        SWWS_VehicleDistributions_Insert(SWWS_Distributions.itemWswuCard, "GloveBox", 0.01)

        -- Create new distribution tables for new vehicles.

        -- Modified Fossoil PickUp
        VehicleDistributions.SWWS_GloveBox = {
            rolls = 4,
            items = {
                "AlcoholWipes", 8,
                "Bandage", 4,
                "Bandaid", 10,
                "Battery", 10,
                "BluePen", 8,
                "Cigarettes", 8,
                "Cologne", 4,
                "Comb", 4,
                "CreditCard", 4,
                "Disc_Retail", 2,
                "DuctTape", 2,
                "Earbuds", 2,
                "Eraser", 6,
                "Lighter", 4,
                "Lipstick", 6,
                "Magazine", 10,
                "MakeupEyeshadow", 6,
                "MakeupFoundation", 6,
                "Matches", 8,
                "Mirror", 4,
                "Notebook", 10,
                "Paperclip", 4,
                "Pen", 8,
                "Pencil", 10,
                "Perfume", 4,
                "Razor", 4,
                "RedPen", 8,
                "RubberBand", 6,
                "Scotchtape", 8,
                "Tissue", 10,
                "Twine", 10,
            },
            junk = {
                rolls = 1,
                items = {
                    SWWS_Distributions.itemRegister, 80,
                    SWWS_Distributions.itemDiagnosticManual, 80,
                    SWWS_Distributions.itemRegisterAnnotated, 40,
                    SWWS_Distributions.itemWswuCard, 75,
                    "Camera", 0.03,
                    "CameraDisposable", 0.05,
                    "CameraExpensive", 0.001,
                    "Glasses_Aviators", 0.05,
                    "Glasses_SafetyGoggles", 20,
                    "Glasses_Sun", 0.1,
                    "Gloves_LeatherGloves", 20,
                    "Gloves_LeatherGlovesBlack", 0.05,
                    "HandTorch", 4,
                    "HuntingKnife", 0.1,
                    "LouisvilleMap1", 4,
                    "LouisvilleMap2", 4,
                    "LouisvilleMap3", 4,
                    "LouisvilleMap4", 4,
                    "LouisvilleMap5", 4,
                    "LouisvilleMap6", 4,
                    "LouisvilleMap7", 4,
                    "LouisvilleMap8", 4,
                    "LouisvilleMap9", 4,
                    "MarchRidgeMap", 4,
                    "MuldraughMap", 4,
                    "Pistol", 0.8,
                    "Pistol2", 0.6,
                    "Radio.CDplayer", 2,
                    "Radio.WalkieTalkie2", 2,
                    "Radio.WalkieTalkie3", 1,
                    "Revolver_Short", 0.8,
                    "RiversideMap", 4,
                    "RosewoodMap", 4,
                    "ToiletPaper", 4,
                    "Wallet", 4,
                    "Wallet2", 4,
                    "Wallet3", 4,
                    "Wallet4", 4,
                    "WestpointMap", 4,
                    "WhiskeyFull", 0.5,
                }
            }
        }

        -- Modified Fossoil PickUp
        VehicleDistributions.SWWS_PickUp_TruckBed = {
            rolls = 4,
            items = {
                "Axe", 4,
                "DuctTape", 8,
                "EmptyPetrolCan", 10,
                "EmptySandbag", 4,
                "Garbagebag", 6,
                "Glasses_SafetyGoggles", 10,
                "Gloves_LeatherGloves", 10,
                "Hat_DustMask", 10,
                "Hat_HardHat", 10,
                "Plasticbag", 10,
                "Rope", 10,
                "RubberBand", 6,
                "Saw", 8,
                "Tarp", 10,
                "Tissue", 10,
                "ToiletPaper", 6,
                "Tote", 6,
                "Twine", 10,
                "Vest_Foreman", 1,
                "Vest_HighViz", 4,
                "WoodAxe", 2,
            },
            junk = {
                rolls = 1,
                items = {
                    SWWS_Distributions.itemRegister, 40,
                    SWWS_Distributions.itemDiagnosticManual, 40,
                    SWWS_Distributions.itemRegisterAnnotated, 10,
                    "Axe", 20,
                    "CarBattery2", 4,
                    "FirstAidKit", 4,
                    "Jack", 2,
                    "LugWrench", 8,
                    "NormalTire2", 10,
                    "Screwdriver", 10,
                    "TirePump", 8,
                    "Wrench", 8,
                }
            }
        }

        VehicleDistributions.SWWS_PickUp = {
            TruckBed = VehicleDistributions.SWWS_PickUp_TruckBed;
        
            TruckBedOpen = VehicleDistributions.SWWS_PickUp_TruckBed;
        
            TrailerTrunk =  VehicleDistributions.SWWS_PickUp_TruckBed;
        
            GloveBox = VehicleDistributions.SWWS_GloveBox;
        
            SeatRearLeft = VehicleDistributions.Seat;
            SeatRearRight = VehicleDistributions.Seat;
        }

        -- Modified Radio
        VehicleDistributions.SWWS_Radio_TruckBed = {
            rolls = 4,
            items = {
                "CameraExpensive", 10,
                "CameraExpensive", 20,
                "CameraFilm", 10,
                "CameraFilm", 10,
                "CameraFilm", 20,
                "CameraFilm", 20,
                "CameraFilm", 50,
                "DuctTape", 8,
                "EmptyPetrolCan", 10,
                "Headphones", 20,
                "Mov_Microphone", 10,
                "Mov_Microphone", 20,
                "PopBottleEmpty", 4,
                "PopEmpty", 4,
                "Radio.ElectricWire", 10,
                "Radio.ElectricWire", 20,
                "Radio.RadioMag1", 2,
                "Radio.RadioMag2", 2,
                "Radio.RadioMag3", 2,
                "Radio.RadioReceiver", 10,
                "Radio.RadioTransmitter", 10,
                "Radio.ScannerModule", 10,
                "Radio.WalkieTalkie2", 20,
                "Radio.WalkieTalkie3", 10,
                "RubberBand", 6,
                "Tarp", 10,
                "Tissue", 10,
                "ToiletPaper", 6,
                "Tote", 6,
                "Twine", 10,
                "WaterBottleEmpty", 4,
                "WhiskeyEmpty", 1,
            },
            junk = {
                rolls = 1,
                items = {
                    SWWS_Distributions.itemRegister, 40,
                    SWWS_Distributions.itemDiagnosticManual, 40,
                    SWWS_Distributions.itemRegisterAnnotated, 10,
                    "BaseballBat", 1,
                    "FirstAidKit", 4,
                    "CarBattery2", 4,
                    "Jack", 2,
                    "LugWrench", 8,
                    "Mov_TVCamera", 20,
                    "NormalTire2", 10,
                    "Radio.HamRadio1", 100,
                    "Screwdriver", 10,
                    "TirePump", 8,
                    "Wrench", 8,
                }
            }
        }

        VehicleDistributions.SWWS_Radio = {
            TruckBed = VehicleDistributions.SWWS_Radio_TruckBed;
        
            TruckBedOpen = VehicleDistributions.SWWS_Radio_TruckBed;
        
            TrailerTrunk =  VehicleDistributions.SWWS_Radio_TruckBed;
        
            GloveBox = VehicleDistributions.SWWS_GloveBox;
        
            SeatRearLeft = VehicleDistributions.Seat;
            SeatRearRight = VehicleDistributions.Seat;
        }

        -- Local copy of the main vehicle distribution table.
        local vehicleDistributions = VehicleDistributions[1]

        vehicleDistributions.SWWS_PickUp = { Normal = VehicleDistributions.SWWS_PickUp }
        vehicleDistributions.SWWS_PickUpVan = { Normal = VehicleDistributions.SWWS_PickUp }
        vehicleDistributions.SWWS_Radio = { Normal = VehicleDistributions.SWWS_Radio }

        -- Add our new distribution tables for vehicels to existing table.
        table.insert(VehicleDistributions, vehicleDistribution)
    end

end
Events.OnPreDistributionMerge.Add(SWWS_KnoxCountry_PreDistributionMerge);