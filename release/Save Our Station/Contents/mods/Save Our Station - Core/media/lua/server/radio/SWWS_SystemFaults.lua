SWWS_SystemFaults = {}

SWWS_SystemFaults.solutions = {
    replacePipe = {
        code = "ARPO",
        consumeItem = true,
        drainItem = false,
        chance = 1.0,
        items = {
            "Base.LeadPipe"
        }
    },
    replaceElectronicScrap = {
        code = "BRES",
        consumeItem = true,
        drainItem = false,
        chance = 1.0,
        items = {
            "Base.ElectronicsScrap"
        }
    },
    replaceWire = {
        code = "CRWO",
        consumeItem = true,
        drainItem = false,
        chance = 1.0,
        items = {
            "Radio.ElectricWire"
        }   
    },
    replaceRadioTransmitter = {
        code = "DRRT",
        consumeItem = true,
        drainItem = false,
        chance = 1.0,
        items = {
            "Radio.RadioTransmitter"
        }   
    },
    replaceRadioReceiver = {
        code = "ERRR",
        consumeItem = true,
        drainItem = false,
        chance = 1.0,
        items = {
            "Radio.RadioReceiver"
        }   
    },
    replaceGenerator = {
        code = "FRGO",
        consumeItem = true,
        drainItem = false,
        chance = 0.25,
        items = {
            "Base.Generator"
        }   
    },
    replaceEngineParts = {
        code = "GREP",
        consumeItem = true,
        drainItem = false,
        chance = 1.0,
        items = {
            "Base.EngineParts"
        }   
    },
    refuelGasoline = {
        code = "HRGO",
        consumeItem = false,
        drainItem = true,
        chance = 1.0,
        items = {
            "Base.PetrolCan"
        }   
    }
}

SWWS_SystemFaults.pool = {
    {
        id = "FUEL-PUMP",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replacePipe,
                description = "REPLACE FUEL LINE"
            }
        }
    },
    {
        id = "TRANSFORMER",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replaceElectronicScrap,
                description = "CONTROL BOARD REPLACEMENT"
            },
            {
                solution = SWWS_SystemFaults.solutions.replaceWire,
                description = "REROUTE SHORT"
            }
        }
    },
    {
        id = "TRANSMITTER",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replaceRadioTransmitter,
                description = "REPLACE UNIT"
            }
        }
    },
    {
        id = "RECIEVER",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replaceRadioReceiver,
                description = "REPLACE UNIT"
            }
        }
    },
    {
        id = "GENERATOR",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replacePipe,
                description = "REPLACE FUEL LINE"
            },
            {
                solution = SWWS_SystemFaults.solutions.replaceGenerator,
                description = "REPLACE UNIT"
            },
            {
                solution = SWWS_SystemFaults.solutions.replaceEngineParts,
                description = "REPAIR UNIT"
            },
            {
                solution = SWWS_SystemFaults.solutions.refuelGasoline,
                description = "REFUEL GASOLINE"
            }
        }
    },
    {
        id = "DIESEL-UNIT",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replacePipe,
                description = "REPLACE FUEL LINE"
            },
            {
                solution = SWWS_SystemFaults.solutions.replaceEngineParts,
                description = "REPAIR UNIT"
            }
        }
    },
    {
        id = "CURRENT-REGULATOR",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replaceElectronicScrap,
                description = "REPLACE CONTROL BOARD"
            },
            {
                solution = SWWS_SystemFaults.solutions.replaceWire,
                description = "CLEAR SHORT"
            }
        }
    },
    {
        id = "CAPACITOR-ARRAY",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replaceElectronicScrap,
                description = "REPLACE CONTROL BOARD"
            },
            {
                solution = SWWS_SystemFaults.solutions.replaceWire,
                description = "CLEAR SHORT"
            }
        }
    }
}