package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		makeGraphic(32, 32, FlxColor.GREEN);
		acceleration.y = 500;
	}

	override public function update(elapsed:Float)
	{
		var jump:Bool = FlxG.keys.justPressed.UP || FlxG.mouse.justPressed;
		var left:Bool = FlxG.keys.pressed.LEFT;
		var right:Bool = FlxG.keys.pressed.RIGHT;

		if (isTouching(FlxObject.FLOOR) && jump)
		{
			velocity.y = -250;
		}

		if (left && right)
		{
			left = right = false;
		}

		if (left)
		{
			velocity.x = -100;
		}
		else if (right)
		{
			velocity.x = 100;
		}
		else
		{
			velocity.x = 0;
		}

		super.update(elapsed);
	}
}
