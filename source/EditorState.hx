package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.shapes.FlxShapeGrid;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class EditorState extends FlxState
{
	private static inline var TILE_SIZE = 32;

	private var spikes:FlxTypedGroup<Spike>;
	private var grid:FlxShapeGrid;

	override public function create()
	{
		super.create();

		// Make a grid for reference
		grid = new FlxShapeGrid(0, 0, 32, 32, 32, 32, {thickness: 1, color: FlxColor.GRAY}, FlxColor.WHITE);
		add(grid);

		spikes = new FlxTypedGroup<Spike>();
		add(spikes);

		loadLevel('testLevel');
		Level.writeJson(spikes);

		FlxG.camera.zoom = 1;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed)
		{
			addSpike();
		}
		if (FlxG.mouse.justPressedRight)
		{
			deleteSpike();
		}

		// trace(pixelsToTiles(FlxG.mouse.x, FlxG.mouse.y));
	}

	private function addSpike()
	{
		var coordsOnTile:FlxPoint = pixelsToTiles(FlxG.mouse.x, FlxG.mouse.y);
		var coordsOnPixels:FlxPoint = tilesToPixels(cast(coordsOnTile.x, Int), cast(coordsOnTile.y, Int));

		spikes.add(new Spike(coordsOnPixels.x, coordsOnPixels.y));
	}

	private function deleteSpike()
	{
		spikes.forEach(function _(spike:Spike)
		{
			if (FlxG.mouse.overlaps(spike, FlxG.camera))
			{
				spike.kill();
			}
		});
	}

	// Transform pixels coords to tile coords
	public function pixelsToTiles(x:Float, y:Float)
	{
		return new FlxPoint(cast(x / TILE_SIZE, Int), cast(y / TILE_SIZE, Int));
	}

	// Transform tiles coords to pixels coords
	public function tilesToPixels(x:Int, y:Int)
	{
		return new FlxPoint(x * TILE_SIZE, y * TILE_SIZE);
	}

	public function loadLevel(levelName:String)
	{
		var data:Array<Array<Int>> = Level.loadFromJson(levelName);

		for (i in 0...data.length)
		{
			var x = data[i][1];
			var y = data[i][2];

			spikes.add(new Spike(x, y));
		}
	}
}
