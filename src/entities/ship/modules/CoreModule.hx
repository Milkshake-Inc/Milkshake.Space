package entities.ship.modules;

import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.shape.Shape;

class CoreModule extends ShipModule
{
	public function new(id:String = "core-module")
	{
		var shape:Shape = new Polygon(Polygon.box(32, 32));
		
		super(0, 0, "scenes/shipbuilder/parts/core.png", "core", shape, id);
		
		initAnchors();
	}
	
	override function initAnchors():Void 
	{
		anchors.push(new Anchor(16, 0, "top-middle-anchor"));
		anchors.push(new Anchor(16, 32, "bottom-middle-anchor"));
		anchors.push(new Anchor(0, 16, "left-middle-anchor"));
		anchors.push(new Anchor(32, 16, "left-middle-anchor"));
		super.initAnchors();
	}
}