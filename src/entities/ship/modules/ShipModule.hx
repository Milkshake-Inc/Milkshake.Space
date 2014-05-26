package entities.ship.modules;

import entities.PhysicsGameObject;
import entities.ship.modules.Anchor;
import haxe.exception.Exception;
import milkshake.core.Sprite;
import nape.constraint.WeldJoint;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Shape;

using Lambda;

class ShipModule extends PhysicsGameObject
{	
	public var anchors(default, null):Array<Anchor>;
	var sprite:Sprite;
	
	public function new(x:Float, y:Float, url:String, type:String, shape:Shape, id:String = "ship-module") 
	{
		super(id);
		
		anchors = [];

		sprite = new Sprite(url);
		sprite.alpha = 0.5;
		addNode(sprite);

		body = new Body(BodyType.DYNAMIC);
		body.setShapeMaterials(new nape.phys.Material(0, 0, 0, 1, 0));
		body.mass = 1;
		body.shapes.add(shape); 
	}
	
	private function initAnchors():Void
	{
		for (anchor in anchors) 
		{
			//offset position because anchors are added from the center
			anchor.x -= body.bounds.width / 2;
			anchor.y -= body.bounds.height / 2;
			addNode(anchor);
		}
	}
	
	public function connect(anchor1:Anchor, anchor2:Anchor) 
	{
		anchor1.connectTo(anchor2);
	}
	
	public function disconnect():Void
	{
		if (parent == null) return; //Not added to anything
		
		parent.removeNode(this);
		
		for (anchor in anchors) 
		{
			anchor.disconnect();
		}
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
		return body.position.x = value;
	}
	
	override public function set_y(value:Float):Float 
	{ 
		return body.position.y = value;
	}
	
	override public function update(deltaTime:Float):Void 
	{
		super.x = body.position.x;
		super.y = body.position.y;
		rotation = body.rotation;
		
		super.update(deltaTime);
	}
}