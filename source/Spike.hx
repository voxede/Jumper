package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Spike extends FlxSprite
{
	private static inline var OFFSET_X = 13;
	private static inline var OFFSET_Y = 12;

	public function new(x:Float, y:Float)
	{
		super(x + OFFSET_X, y + OFFSET_Y);
		loadGraphic("assets/images/spike.png");

		width = 6;
		height = 12;

		offset.set(OFFSET_X, OFFSET_Y);
	}
}
