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
	
	public var backgroundSize:Int;

	public var ship:Ship;

	public function new(game:SpaceGame)
	{
		super(game.core, "gameScene");
		
		untyped backgroundSize = 9999999;
		
		var bg;
		addNode(bg = new TilingSprite("scenes/game/stars.png", backgroundSize, backgroundSize));
		bg.scale = new Vec2(0.8, 0.8);
		bg.ignoreCameraZoom = true;

		addNode(universe = new Universe());
		
		var planet;
		universe.addNode(planet = new Planet(1500, 800, 1280 / 2, 2000));

		ship = new Ship(core, "player");
		ship.x = (1280 / 2);
		ship.y = 100;

		universe.addNode(ship);

		var frontWheel;
		var backWheel;

		//T
		ship.addModule(new HullModule(-1, 0), [ ship ]);
		ship.addModule(new HullModule(1, 0), [ ship ]);
		ship.addModule(new HullModule(0, -1), [ ship ]);
		ship.addModule(new HullModule(0, -1), [ ship ]);
		
		ship.addModule(new HullModule(-2, -1), [ ship ]);
		ship.addModule(new HullModule(2, -1), [ ship ]);
		
		var penisLength = 15;
		
		for (i in 2...penisLength)
		{
			
			ship.addModule(new HullModule(-3, -i), [ ship ]);
		}
		
		for (i in 2...penisLength)
		{
			
			ship.addModule(new HullModule(3, -i), [ ship ]);
		}
		
		ship.addModule(new HullModule(-4, -penisLength), [ ship ]);
		ship.addModule(new HullModule(-5, -penisLength), [ ship ]);
		ship.addModule(new HullModule(4, -penisLength), [ ship ]);
		ship.addModule(new HullModule(5, -penisLength), [ ship ]);
		
		ship.addModule(new HullModule(-6, -penisLength -1), [ ship ]);
		ship.addModule(new HullModule(-6, -penisLength -2), [ ship ]);
		ship.addModule(new HullModule( -6, -penisLength -3), [ ship ]);
		
		ship.addModule(new HullModule(6, -penisLength -1), [ ship ]);
		ship.addModule(new HullModule(6, -penisLength -2), [ ship ]);
		ship.addModule(new HullModule(6, -penisLength -3), [ ship ]);
		
		ship.addModule(new HullModule(-5, -penisLength -4), [ ship ]);
		ship.addModule(new HullModule(-4, -penisLength -4), [ ship ]);
		ship.addModule(new HullModule(-3, -penisLength -4), [ ship ]);
		
		ship.addModule(new HullModule(5, -penisLength -4), [ ship ]);
		ship.addModule(new HullModule(4, -penisLength -4), [ ship ]);
		ship.addModule(new HullModule(3, -penisLength -4), [ ship ]);
		
		ship.addModule(new HullModule(-2, -penisLength -3), [ ship ]);
		ship.addModule(new HullModule(2, -penisLength -3), [ ship ]);
		
		ship.addModule(new HullModule(-1, -penisLength -2), [ ship ]);
		ship.addModule(new HullModule(0, -penisLength -2), [ ship ]);
		ship.addModule(new HullModule(1, -penisLength -2), [ ship ]);
		
		cameraManager.currentCamera.target = ship;
		cameraManager.currentCamera.zoom = 0.5;
		
		var bg2;
		addNode(bg2 = new TilingSprite("scenes/game/nebula.png", backgroundSize, backgroundSize));
		bg2.scale = new Vec2(2, 2);
		bg2.alpha = 0.3;
		bg2.ignoreCameraZoom = true;
		
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