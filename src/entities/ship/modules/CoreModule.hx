package entities.ship.modules;

import nape.shape.Polygon;
import nape.shape.Shape;

class CoreModule extends ShipModule
{
	public function new()
	{
		var shape:Shape = new Polygon(Polygon.box(32, 32));
		
		super(0, 0, "scenes/shipbuilder/parts/core.png", "core", shape);
	}
}