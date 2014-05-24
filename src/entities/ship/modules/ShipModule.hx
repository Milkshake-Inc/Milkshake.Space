package entities.ship.modules;
import milkshake.core.Sprite;
import nape.constraint.WeldJoint;
import nape.geom.Vec2;
import nape.phys.Body;
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
		
		body = new Body();
		body.shapes.add(shape);
		
		adjacentModules = new Map<ShipModule, WeldJoint>();
		
		this.x = x;
		this.y = y;
		
		offset = new Vec2(x, y);
	}
	
	public function addAdjacentModule(module:ShipModule)
	{
		var weld = new WeldJoint(body, module.body, new Vec2(0,0), new Vec2(0,0), 0);
		weld.stiff = true;
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
				if (!adjacentModules.has(adjacentModule))
				{
					addAdjacentModule(adjacentModule);
				}
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
		
	override public function set_x(value:Float):Float 
	{ 
		return position.x = body.position.x = sprite.position.x = value; 
	}
	
	override public function set_y(value:Float):Float 
	{ 
		return position.y = body.position.y = sprite.position.y = value; 
	}
	
	override public function update(deltaTime:Float):Void 
	{
		x = body.position.x;
		y = body.position.y;
		
		super.update(deltaTime);
	}
	
}