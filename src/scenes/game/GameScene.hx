package scenes.game ;

import entities.ship.Direction;
import entities.ship.modules.HullModule;
import entities.ship.modules.WheelModule;
import entities.ship.Ship;
import entities.space.Planet;
import entities.space.Universe;
import milkshake.core.Sprite;
import milkshake.core.TilingSprite;
import milkshake.game.MilkshakeGame;
import milkshake.game.scene.Scene;
import milkshake.game.scene.SceneManager;
import milkshake.IGameCore;
import milkshake.io.input.KeyboardCode;
import nape.geom.Geom;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.space.Space;

class GameScene extends Scene
{
	public var universe:Universe;

	var ship:Ship;

	public function new(game:SpaceGame)
	{
		super(game.core, "gameScene");
		
		addNode(new TilingSprite("scenes/shared/pattern.png", Globals.SCREEN_WIDTH, Globals.SCREEN_HEIGHT));

		addNode(universe = new Universe());
		
		universe.addNode(new Planet(1500, 800, 1280 / 2, 2000));

		ship = new Ship(core, "player");
		ship.x = (1280 / 2);
		ship.y = 100;

		universe.addNode(ship);

		var frontWheel;
		var backWheel;

		ship.addModule(new HullModule(0, 32), [ ship ]);
		ship.addModule(new HullModule(0, 64), [ ship ]);
		ship.addModule(new HullModule(0, -32), [ ship ]);
		ship.addModule(new HullModule(0, -64), [ ship ]);
		//ship.addModule(frontWheel = new WheelModule(32, -64), [ ship ]);
		//ship.addModule(backWheel = new WheelModule(32, 64), [ ship ]);

		initInput();
	}

	public function initInput()
	{
		core.input.addKeyDownHandler(KeyboardCode.W, function():Void
		{
			applyThrust(Direction.NORTH);
		});
		
		core.input.addKeyDownHandler(KeyboardCode.D, function():Void
		{
			applyThrust(Direction.EAST);
		});

		core.input.addKeyDownHandler(KeyboardCode.S, function():Void
		{
			applyThrust(Direction.SOUTH);	
		});
		
		core.input.addKeyDownHandler(KeyboardCode.A, function():Void
		{
			applyThrust(Direction.WEST);	
		});
	}


	public function applyThrust(dir:Direction)
	{
		switch(dir)
		{
			case Direction.NORTH:
				ship.body.applyImpulse(new Vec2(0, -5));
			case Direction.EAST:
				ship.body.applyImpulse(new Vec2(5, 0));
			case Direction.SOUTH:
				ship.body.applyImpulse(new Vec2(0, 5));
			case Direction.WEST:
				ship.body.applyImpulse(new Vec2(-5, 0));
		}
	}

	override public function update(delta:Float):Void
	{
		super.update(delta);
	}

	public function getVecFromAngle(angle):Vec2
	{
		return new Vec2(Math.cos(angle), Math.sin(angle));
	}
}