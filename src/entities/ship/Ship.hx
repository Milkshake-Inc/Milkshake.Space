package entities.ship;

import entities.PhysicsGameObject;
import entities.ship.modules.Anchor;
import entities.ship.modules.CoreModule;
import entities.ship.modules.HullModule;
import entities.ship.modules.ShipModule;
import entities.space.Universe;
import milkshake.core.GameObject;
import milkshake.core.Node;
import milkshake.core.Sprite;
import milkshake.IGameCore;
import milkshake.io.input.KeyboardCode;
import nape.constraint.WeldJoint;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.space.Space;

class Ship extends CoreModule
{	
	public var shipModules:Array<ShipModule>;
	
	public function new(id:String="ship") 
	{
		super(id);
		shipModules = [];
		
		onAddedToNode.bind(function(node:Node):Void
		{
			for (shipModule in shipModules) node.addNode(shipModule);
		});
	}
	
	public function addShipModule(shipModule:ShipModule, shipAnchor:Anchor, shipModuleAnchor:Anchor)
	{
		shipModules.push(shipModule);
		
		if(parent != null) parent.addNode(shipModule);
		
		shipModule.connect(shipAnchor, shipModuleAnchor);
	}
	
	override public function stopVelocity():Void
	{
		for (shipModule in shipModules) shipModule.stopVelocity();
		super.stopVelocity();
	}
	
	override public function set_x(value:Float):Float 
	{
		for (shipModule in shipModules) shipModule.x = value + shipModule.distanceFromModule(this).x;
		
		return super.set_x(value);
	}
	
	override public function set_y(value:Float):Float 
	{ 
		for (shipModule in shipModules) shipModule.y = value + shipModule.distanceFromModule(this).y;
		
		return super.set_y(value);
	}
	
}