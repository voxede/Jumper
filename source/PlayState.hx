package;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var player:Player;
	private var ground:Ground;
	private var spike:Spike;

	override public function create()
	{
		super.create();

		bgColor.greenFloat;

		player = new Player(32, 400);
		add(player);

		ground = new Ground(0, FlxG.height - 32);
		add(ground);

		spike = new Spike(200, 426);
		add(spike);

		FlxG.camera.zoom = 1;
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, ground);
		FlxG.overlap(player, spike, function f(obj1:FlxSprite, obj2:FlxSprite)
		{
			obj1.setPosition(32, 400);
		});
	}
}
