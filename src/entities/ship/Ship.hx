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