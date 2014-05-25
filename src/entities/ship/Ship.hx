package entities.ship;

import entities.ship.modules.CoreModule;
import entities.ship.modules.HullModule;
import entities.ship.modules.ShipModule;
import entities.ship.modules.ThrustDirection;
import milkshake.core.GameObject;
import milkshake.core.Sprite;
import milkshake.IGameCore;
import milkshake.io.input.KeyboardCode;
import nape.constraint.WeldJoint;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.space.Space;

/**
 * ...
 * @author Milkshake-Inc
 */
class Ship extends GameObject
{
	public var space(default, set):Space;
	
	public var coreModule:CoreModule;
	
	var modules:Array<ShipModule>;
	var core:IGameCore;
	
	public function new(core:IGameCore, id:String="ship") 
	{
		super(id);
		this.core = core;
		modules = [];
		initInput();
		
		coreModule = new CoreModule();
		var hullModule = new HullModule(0, 32);
		
		addModule(coreModule);
		addModule(hullModule, [coreModule]);
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
		module.body.space = space;
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
				coreModule.body.applyImpulse(new Vec2(0, -5));
			case ThrustDirection.EAST:
				coreModule.body.applyImpulse(new Vec2(5, 0));
			case ThrustDirection.SOUTH:
				coreModule.body.applyImpulse(new Vec2(0, 5));
			case ThrustDirection.WEST:
				coreModule.body.applyImpulse(new Vec2(-5, 0));
		}
	}
	
	public function set_space(value:Space):Space 
	{ 
		space = value;
		for (module in modules)
		{
			module.body.space = space;
			for (connectedModule in module.connectedModules.keys())
			{
				module.connectedModules.get(connectedModule).space = space;
			}
		}
		
		return space;
	}
	
	override public function set_x(value:Float):Float 
	{ 
		x = coreModule.x = value + coreModule.offset.x;
		for (module in modules)
		{
			module.x = x + module.offset.x;
		}
		return x;
	}
	
	override public function set_y(value:Float):Float 
	{ 
		y = coreModule.y = value + coreModule.offset.y;
		for (module in modules)
		{
			module.y = y + module.offset.y;
		}
		return y;
	}
	
	override public function update(deltaTime:Float):Void 
	{
		x = coreModule.x;
		y = coreModule.y;
		
		super.update(deltaTime);
	}
}