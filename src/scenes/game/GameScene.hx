package scenes.game;

import entities.ship.Direction;
import entities.ship.modules.CoreModule;
import entities.ship.Ship;
import entities.space.Planet;
import entities.space.Universe;
import milkshake.core.TilingSprite;
import milkshake.game.camera.FollowCamera;
import milkshake.game.scene.Scene;
import milkshake.io.input.KeyboardCode;
import nape.geom.Vec2;
import net.packets.Player;

class GameScene extends Scene
{
	public var universe:Universe;
	public var planet:Planet;
	
	public var camera(default, null):FollowCamera;
	
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
		
		universe.addNode(planet = new Planet(100, 2500, 1280 / 2, 2000));

		ship = new Ship("player");
		
		var topShipAnchor = ship.anchors[0];
		var newCore = new CoreModule("core2");
		var bottomNewCoreAnchor = newCore.anchors[1];
		ship.addShipModule(newCore, topShipAnchor, bottomNewCoreAnchor);
		
		universe.addNode(ship);
		ship.x = 100;
		ship.y = 100;
		
		
		camera = cast cameraManager.addCamera("followCamera", new FollowCamera(ship));
		cameraManager.changeCamera("followCamera");
		camera.zoom = 0.5;
		
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
		var remoteShip:Ship = remoteShips.get(data.id);
		
		if (remoteShip == null)
		{
			remoteShip = new Ship("remoteShip");
			universe.addNode(remoteShip);
			
			var topShipAnchor = remoteShip.anchors[0];
			var newCore = new CoreModule("core-remote-2");
			var bottomNewCoreAnchor = newCore.anchors[1];
			remoteShip.addShipModule(newCore, topShipAnchor, bottomNewCoreAnchor);
		
			remoteShips.set(data.id, remoteShip);
		}
		
		remoteShip.x = data.position.x;
		remoteShip.y = data.position.y;
		remoteShip.rotation = data.rotation;
		//remoteShip.body.velocity.x = data.velocity.x;
		//remoteShip.body.velocity.y = data.velocity.y;
	}

	public function getVecFromAngle(angle):Vec2
	{
		return new Vec2(Math.cos(angle), Math.sin(angle));
	}
}