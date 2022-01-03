SWWS_Localization = {} 

function SWWS_Localization.GetLine(key)
    local language = tostring(Translator.getLanguage())

    if not language then
        print("SWWS: Error, nil language specified")
        return "<Nil language specified>"
    end

    local localization = SWWS_Localization[key]

    if not localization then
        print("SWWS: Error, no localization for key " .. key)
        return "<No value for " .. key .. ">"
    end

    local localizationFallback = localization["EN"]

    if not localizationFallback then
        print("SWWS: Error, no fallback defined for key " .. key)
        return "<No fallback value for " .. key .. ">"
    end

    local localizationResult = localization[language]

    if localizationResult then
        return localizationResult
    end

    if SWWS_Config.debug.logging then
        print("SWWS: No localization found for " .. language)
    end

    return localizationFallback
end

-- ////////////////////////////////////////////
-- /////////// LOCALIZED DATA BELOW ///////////
-- ////////////////////////////////////////////

SWWS_Localization.AEBS_Integrity = {
    EN = "Emergency Broadcast Integrity..."
}

SWWS_Localization.AEBS_ConditionNominal = {
    EN = "Condition nominal."
}

SWWS_Localization.AEBS_KnoxPowerGridStatusUnavailable = {
    EN = "Knox Power Grid: Status Unavailable..."
}

SWWS_Localization.AEBS_ForcastOffline = {
    EN = "Forcast: Offline..."
}

SWWS_Localization.AEBS_AirTrafficRadarDisabled = {
    EN = "Air Traffic: Radar Disabled..."
}

SWWS_Localization.AEBS_EmergencyShutdownImminent = {
    EN = "Emergency shutdown imminent..."
}

SWWS_Localization.AEBS_EmergencyShutdownInHours = {
    EN = "Emergency shutdown in {hours} hours..."
}

SWWS_Localization.AEBS_EmergencyShutdownInDays = {
    EN = "Emergency shutdown in {days} days..."
}

SWWS_Localization.AEBS_ConditionFault = {
    EN = "fault"
}

SWWS_Localization.AEBS_ConditionAnomaly = {
    EN = "anomaly"
}

SWWS_Localization.AEBS_ConditionDefect = {
    EN = "defect"
}

SWWS_Localization.AEBS_ConditionFailure = {
    EN = "failure"
}

SWWS_Localization.AEBS_LocationRequiresUtilCrewDispatch = {
    EN = "{location} requires util-crew dispatch..."
}

SWWS_Localization.AEBS_DiagnosticCode = {
    EN = "Diagnostic Code [ {code} ] {system} - {description}"
}

SWWS_Localization.AEBS_FaultFuelPump = {
    EN = "FUEL-PUMP"
}

SWWS_Localization.AEBS_FaultTransformer = {
    EN = "TRANSFORMER"
}

SWWS_Localization.AEBS_FaultTransmitter = {
    EN = "TRANSMITTER"
}

SWWS_Localization.AEBS_FaultReciever = {
    EN = "RECIEVER"
}

SWWS_Localization.AEBS_FaultGenerator = {
    EN = "GENERATOR"
}

SWWS_Localization.AEBS_FaultDieselUnit = {
    EN = "DIESEL-UNIT"
}

SWWS_Localization.AEBS_FaultCurrentRegulator = {
    EN = "CURRENT-REGULATOR"
}

SWWS_Localization.AEBS_FaultCapacitorArray = {
    EN = "CAPACITOR-ARRAY"
}

SWWS_Localization.AEBS_FaultRepairReplaceFuelLine = {
    EN = "REPLACE FUEL LINE"
}

SWWS_Localization.AEBS_FaultRepairControlBoardReplacement = {
    EN = "CONTROL BOARD REPLACEMENT"
}

SWWS_Localization.AEBS_FaultRepairRerouteShort = {
    EN = "REROUTE SHORT"
}

SWWS_Localization.AEBS_FaultRepairReplaceUnit = {
    EN = "REPLACE UNIT"
}

SWWS_Localization.AEBS_FaultRepairRepairUnit = {
    EN = "REPAIR UNIT"
}

SWWS_Localization.AEBS_FaultRepairRefuelGasoline = {
    EN = "REFUEL GASOLINE"
}

SWWS_Localization.AEBS_FaultRepairClearShort = {
    EN = "CLEAR SHORT"
}

SWWS_Localization.AEBS_StageStatusNominal_1 = {
    EN = "Condition nominal."
}

SWWS_Localization.AEBS_StageStatusNominal_2 = {
    EN = "No issues detected."
}

SWWS_Localization.AEBS_StageStatusNominal_3 = {
    EN = "Operation OK."
}

SWWS_Localization.AEBS_StageStatusNominal_4 = {
    EN = "Infrastructure stable."
}

SWWS_Localization.AEBS_StageStatusRepaired_1 = {
    EN = "Repairs successful."
}

SWWS_Localization.AEBS_StageStatusRepaired_2 = {
    EN = "Network functionality restored."
}

SWWS_Localization.AEBS_StageStatusRepaired_3 = {
    EN = "All systems restored."
}

SWWS_Localization.AEBS_StageStatusDetected_1 = {
    EN = "{Condition} detected."
}

SWWS_Localization.AEBS_StageStatusDetected_2 = {
    EN = "{Condition} {fuzz}"
}

SWWS_Localization.AEBS_StageStatusDetected_3 = {
    EN = "{fuzz} detected."
}

SWWS_Localization.AEBS_StageStatusDetected_4 = {
    EN = "{fuzz}"
}

SWWS_Localization.AEBS_StageStatusDiagnosing_1 = {
    EN = "Diagnosing {condition}."
}

SWWS_Localization.AEBS_StageStatusDiagnosing_2 = {
    EN = "Diagnosing {fuzz}"
}

SWWS_Localization.AEBS_StageStatusDiagnosing_3 = {
    EN = "{fuzz} {condition}."
}

SWWS_Localization.AEBS_StageStatusDiagnosing_4 = {
    EN = "Inconclusive diagnostic {fuzz} Restarting diagnostics."
}

SWWS_Localization.AEBS_StageStatusDiagnosing_5 = {
    EN = "Results corrupted {fuzz} Restarting diagnostics."
}

SWWS_Localization.AEBS_StageStatusDiagnosing_6 = {
    EN = "Non-fatal diagnostic error {fuzz} Restarting diagnostics."
}

SWWS_Localization.AEBS_StageStatusRebooting_1 = {
    EN = "{Condition} identified {fuzz} Initiating reboot."
}

SWWS_Localization.AEBS_StageStatusRebooting_2 = {
    EN = "{Condition} identified {fuzz} Rebooting."
}

SWWS_Localization.AEBS_StageStatusRebooting_3 = {
    EN = "{Condition} identified {fuzz} Rebooting {system}."
}

SWWS_Localization.AEBS_StageStatusRebooting_4 = {
    EN = "{Condition} identified in {system} {fuzz} Rebooting."
}

SWWS_Localization.AEBS_StageStatusRerouting_1 = {
    EN = "{Condition} identified {fuzz} Rerouting network activity to avoid {condition}."
}

SWWS_Localization.AEBS_StageStatusRerouting_2 = {
    EN = "Rerouting network traffic to avoid {condition}."
}

SWWS_Localization.AEBS_StageStatusRebootSuccess_1 = {
    EN = "{Condition} identified {fuzz} Reboot successful."
}

SWWS_Localization.AEBS_StageStatusRebootSuccess_2 = {
    EN = "{Condition} identified in {system} {fuzz} Rebooting resolved {condition}."
}

SWWS_Localization.AEBS_StageStatusReroutingSuccess_1 = {
    EN = "Successfully rerouted network traffic {fuzz} {Condition} excised from network."
}

SWWS_Localization.AEBS_StageStatusReroutingSuccess_2 = {
    EN = "Network traffic rerouted {fuzz} Resolved {condition} in {system}."
}

SWWS_Localization.AEBS_StageStatusRebootFailure_1 = {
    EN = "{Condition} identified {fuzz} Reboot failed."
}

SWWS_Localization.AEBS_StageStatusRebootFailure_2 = {
    EN = "{Condition} identified in {system} {fuzz} Rebooting failed to resolve {condition}."
}

SWWS_Localization.AEBS_StageStatusReroutingFailure_1 = {
    EN = "Failed to reroute network traffic {fuzz} {Condition} persists in network."
}

SWWS_Localization.AEBS_StageStatusReroutingFailure_2 = {
    EN = "Network traffic unable to reroute {fuzz} Failed to resolve {condition} in {system}."
}

SWWS_Localization.AEBS_StageStatusFatal_1 = {
    EN = "{fuzz} Fatal {condition}... {fuzz}"
}

SWWS_Localization.AEBS_StageStatusFatal_2 = {
    EN = "{fuzz} Fatal {fuzz}"
}

SWWS_Localization.AEBS_StageStatusFatal_3 = {
    EN = "Fatal {condition}..."
}

SWWS_Localization.AEBS_StageStatusFatal_4 = {
    EN = "Fatal {condition} {fuzz} Network in emergency stanby..."
}

SWWS_Localization.UI_RepairAutomatedBroadcast = {
    EN = "Repair automated broadcast"
}