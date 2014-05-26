package entities.ship.modules;
import entities.ship.modules.ShipModule;
import milkshake.core.Entity;
import milkshake.core.GameObject;
import nape.constraint.WeldJoint;
import nape.geom.Vec2;
import pixi.Graphics;
import pixi.Pixi;

/**
 * ...
 * @author Milkshake-Inc
 */
class Anchor extends GameObject
{
	public var connectedAnchor:Anchor;
	
	public var weld:WeldJoint;
	
	public function new(x:Float, y:Float, id:String = "anchor", draw:Bool = true) 
	{
		super(id);
		this.x = x;
		this.y = y;
		
		if (draw)
		{
			var graphics = new Graphics();
			graphics.beginFill(0x00FF00);
			graphics.drawRect(-2.5, -2.5, 5, 5);
			displayObject.addChild(graphics);
		}
	}
	
	public function connectTo(anchor:Anchor):Void
	{
		connectedAnchor = anchor;
		var parent:ShipModule = cast parent;
		var anchorParent:ShipModule = cast anchor.parent;
		
		//Create weld
		weld = new WeldJoint(parent.body, anchorParent.body, position, anchor.position);
		weld.stiff = true;
		weld.space = parent.body.space;
	}
	
	public function disconnect():Void
	{
		weld.active = false;
		weld = null;
		connectedAnchor = null;
	}
}