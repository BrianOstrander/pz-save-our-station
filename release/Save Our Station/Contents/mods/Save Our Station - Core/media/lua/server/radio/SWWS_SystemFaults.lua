SWWS_SystemFaults = {}

SWWS_SystemFaults.solutions = {
    replacePipe = {
        code = "ARPO",
        consumeItem = true,
        drainItem = false,
        chance = 1.0,
        items = {
            "Base.MetalPipe"
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
        id = "AEBS_FaultFuelPump",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replacePipe,
                description = "AEBS_FaultRepairReplaceFuelLine"
            }
        }
    },
    {
        id = "AEBS_FaultTransformer",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replaceElectronicScrap,
                description = "AEBS_FaultRepairControlBoardReplacement"
            },
            {
                solution = SWWS_SystemFaults.solutions.replaceWire,
                description = "AEBS_FaultRepairRerouteShort"
            }
        }
    },
    {
        id = "AEBS_FaultTransmitter",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replaceRadioTransmitter,
                description = "AEBS_FaultRepairReplaceUnit"
            }
        }
    },
    {
        id = "AEBS_FaultReciever",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replaceRadioReceiver,
                description = "AEBS_FaultRepairReplaceUnit"
            }
        }
    },
    {
        id = "AEBS_FaultGenerator",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replacePipe,
                description = "AEBS_FaultRepairReplaceFuelLine"
            },
            {
                solution = SWWS_SystemFaults.solutions.replaceGenerator,
                description = "AEBS_FaultRepairReplaceUnit"
            },
            {
                solution = SWWS_SystemFaults.solutions.replaceEngineParts,
                description = "AEBS_FaultRepairRepairUnit"
            },
            {
                solution = SWWS_SystemFaults.solutions.refuelGasoline,
                description = "AEBS_FaultRepairRefuelGasoline"
            }
        }
    },
    {
        id = "AEBS_FaultDieselUnit",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replacePipe,
                description = "AEBS_FaultRepairReplaceFuelLine"
            },
            {
                solution = SWWS_SystemFaults.solutions.replaceEngineParts,
                description = "AEBS_FaultRepairRepairUnit"
            }
        }
    },
    {
        id = "AEBS_FaultCurrentRegulator",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replaceElectronicScrap,
                description = "AEBS_FaultRepairControlBoardReplacement"
            },
            {
                solution = SWWS_SystemFaults.solutions.replaceWire,
                description = "AEBS_FaultRepairClearShort"
            }
        }
    },
    {
        id = "AEBS_FaultCapacitorArray",
        repairs = {
            {
                solution = SWWS_SystemFaults.solutions.replaceElectronicScrap,
                description = "AEBS_FaultRepairControlBoardReplacement"
            },
            {
                solution = SWWS_SystemFaults.solutions.replaceWire,
                description = "AEBS_FaultRepairClearShort"
            }
        }
    }
}