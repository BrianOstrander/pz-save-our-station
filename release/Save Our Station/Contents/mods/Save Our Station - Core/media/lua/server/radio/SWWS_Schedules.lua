SWWS_Schedules = {}
SWWS_Schedules.stages = {}

SWWS_Schedules.poolTypes = {
    nominal = "nominal",
    nonFatal = "nonfatal",
    fatal = "fatal"
}

SWWS_Schedules.stages.nominal = {
    status = {
        "Condition nominal.",
        "No issues detected.",
        "Operation OK.",
        "Infrastructure stable."
    },
    statusColor = { r = 1.0, g = 1.0, b = 1.0 },
    failureChance = 0
}

SWWS_Schedules.stages.repaired = {
    status = {
        "Repairs successful.",
        "Network functionality restored.",
        "All systems restored."
    },
    statusColor = { r = 1.0, g = 1.0, b = 1.0 },
    failureChance = 0
}

SWWS_Schedules.stages.detected = {
    status = {
        "<Condition> detected.",
        "<Condition> <fuzz>",
        "<fuzz> detected.",
        "<fuzz>"
    },
    statusColor = { r = 1.0, g = 0.976, b = 0.741 },
    failureChance = 25
}

SWWS_Schedules.stages.diagnosing = {
    status = {
        "Diagnosing <condition>.",
        "Diagnosing <fuzz>",
        "<fuzz> <condition>.",
        "Inconclusive diagnostic <fuzz> Restarting diagnostics.",
        "Results corrupted <fuzz> Restarting diagnostics.",
        "Non-fatal diagnostic error <fuzz> Restarting diagnostics."
    },
    statusColor = { r = 1.0, g = 0.976, b = 0.741 },
    failureChance = 50
}

SWWS_Schedules.stages.rebooting = {
    status = {
        "<Condition> identified <fuzz> Initiating reboot.",
        "<Condition> identified <fuzz> Rebooting.",
        "<Condition> identified <fuzz> Rebooting <system>.",
        "<Condition> identified in <system> <fuzz> Rebooting."
    },
    statusColor = { r = 1.0, g = 0.976, b = 0.741 },
    failureChance = 100
}

SWWS_Schedules.stages.rerouting = {
    status = {
        "<Condition> identified <fuzz> Rerouting network activity to avoid <condition>.",
        "Rerouting network traffic to avoid <condition>."
    },
    statusColor = { r = 1.0, g = 0.976, b = 0.741 },
    failureChance = 100
}

SWWS_Schedules.stages.rebootSuccess = {
    status = {
        "<Condition> identified <fuzz> Reboot successful.",
        "<Condition> identified in <system> <fuzz> Rebooting resolved <condition>."
    },
    statusColor = { r = 1.0, g = 0.976, b = 0.741 },
    failureChance = 0
}

SWWS_Schedules.stages.reroutingSuccess = {
    status = {
        "Successfully rerouted network traffic <fuzz> <Condition> excised from network.",
        "Network traffic rerouted <fuzz> Resolved <condition> in <system>."
    },
    statusColor = { r = 1.0, g = 0.976, b = 0.741 },
    failureChance = 0
}

SWWS_Schedules.stages.rebootFailure = {
    status = {
        "<Condition> identified <fuzz> Reboot failed.",
        "<Condition> identified in <system> <fuzz> Rebooting failed to resolve <condition>."
    },
    statusColor = { r = 1.0, g = 0.76, b = 0.74 },
    failureChance = 75,
    revealTime = true,
    requestCrew = true
}

SWWS_Schedules.stages.reroutingFailure = {
    status = {
        "Failed to reroute network traffic <fuzz> <Condition> persists in network.",
        "Network traffic unable to reroute <fuzz> Failed to resolve <condition> in <system>."
    },
    statusColor = { r = 1.0, g = 0.76, b = 0.74 },
    failureChance = 75,
    revealTime = true,
    requestCrew = true
}

SWWS_Schedules.stages.fatal = {
    status = {
        "<fuzz> Fatal <condition>... <fuzz>",
        "<fuzz> Fatal <fuzz>",
        "Fatal <condition>...",
        "Fatal <condition> <fuzz> Network in emergency stanby..."
    },
    statusColor = { r = 1.0, g = 0.76, b = 0.74 },
    failureChance = 100,
    requestCrew = true
}

SWWS_Schedules.pool = {
    -- Nominal
    {
        id = "nominal-0",
        poolType = SWWS_Schedules.poolTypes.nominal,
        stages = {
            {
                hoursMinimum = 1,
                hoursMaximum = 7,
                messages = SWWS_Schedules.stages.nominal
            }
        }
    },
    -- Fatal
    {
        id = "fatal-0",
        poolType = SWWS_Schedules.poolTypes.fatal,
        stages = {
            {
                hoursMinimum = 7,
                hoursMaximum = 12,
                messages = SWWS_Schedules.stages.nominal
            },
            {
                hoursMinimum = 1,
                hoursMaximum = 1,
                messages = SWWS_Schedules.stages.detected
            },
            {
                hoursMinimum = 1,
                hoursMaximum = 1,
                messages = SWWS_Schedules.stages.diagnosing
            },
            {
                hoursMinimum = 1,
                hoursMaximum = 1,
                messages = SWWS_Schedules.stages.rebooting
            },
            {
                hoursMinimum = 1,
                hoursMaximum = 1,
                messages = SWWS_Schedules.stages.rebootFailure
            },
            {
                hoursMinimum = 1,
                hoursMaximum = 1,
                messages = SWWS_Schedules.stages.fatal
            }
        }
    },
    {
        id = "fatal-1",
        poolType = SWWS_Schedules.poolTypes.fatal,
        stages = {
            {
                hoursMinimum = 7,
                hoursMaximum = 12,
                messages = SWWS_Schedules.stages.nominal
            },
            {
                hoursMinimum = 1,
                hoursMaximum = 1,
                messages = SWWS_Schedules.stages.detected
            },
            {
                hoursMinimum = 1,
                hoursMaximum = 1,
                messages = SWWS_Schedules.stages.diagnosing
            },
            {
                hoursMinimum = 1,
                hoursMaximum = 1,
                messages = SWWS_Schedules.stages.rerouting
            },
            {
                hoursMinimum = 1,
                hoursMaximum = 1,
                messages = SWWS_Schedules.stages.reroutingFailure
            },
            {
                hoursMinimum = 1,
                hoursMaximum = 1,
                messages = SWWS_Schedules.stages.fatal
            }
        }
    }
}