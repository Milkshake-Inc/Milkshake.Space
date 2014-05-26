package scenes.game ;

import entities.ship.Direction;
import entities.ship.modules.CoreModule;
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
import net.packets.Player;

class GameScene extends Scene
{
	public var universe:Universe;
	public var planet:Planet;
	
	public var remoteShips:Map<String, Ship>;

	public var ship:Ship;

	public function new(game:SpaceGame)
	{
		super(game.core, "gameScene");
		
		remoteShips = new Map<String, Ship>();
		var backgroundSize = 9999999;
		
		var bg;
		addNode(bg = new TilingSprite("scenes/game/stars.png", backgroundSize, backgroundSize));
		bg.scale = new Vec2(0.8, 0.8);
		bg.ignoreCameraZoom = true;

		addNode(universe = new Universe());
		
		universe.addNode(planet = new Planet(1500, 800, 1280 / 2, 2000));

		ship = new Ship("player");
		
		universe.addNode(ship);
		ship.x = 100;
		ship.y = 100;
		
		var topShipAnchor = ship.anchors[0];
		var newCore = new CoreModule("core2");
		var bottomNewCoreAnchor = newCore.anchors[1];
		ship.addShipModule(newCore, topShipAnchor, bottomNewCoreAnchor);
		
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
	
	public function updateRemotePlayer(data:Player) 
	{
/*		var remoteShip:Ship = remoteShips.get(data.id);
		
		if (remoteShip == null)
		{
			remoteShip = new Ship("remoteShip");			
			remoteShips.set(data.id, remoteShip);
			universe.addNode(remoteShip);
		}
		
		remoteShip.x = data.position.x;
		remoteShip.y = data.position.y;
		remoteShip.rotation = data.rotation;
		//remoteShip.body.velocity.x = data.velocity.x;
		//remoteShip.body.velocity.y = data.velocity.y;*/
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