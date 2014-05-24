
package entities.planet;

import haxe.exception.Exception;
import milkshake.core.GameObject;
import milkshake.core.Node;
import nape.phys.Body;
import nape.space.Space;

class Planet extends GameObject implements IBodyObjec
{
	public var body(default, null):Body;

	public function new(radius:Float, mass:Float)
	{
		super();

		body = new Body(BodyType.STATIC);

		body.shapes.add(new Circle(radius));
		body.space = space;
		body.mass = mass;
	}
}
