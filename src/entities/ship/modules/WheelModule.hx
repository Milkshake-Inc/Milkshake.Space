package entities.ship.modules;

import nape.constraint.PivotJoint;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.shape.Shape;



class WheelModule extends ShipModule
{
	public var weld:PivotJoint;
	public var frontWheel:Body;

	public function new(x:Float, y:Float)
	{
		var shape:Shape = new Polygon(Polygon.box(32 / 2, 32 / 2));

		//var shape = new nape.shape.Circle(32 / 2);
		
		super(x, y, "scenes/shipbuilder/parts/hull.png", "hull", shape, "wheel-module");

		frontWheel = new Body(BodyType.DYNAMIC);
		frontWheel.position.x = 10;
		frontWheel.shapes.add(new Circle(32/2));

		weld = new PivotJoint(body, frontWheel, new Vec2(), new Vec2());
	}
}