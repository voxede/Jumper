package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Ground extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		makeGraphic(FlxG.width, 32, FlxColor.GRAY);
		immovable = true;
	}
}
