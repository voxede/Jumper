package;

import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

class Level
{
	public static function loadFromJson(jsonInput:String, ?folder:String)
	{
		var rawJson = Assets.getText('assets/data/' + jsonInput + '.json');

		return parseJSONStuff(rawJson);
	}

	public static function parseJSONStuff(rawJson:String)
	{
		return Json.parse(rawJson).tiles;
	}

	public static function writeJson(data)
	{
		for (i in 0...data.length) {}
		trace(Json.stringify(data));
	}
}
