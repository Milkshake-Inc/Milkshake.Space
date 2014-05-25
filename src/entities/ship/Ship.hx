package entities.ship;

import entities.PhysicsGameObject;
import entities.ship.modules.CoreModule;
import entities.ship.modules.HullModule;
import entities.ship.modules.ShipModule;
import entities.ship.modules.ThrustDirection;
import milkshake.core.GameObject;
import milkshake.core.Node;
import milkshake.core.Sprite;
import milkshake.IGameCore;
import milkshake.io.input.KeyboardCode;
import nape.constraint.WeldJoint;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.space.Space;

class Ship extends CoreModule
{	
	public var modules(default, null):Array<ShipModule>;

	private var core:IGameCore;
	
	public function new(core:IGameCore, id:String="ship") 
	{
		super();

		this.core = core;

		modules = [];
		
		initInput();
	}
	
	public function initInput()
	{
		core.input.addKeyDownHandler(KeyboardCode.W, function():Void
		{
			applyThrust(ThrustDirection.NORTH);
		});
		
		core.input.addKeyDownHandler(KeyboardCode.D, function():Void
		{
			
			applyThrust(ThrustDirection.EAST);
		});

		core.input.addKeyDownHandler(KeyboardCode.S, function():Void
		{
			applyThrust(ThrustDirection.SOUTH);	
		});
		
		core.input.addKeyDownHandler(KeyboardCode.A, function():Void
		{
			applyThrust(ThrustDirection.WEST);	
		});
	}
	
	public function addModule(module:ShipModule, adjacentModules:Array<ShipModule> = null)
	{
		modules.push(module);
		addNode(module);

		module.onConnected(adjacentModules);
	}

	public function removeModule(module:ShipModule)
	{
		modules.remove(module);
		removeNode(module);

		module.onDisconnected();
	}
	
	public function applyThrust(dir:ThrustDirection)
	{
		switch(dir)
		{
			case ThrustDirection.NORTH:
				body.applyImpulse(new Vec2(0, -5));
			case ThrustDirection.EAST:
				body.applyImpulse(new Vec2(5, 0));
			case ThrustDirection.SOUTH:
				body.applyImpulse(new Vec2(0, 5));
			case ThrustDirection.WEST:
				body.applyImpulse(new Vec2(-5, 0));
		}
	}
	/*
	
	override public function set_x(value:Float):Float 
	{ 
		body.position.x = value;
		x = value;

		return x;
	}
	
	override public function set_y(value:Float):Float 
	{ 
		body.position.y = value;
		y = value;

		return y;
	}*/

	override public function update(deltaTime:Float):Void 
	{
		x = body.position.x;
		y = body.position.y;		
		rotation = body.rotation;
		
		super.update(deltaTime);
	}
}