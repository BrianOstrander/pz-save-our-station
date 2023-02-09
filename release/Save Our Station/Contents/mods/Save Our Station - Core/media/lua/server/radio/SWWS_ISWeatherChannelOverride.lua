require "radio/SWWS_Core";
require 'radio/ISWeatherChannel';

local weatherChannelOriginal_FillBroadcast = WeatherChannel.FillBroadcast;

function WeatherChannel.FillBroadcast(_gametime, _bc, ...)
    local corePayload = SWWS_Core.FillBroadcastWarning();
	local c = corePayload.color;
	
	if not corePayload.isShutdown then
		if not corePayload.overridePower and not corePayload.overrideForcast and not corePayload.overrideChoppah then
			weatherChannelOriginal_FillBroadcast(_gametime, _bc, ...);
		else
			_bc:AddRadioLine(RadioLine.new(getRadioText("AEBS_Intro"), c.r, c.g, c.b));
			WeatherChannel.AddFuzz(c, _bc);
			
			if corePayload.overridePower then
				_bc:AddRadioLine(RadioLine.new(corePayload.overridePower, c.r, c.g, c.b));
			else
				WeatherChannel.AddPowerNotice(c, _bc);
			end
			
			WeatherChannel.GetRandomString(c, _bc, 100);
			WeatherChannel.AddFuzz(c, _bc);
			
			if corePayload.overrideForcast then
				_bc:AddRadioLine(RadioLine.new(corePayload.overrideForcast, c.r, c.g, c.b));
			else
				WeatherChannel.AddForecasting(c, _bc, _gametime:getHour());
			end
			
			WeatherChannel.AddFuzz(c, _bc);
			WeatherChannel.GetRandomString(c, _bc, 100);
			
			local gt = getGameTime();
			if corePayload.overrideChoppah then
				_bc:AddRadioLine(RadioLine.new(corePayload.overrideChoppah, c.r, c.g, c.b));
			elseif gt:getNightsSurvived() == gt:getHelicopterDay1() then
				WeatherChannel.AddFuzz(c, _bc);
				_bc:AddRadioLine(RadioLine.new(getRadioText('AEBS_Choppah'), c.r, c.g, c.b));
			end
			
			WeatherChannel.AddFuzz(c, _bc);
		end
	end
	
	if corePayload.diagnostics then
		if not corePayload.isShutdown then
			_bc:AddRadioLine(RadioLine.new(getRadioText('AEBS_Integrity'), c.r, c.g, c.b));
			WeatherChannel.AddFuzz(c, _bc);
		end
		
		for _, diagnostic in ipairs(corePayload.diagnostics) do
			_bc:AddRadioLine(RadioLine.new(diagnostic, c.r, c.g, c.b));
			WeatherChannel.AddFuzz(c, _bc);
		end
	end
end