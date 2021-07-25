package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import haxe.Json;
import lime.utils.Assets;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.net.FileReference;

class Level
{
	var _file:FileReference;

	public function new() {}

	public function loadFromJson(jsonInput:String, ?folder:String)
	{
		var rawJson = Assets.getText('assets/data/' + jsonInput + '.json');

		return parseJSONStuff(rawJson);
	}

	public function parseJSONStuff(rawJson:String)
	{
		return Json.parse(rawJson).tiles;
	}

	public function writeJson(data:FlxTypedGroup<FlxSprite>)
	{
		var preparedData:Array<Array<Int>> = new Array<Array<Int>>();

		data.forEach(function _(tile:FlxSprite)
		{
			preparedData.push([0, cast(tile.x, Int), cast(tile.y, Int)]);
		});

		var jsonData = {
			"tiles": preparedData
		};

		var output:String = Json.stringify(jsonData);

		_file = new FileReference();
		_file.addEventListener(Event.COMPLETE, onSaveComplete);
		_file.addEventListener(Event.CANCEL, onSaveCancel);
		_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file.save(output.toString(), "writeTest.json"); // binary to string error.
	}

	function onSaveComplete(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.notice("Successfully saved LEVEL DATA.");
	}

	/**
	 * Called when the save file dialog is cancelled.
	 */
	function onSaveCancel(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
	}

	/**
	 * Called if there is an error while saving the gameplay recording.
	 */
	function onSaveError(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.error("Problem saving Level data");
	}
}
