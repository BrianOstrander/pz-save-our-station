require "Items/Distributions"
require "Items/ProceduralDistributions"

SuburbsDistributions = SuburbsDistributions or {}
ProceduralDistributions = ProceduralDistributions or {}

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
SWWS_Distributions.mapDefault =     "SWWS_KnoxCountry.Register"
-------------------------------------------------------
-- MAP ANNOTATED --
-- An annotated version of your weather station map,
-- used to display a secret station, for examlpe.
-- Set to nil if your map does not include any secret
-- weather stations. 
-------------------------------------------------------
SWWS_Distributions.mapAnnotated =   "SWWS_KnoxCountry.RegisterAnnotated"
-------------------------------------------------------

SWWS_Distributions.defaults = SWWS_Distributions.defaults or {}

SWWS_Distributions.defaults.metal_shelves = {
    rolls = 2,
    items = {
        "Magazine", 2,
        "Newspaper", 2,
        "MuldraughMap", 2,
        "WestpointMap", 2,
        "MarchRidgeMap",1,
        "RosewoodMap",1,
        "RiversideMap",1
    }
}

SWWS_Distributions.defaults.desk = {
    rolls = 1,
    items = {
        "PillsVitamins", 1,
        "Magazine", 2,
        "Newspaper", 2,
        "Book", 2,
        "ComicBook", 1,
        "Cigarettes", 1,
        "Radio.RadioBlack",2,
        "Radio.RadioRed",1,
        "Radio.WalkieTalkie1",0.05,
        "Radio.WalkieTalkie2",0.03,
        "Radio.WalkieTalkie3",0.001
    },
    junk = {
        rolls = 1,
        items = {
            "MakeupEyeshadow", 1,
            "MakeupFoundation", 1,
            "Razor", 1,
            "CardDeck", 1,
            "Comb", 2,
            "Paperclip", 1,
            "Disc", 1,
            "CDplayer", 0.4,
            "Doll", 1,
            "Lipstick", 1,
            "SheetPaper2", 20,
            "Notebook", 2,
            "Pencil", 15,
            "RubberBand", 7,
            "Eraser", 7,
            "Pen", 30,
            "BluePen", 10,
            "RedPen", 10,
            "Scissors", 3,
            "Cube", 1,
            "Cologne", 1,
            "Perfume", 1
        },
    }
}

SWWS_Distributions.defaults.filingcabinet = {
    rolls = 1,
    items = {
        "Magazine", 4,
        "Newspaper", 4,
        "Book", 4
    },
    junk = {
        rolls = 1,
        items = {
            "SheetPaper2", 20,
            "SheetPaper2", 20,
            "SheetPaper2", 20,
            "SheetPaper2", 20,
            "Notebook", 4
        },
    }
}

SWWS_Distributions.defaults.crate = {
    rolls = 2,
    items = {
        "DuctTape", 0.8,
        "Wire", 2,
        "Battery", 4,
        "Torch", 1,
        "HandTorch", 1,
        "Radio.WalkieTalkie1",0.05,
        "Radio.WalkieTalkie2",0.03,
        "Radio.WalkieTalkie3",0.001,
        "Radio.HamRadio1",0.005,
        "SheetMetal", 2,
        "SmallSheetMetal", 2.4,
        "Wrench", 0.5
    }
}

SWWS_Distributions.defaults.counter = {
    rolls = 1,
    items = {
        "Battery", 2,
        "Torch", 2,
        "HandTorch", 3,
        "Radio.RadioBlack",2,
        "Radio.RadioRed",1,
        "Radio.WalkieTalkie1",0.05,
        "Radio.WalkieTalkie2",0.03,
        "Radio.WalkieTalkie3",0.001
    },
    
    junk = {
        rolls = 1,
        items = {
            "Pen", 4,
            "BluePen", 2,
            "RedPen", 2,
            "Pencil", 4,
            "RubberBand", 2
        },
    },
}

local function SWWS_InsertDistribution(location, container, item, chance)

    if not item then
        return
    end

    if not SuburbsDistributions[location] then
        SuburbsDistributions[location] = {}
    end

    if container then
        local currentDistribution = SuburbsDistributions[location][container]

        if not currentDistribution then
            currentDistribution = {
                rolls = 1,
                items = {},
                junk = {
                    rolls = 0,
                    items = {}
                }
            }

            SuburbsDistributions[location][container] = currentDistribution
            
            local defaultDistribution = SWWS_Distributions.defaults[container]

            if defaultDistribution then
                currentDistribution.rolls = defaultDistribution.rolls
                for i,v in ipairs(defaultDistribution.items) do
                    table.insert(currentDistribution.items, v)
                end
                if defaultDistribution.junk then
                    currentDistribution.junk.rolls = defaultDistribution.junk.rolls
                    for i,v in ipairs(defaultDistribution.junk.items) do
                        table.insert(currentDistribution.junk.items, v)
                    end
                end
            end
        end

        table.insert(currentDistribution.items, item)
        table.insert(currentDistribution.items, chance)
    elseif SuburbsDistributions[location].items then
        table.insert(SuburbsDistributions[location].items, item)
        table.insert(SuburbsDistributions[location].items, chance)
    end
end

for i,v in ipairs(SWWS_Distributions.fixLocations) do

    -------------------------------------------------------
    -- DIAGNOSTIC MANUALS --
    ------------------------------------------------------- 
    SWWS_InsertDistribution(v, "crate",         "SWWS_Core.DiagnosticManual",  10)
    SWWS_InsertDistribution(v, "metal_shelves", "SWWS_Core.DiagnosticManual",  5)
    SWWS_InsertDistribution(v, "filingcabinet", "SWWS_Core.DiagnosticManual",  100)
    SWWS_InsertDistribution(v, "desk",          "SWWS_Core.DiagnosticManual",  1)
    SWWS_InsertDistribution(v, "counter",       "SWWS_Core.DiagnosticManual",  1)
    -------------------------------------------------------
    -- KNOX COUNTRY REGISTERS --
    -------------------------------------------------------
    SWWS_InsertDistribution(v, "crate",         SWWS_Distributions.mapDefault,  10)
    SWWS_InsertDistribution(v, "metal_shelves", SWWS_Distributions.mapDefault,  5)
    SWWS_InsertDistribution(v, "filingcabinet", SWWS_Distributions.mapDefault,  100)
    SWWS_InsertDistribution(v, "desk",          SWWS_Distributions.mapDefault,  1)
    SWWS_InsertDistribution(v, "counter",       SWWS_Distributions.mapDefault,  1)

    SWWS_InsertDistribution(v, "crate",         SWWS_Distributions.mapAnnotated,  5)
    SWWS_InsertDistribution(v, "metal_shelves", SWWS_Distributions.mapAnnotated,  5)
    SWWS_InsertDistribution(v, "filingcabinet", SWWS_Distributions.mapAnnotated,  5)
    -------------------------------------------------------
end

-------------------------------------------------------
-- DIAGNOSTIC MANUALS --
------------------------------------------------------- 
SWWS_InsertDistribution("Electrician",      "counter",          "SWWS_Core.DiagnosticManual",  1)
SWWS_InsertDistribution("electronicsstore", "counter",          "SWWS_Core.DiagnosticManual",  0.1)
SWWS_InsertDistribution("electronicsstore", "shelves",          "SWWS_Core.DiagnosticManual",  0.5)
SWWS_InsertDistribution("library",          "counter",          "SWWS_Core.DiagnosticManual",  0.1)
SWWS_InsertDistribution("mechanic",         "metalshelves",     "SWWS_Core.DiagnosticManual",  1)
SWWS_InsertDistribution("bookstore",        "other",            "SWWS_Core.DiagnosticManual",  2.5)
SWWS_InsertDistribution("bookstore",        "other",            "SWWS_Core.DiagnosticManual",  0.5)
SWWS_InsertDistribution("garagestorage",    "other",            "SWWS_Core.DiagnosticManual",  1)
SWWS_InsertDistribution("all",              "shelves",          "SWWS_Core.DiagnosticManual",  1)
SWWS_InsertDistribution("all",              "desk",             "SWWS_Core.DiagnosticManual",  0.01)
SWWS_InsertDistribution("shed",             "other",            "SWWS_Core.DiagnosticManual",  0.1)
SWWS_InsertDistribution("all",              "sidetable",        "SWWS_Core.DiagnosticManual",  0.01)
SWWS_InsertDistribution("Bag_SurvivorBag",  nil,                "SWWS_Core.DiagnosticManual",  0.5)

-------------------------------------------------------
-- KNOX COUNTRY REGISTERS --
------------------------------------------------------- 

SWWS_InsertDistribution("Electrician",              "counter",          SWWS_Distributions.mapDefault,      1)
SWWS_InsertDistribution("electronicsstore",         "counter",          SWWS_Distributions.mapDefault,      0.1)
SWWS_InsertDistribution("library",                  "counter",          SWWS_Distributions.mapDefault,      0.1)
SWWS_InsertDistribution("mechanic",                 "metalshelves",     SWWS_Distributions.mapDefault,      0.1)
SWWS_InsertDistribution("bookstore",                "other",            SWWS_Distributions.mapAnnotated,    1)
SWWS_InsertDistribution("bookstore",                "other",            SWWS_Distributions.mapDefault,      2)
SWWS_InsertDistribution("bookstore",                "other",            SWWS_Distributions.mapAnnotated,    0.1)
SWWS_InsertDistribution("bookstore",                "other",            SWWS_Distributions.mapDefault,      0.5)
SWWS_InsertDistribution("garagestorage",            "other",            SWWS_Distributions.mapDefault,      1.25)
SWWS_InsertDistribution("garagestorage",            "other",            SWWS_Distributions.mapAnnotated,    0.25)
SWWS_InsertDistribution("all",                      "shelves",          SWWS_Distributions.mapDefault,      1.1)
SWWS_InsertDistribution("all",                      "shelves",          SWWS_Distributions.mapAnnotated,    0.15)
SWWS_InsertDistribution("all",                      "desk",             SWWS_Distributions.mapDefault,      0.015)
SWWS_InsertDistribution("all",                      "desk",             SWWS_Distributions.mapAnnotated,    0.0015)
SWWS_InsertDistribution("all",                      "sidetable",        SWWS_Distributions.mapDefault,      0.015)
SWWS_InsertDistribution("all",                      "sidetable",        SWWS_Distributions.mapAnnotated,    0.0015)
SWWS_InsertDistribution("shed",                     "other",            SWWS_Distributions.mapDefault,      0.15)
SWWS_InsertDistribution("shed",                     "other",            SWWS_Distributions.mapAnnotated,    0.025)
SWWS_InsertDistribution("Bag_InmateEscapedBag",     nil,                SWWS_Distributions.mapDefault,      0.1)
SWWS_InsertDistribution("Bag_InmateEscapedBag",     nil,                SWWS_Distributions.mapAnnotated,    0.05)
SWWS_InsertDistribution("Bag_SurvivorBag",          nil,                SWWS_Distributions.mapDefault,      5)
SWWS_InsertDistribution("Bag_SurvivorBag",          nil,                SWWS_Distributions.mapAnnotated,    2)