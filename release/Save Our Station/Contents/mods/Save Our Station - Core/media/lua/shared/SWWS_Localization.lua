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
    EN = "Emergency Broadcast Integrity...",
    ES = "Estado de la Transmición de Emergencia"
}

SWWS_Localization.AEBS_ConditionNominal = {
    EN = "Condition nominal.",
    ES = "Condición nominal"
}

SWWS_Localization.AEBS_KnoxPowerGridStatusUnavailable = {
    EN = "Knox Power Grid: Status Unavailable...",
    ES = "Red electrica de Knox: Estado Inactivo"
}

SWWS_Localization.AEBS_ForcastOffline = {
    EN = "Forcast: Offline...",
    ES = "Pronóstico: Desconectado..."
}

SWWS_Localization.AEBS_AirTrafficRadarDisabled = {
    EN = "Air Traffic: Radar Disabled...",
    ES = "Tráfico Aereo: Radar Desactivado..."
}

SWWS_Localization.AEBS_EmergencyShutdownImminent = {
    EN = "Emergency shutdown imminent...",
    ES = "Apagado de emergencia inminente..."
}

SWWS_Localization.AEBS_EmergencyShutdownInHours = {
    EN = "Emergency shutdown in {hours} hours...",
    ES = "Apagado de emergencia en {hours} horas..."
}

SWWS_Localization.AEBS_EmergencyShutdownInDays = {
    EN = "Emergency shutdown in {days} days...",
    ES = "Apagado de emergencia en {days} dias..."
}

SWWS_Localization.AEBS_ConditionFault = {
    EN = "fault",
    ES = "error"
}

SWWS_Localization.AEBS_ConditionAnomaly = {
    EN = "anomaly",
    ES = "anomalía"
}

SWWS_Localization.AEBS_ConditionDefect = {
    EN = "defect",
    ES = "defecto"
}

SWWS_Localization.AEBS_ConditionFailure = {
    EN = "failure",
    ES = "fallo"
}

SWWS_Localization.AEBS_LocationRequiresUtilCrewDispatch = {
    EN = "{location} requires util-crew dispatch...",
    ES = "{location} requiriendo del personal encargado..."
}

SWWS_Localization.AEBS_DiagnosticCode = {
    EN = "Diagnostic Code [ {code} ] {system} - {description}",
    ES = "Código de Diagnóstico [ {code} ] {system} - {description}"
}

SWWS_Localization.AEBS_FaultFuelPump = {
    EN = "FUEL-PUMP",
    ES = "BOMBA DE COMBUSTIBLE"
}

SWWS_Localization.AEBS_FaultTransformer = {
    EN = "TRANSFORMER",
    ES = "TRANSFORMADOR"
}

SWWS_Localization.AEBS_FaultTransmitter = {
    EN = "TRANSMITTER",
    ES = "TRANSMISOR"
}

SWWS_Localization.AEBS_FaultReciever = {
    EN = "RECIEVER",
    ES = "RECEPTOR"
}

SWWS_Localization.AEBS_FaultGenerator = {
    EN = "GENERATOR",
    ES = "GENERADOR"
}

SWWS_Localization.AEBS_FaultDieselUnit = {
    EN = "DIESEL-UNIT",
    ES = "UNIDAD DE DIESEL"
}

SWWS_Localization.AEBS_FaultCurrentRegulator = {
    EN = "CURRENT-REGULATOR",
    ES = "REGULADOR DE CORRIENTE"
}

SWWS_Localization.AEBS_FaultCapacitorArray = {
    EN = "CAPACITOR-ARRAY",
    ES = "CAPACITADOR ARRAY"
}

SWWS_Localization.AEBS_FaultRepairReplaceFuelLine = {
    EN = "REPLACE FUEL LINE",
    ES = "REPONER LA LINEA DE COMBUSTIBLE"
}

SWWS_Localization.AEBS_FaultRepairControlBoardReplacement = {
    EN = "CONTROL BOARD REPLACEMENT",
    ES = "REEMPLAZAR PLACA DE CONTROL"
}

SWWS_Localization.AEBS_FaultRepairRerouteShort = {
    EN = "REROUTE SHORT",
    ES = "REDIRECCIÓN CORTO"
}

SWWS_Localization.AEBS_FaultRepairReplaceUnit = {
    EN = "REPLACE UNIT",
    ES = "REPONER UNIDAD"
}

SWWS_Localization.AEBS_FaultRepairRepairUnit = {
    EN = "REPAIR UNIT",
    ES = "REPARAR UNIDAD"
}

SWWS_Localization.AEBS_FaultRepairRefuelGasoline = {
    EN = "REFUEL GASOLINE",
    ES = "REABASTECER GASOLINA"
}

SWWS_Localization.AEBS_FaultRepairClearShort = {
    EN = "CLEAR SHORT",
    ES = "CLARO CORTO"
}

SWWS_Localization.AEBS_StageStatusNominal_1 = {
    EN = "Condition nominal.",
    ES = "Condición nominal."
}

SWWS_Localization.AEBS_StageStatusNominal_2 = {
    EN = "No issues detected.",
    ES = "No se detectan problemas."
}

SWWS_Localization.AEBS_StageStatusNominal_3 = {
    EN = "Operation OK.",
    ES = "Operación OK."
}

SWWS_Localization.AEBS_StageStatusNominal_4 = {
    EN = "Infrastructure stable.",
    ES = "Infraestructura estable."
}

SWWS_Localization.AEBS_StageStatusRepaired_1 = {
    EN = "Repairs successful.",
    ES = "Reparaciones exitosas."
}

SWWS_Localization.AEBS_StageStatusRepaired_2 = {
    EN = "Network functionality restored.",
    ES = "Funcionalidad de red restablecida."
}

SWWS_Localization.AEBS_StageStatusRepaired_3 = {
    EN = "All systems restored.",
    ES = "Todos los sistemas restablecidos."
}

SWWS_Localization.AEBS_StageStatusDetected_1 = {
    EN = "{Condition} detected.",
    ES = "{Condition} detectado."
}

SWWS_Localization.AEBS_StageStatusDetected_2 = {
    EN = "{Condition} {fuzz}",
    ES = "{Condition} {fuzz}"
}

SWWS_Localization.AEBS_StageStatusDetected_3 = {
    EN = "{fuzz} detected.",
    ES = "{fuzz} detectado."
}

SWWS_Localization.AEBS_StageStatusDetected_4 = {
    EN = "{fuzz}",
    ES = "{fuzz}"
}

SWWS_Localization.AEBS_StageStatusDiagnosing_1 = {
    EN = "Diagnosing {condition}.",
    ES = "Diagnósticando {condition}."
}

SWWS_Localization.AEBS_StageStatusDiagnosing_2 = {
    EN = "Diagnosing {fuzz}",
    ES = "Diagnósticando {fuzz}"
}

SWWS_Localization.AEBS_StageStatusDiagnosing_3 = {
    EN = "{fuzz} {condition}.",
    ES = "{fuzz} {condition}."
}

SWWS_Localization.AEBS_StageStatusDiagnosing_4 = {
    EN = "Inconclusive diagnostic {fuzz} Restarting diagnostics.",
    ES = "Diagnóstico inconcluso {fuzz} Reiniciando diagnósticos."
}

SWWS_Localization.AEBS_StageStatusDiagnosing_5 = {
    EN = "Results corrupted {fuzz} Restarting diagnostics.",
    ES = "Resultados corruptos {fuzz} Reinciando diagnósticos."
}

SWWS_Localization.AEBS_StageStatusDiagnosing_6 = {
    EN = "Non-fatal diagnostic error {fuzz} Restarting diagnostics.",
    ES = "Error no crítico del diagnóstico {fuzz} Reiniciando diagnósticos."
}

SWWS_Localization.AEBS_StageStatusRebooting_1 = {
    EN = "{Condition} identified {fuzz} Initiating reboot.",
    ES = "{Condition} identificado {fuzz} Comenzando reinicio."
}

SWWS_Localization.AEBS_StageStatusRebooting_2 = {
    EN = "{Condition} identified {fuzz} Rebooting.",
    ES = "{Condition} identificado {fuzz} Reiniciando."
}

SWWS_Localization.AEBS_StageStatusRebooting_3 = {
    EN = "{Condition} identified {fuzz} Rebooting {system}.",
    ES = "{Condition} identificado {fuzz} Reiniciando. {system}."
}

SWWS_Localization.AEBS_StageStatusRebooting_4 = {
    EN = "{Condition} identified in {system} {fuzz} Rebooting.",
    ES = "{Condition} identificado en {system} {fuzz} Reiniciando."
}

SWWS_Localization.AEBS_StageStatusRerouting_1 = {
    EN = "{Condition} identified {fuzz} Rerouting network activity to avoid {condition}.",
    ES = "{Condition} identificado {fuzz} Redirigiendo actividad de la red para evitar {condition}."
}

SWWS_Localization.AEBS_StageStatusRerouting_2 = {
    EN = "Rerouting network traffic to avoid {condition}.",
    ES = "Redirigiendo tráfico de red para evitar {condition}."
}

SWWS_Localization.AEBS_StageStatusRebootSuccess_1 = {
    EN = "{Condition} identified {fuzz} Reboot successful.",
    ES = "{Condition} identificado {fuzz} Reinicio completo."
}

SWWS_Localization.AEBS_StageStatusRebootSuccess_2 = {
    EN = "{Condition} identified in {system} {fuzz} Rebooting resolved {condition}.",
    ES = "{Condition} identificado en {system} {fuzz} Reinicio corregido {condition}."
}

SWWS_Localization.AEBS_StageStatusReroutingSuccess_1 = {
    EN = "Successfully rerouted network traffic {fuzz} {Condition} excised from network.",
    ES = "Redirección de trafico de red completo {fuzz} {Condition} salida de la red."
}

SWWS_Localization.AEBS_StageStatusReroutingSuccess_2 = {
    EN = "Network traffic rerouted {fuzz} Resolved {condition} in {system}.",
    ES = "Redirección del trafico de red {fuzz} Corregido {condition} en {system}."
}

SWWS_Localization.AEBS_StageStatusRebootFailure_1 = {
    EN = "{Condition} identified {fuzz} Reboot failed.",
    ES = "{Condition} identificado {fuzz} Reinicio fallo."
}

SWWS_Localization.AEBS_StageStatusRebootFailure_2 = {
    EN = "{Condition} identified in {system} {fuzz} Rebooting failed to resolve {condition}.",
    ES = "{Condition} identificado en {system} {fuzz} Reinicio fallo en resolver {condition}."
}

SWWS_Localization.AEBS_StageStatusReroutingFailure_1 = {
    EN = "Failed to reroute network traffic {fuzz} {Condition} persists in network.",
    ES = "Fallo en redireccionar el tráfico de red {fuzz} {Condition} permanece en la red."
}

SWWS_Localization.AEBS_StageStatusReroutingFailure_2 = {
    EN = "Network traffic unable to reroute {fuzz} Failed to resolve {condition} in {system}.",
    ES = "Tráfico de red indisponible para redireccionar {fuzz} fallo en resolver {condition} en {system}."
}

SWWS_Localization.AEBS_StageStatusFatal_1 = {
    EN = "{fuzz} Fatal {condition}... {fuzz}",
    ES = "{fuzz} {condition} fatal... {fuzz}"
}

SWWS_Localization.AEBS_StageStatusFatal_2 = {
    EN = "{fuzz} Fatal {fuzz}",
    ES = "{fuzz} Fatal {fuzz}"
}

SWWS_Localization.AEBS_StageStatusFatal_3 = {
    EN = "Fatal {condition}...",
    ES = "{Condition} fatal..."
}

SWWS_Localization.AEBS_StageStatusFatal_4 = {
    EN = "Fatal {condition} {fuzz} Network in emergency stanby...",
    ES = "{Condition} fatal {fuzz} Red de emergencia en espera..."
}

SWWS_Localization.UI_RepairAutomatedBroadcast = {
    EN = "Repair automated broadcast",
    ES = "Reparar transmisión automatica"
}