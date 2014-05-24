package entities.ship.modules;
import nape.shape.Polygon;
import nape.shape.Shape;

/**
 * ...
 * @author Milkshake-Inc
 */
class HullModule extends ShipModule
{
	public function new(x:Float, y:Float)
	{
		var shape:Shape = new Polygon(Polygon.box(32, 32));
		
		super(x, y, "scenes/shipbuilder/parts/hull.png", "hull", shape);
	}
	
}