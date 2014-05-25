package entities.ship.modules;
import milkshake.core.Sprite;
import nape.constraint.WeldJoint;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Shape;
using Lambda;

/**
 * ...
 * @author Milkshake-Inc
 */
class ShipModule extends Sprite
{
	public var body:Body;
	
	public var adjacentModules:Map<ShipModule, WeldJoint>;
	
	public var offset:Vec2;
	
	public function new(x:Float, y:Float, url:String, type:String, shape:Shape) 
	{
		super(url, type);
		
		body = new Body(BodyType.DYNAMIC);
		body.setShapeMaterials(new nape.phys.Material(0, 0, 0, 1, 0));
		body.mass = 1;
		body.shapes.add(shape);
		
		adjacentModules = new Map<ShipModule, WeldJoint>();
		
		this.x = x;
		this.y = y;
		
		offset = new Vec2(x, y);
	}
	
	public function addAdjacentModule(module:ShipModule)
	{
		var weld = new WeldJoint(body, module.body, new Vec2(0,0), offset, 0);
		weld.stiff = true;
		weld.space = body.space;
		adjacentModules.set(module, weld);
		module.adjacentModules.set(this, weld);
	}
	
	public function removeAdjacentModule(module:ShipModule)
	{
		var weld = adjacentModules.get(module);
		adjacentModules.remove(module);
		module.adjacentModules.remove(this);
		body.space.constraints.remove(weld);
	}
	
	public function onConnected(adjacentModules:Array<ShipModule>):Void 
	{
		if (adjacentModules != null)
		{
			for (adjacentModule in adjacentModules)
			{
				addAdjacentModule(adjacentModule);
			}
		}
	}
	
	public function onDisconnected():Void 
	{
		for (adjacentModule in adjacentModules.keys())
		{
			removeAdjacentModule(adjacentModule);
		}
	}
	
	override public function update(deltaTime:Float):Void 
	{
		x = body.position.x;
		y = body.position.y;
		
		rotation = body.rotation;
		
		super.update(deltaTime);
	}
	
}