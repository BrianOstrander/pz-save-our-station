SWWS_Schedules = {}
SWWS_Schedules.stages = {}

SWWS_Schedules.poolTypes = {
    nominal = "nominal",
    nonFatal = "nonfatal",
    fatal = "fatal"
}

SWWS_Schedules.stages.nominal = {
    status = {
        "AEBS_StageStatusNominal_1",
        "AEBS_StageStatusNominal_2",
        "AEBS_StageStatusNominal_3",
        "AEBS_StageStatusNominal_4"
    },
    statusColor = { r = 1.0, g = 1.0, b = 1.0 },
    failureChance = 0
}

SWWS_Schedules.stages.repaired = {
    status = {
        "AEBS_StageStatusRepaired_1",
        "AEBS_StageStatusRepaired_2",
        "AEBS_StageStatusRepaired_3"
    },
    statusColor = { r = 1.0, g = 1.0, b = 1.0 },
    failureChance = 0
}

SWWS_Schedules.stages.detected = {
    status = {
        "AEBS_StageStatusDetected_1",
        "AEBS_StageStatusDetected_2",
        "AEBS_StageStatusDetected_3",
        "AEBS_StageStatusDetected_4"
    },
    statusColor = { r = 1.0, g = 0.976, b = 0.741 },
    failureChance = 25
}

SWWS_Schedules.stages.diagnosing = {
    status = {
        "AEBS_StageStatusDiagnosing_1",
        "AEBS_StageStatusDiagnosing_2",
        "AEBS_StageStatusDiagnosing_3",
        "AEBS_StageStatusDiagnosing_4",
        "AEBS_StageStatusDiagnosing_5",
        "AEBS_StageStatusDiagnosing_6"
    },
    statusColor = { r = 1.0, g = 0.976, b = 0.741 },
    failureChance = 50
}

SWWS_Schedules.stages.rebooting = {
    status = {
        "AEBS_StageStatusRebooting_1",
        "AEBS_StageStatusRebooting_2",
        "AEBS_StageStatusRebooting_3",
        "AEBS_StageStatusRebooting_4"
    },
    statusColor = { r = 1.0, g = 0.976, b = 0.741 },
    failureChance = 100
}

SWWS_Schedules.stages.rerouting = {
    status = {
        "AEBS_StageStatusRerouting_1",
        "AEBS_StageStatusRerouting_2"
    },
    statusColor = { r = 1.0, g = 0.976, b = 0.741 },
    failureChance = 100
}

SWWS_Schedules.stages.rebootSuccess = {
    status = {
        "AEBS_StageStatusRebootSuccess_1",
        "AEBS_StageStatusRebootSuccess_2"
    },
    statusColor = { r = 1.0, g = 0.976, b = 0.741 },
    failureChance = 0
}

SWWS_Schedules.stages.reroutingSuccess = {
    status = {
        "AEBS_StageStatusReroutingSuccess_1",
        "AEBS_StageStatusReroutingSuccess_2"
    },
    statusColor = { r = 1.0, g = 0.976, b = 0.741 },
    failureChance = 0
}

SWWS_Schedules.stages.rebootFailure = {
    status = {
        "AEBS_StageStatusRebootFailure_1",
        "AEBS_StageStatusRebootFailure_2"
    },
    statusColor = { r = 1.0, g = 0.76, b = 0.74 },
    failureChance = 75,
    revealTime = true,
    requestCrew = true
}

SWWS_Schedules.stages.reroutingFailure = {
    status = {
        "AEBS_StageStatusReroutingFailure_1",
        "AEBS_StageStatusReroutingFailure_2"
    },
    statusColor = { r = 1.0, g = 0.76, b = 0.74 },
    failureChance = 75,
    revealTime = true,
    requestCrew = true
}

SWWS_Schedules.stages.fatal = {
    status = {
        "AEBS_StageStatusFatal_1",
        "AEBS_StageStatusFatal_2",
        "AEBS_StageStatusFatal_3",
        "AEBS_StageStatusFatal_4"
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