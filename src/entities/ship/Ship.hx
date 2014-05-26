package entities.ship;

import entities.PhysicsGameObject;
import entities.ship.modules.CoreModule;
import entities.ship.modules.HullModule;
import entities.ship.modules.ShipModule;
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
	
	override public function get_x():Float 
	{
		return body.position.x;
	}
	
	override public function get_y():Float 
	{
		return body.position.y;
	}
	
	override public function set_x(value:Float):Float 
	{ 
		body.position.x = value;
		
		for (module in modules)
		{
			module.body.position.x = value;
		}
		
		return value;
	}
	
	override public function set_y(value:Float):Float 
	{ 
		body.position.y = value;
		
		for (module in modules)
		{
			module.body.position.y = value;
		}
		
		return value;
	}

	override public function update(deltaTime:Float):Void 
	{
		super.x = body.position.x;
		super.y = body.position.y;		
		rotation = body.rotation;
		
		super.update(deltaTime);
	}
}