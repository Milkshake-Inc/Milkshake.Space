package entities.ship.modules;

import entities.PhysicsGameObject;
import milkshake.core.Sprite;
import nape.constraint.WeldJoint;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Shape;

using Lambda;

class ShipModule extends PhysicsGameObject
{
	public var connectedModules:Map<ShipModule, WeldJoint>;
	
	public var offset:Vec2;
	
	public function new(x:Float, y:Float, url:String, type:String, shape:Shape) 
	{
		super();

		var sprite = new Sprite(url);
		//sprite.alpha = 0.5;
		sprite.x = x;
		sprite.y = y;

		addNode(sprite);

		body = new Body(BodyType.DYNAMIC);
		body.setShapeMaterials(new nape.phys.Material(0, 0, 0, 1, 0));
		body.mass = 1;
		body.shapes.add(shape);

		connectedModules = new Map<ShipModule, WeldJoint>();
		
		offset = new Vec2(x, y);
	}
	
	public function addConnectedModule(module:ShipModule)
	{
		var weld = new WeldJoint(body, module.body, new Vec2(0,0), offset, 0);
		weld.stiff = true;
		weld.space = body.space;
		connectedModules.set(module, weld);
		module.connectedModules.set(this, weld);
	}
	
	public function removeConnectedModule(module:ShipModule)
	{
		var weld = connectedModules.get(module);
		connectedModules.remove(module);
		module.connectedModules.remove(this);
		body.space.constraints.remove(weld);
	}
	
	public function onConnected(connectedModules:Array<ShipModule>):Void 
	{
		if (connectedModules != null)
		{
			for (connectedModule in connectedModules)
			{
				addConnectedModule(connectedModule);
			}
		}
	}
	
	public function onDisconnected():Void 
	{
		for (connectedModule in connectedModules.keys())
		{
			removeConnectedModule(connectedModule);
		}
	}
}