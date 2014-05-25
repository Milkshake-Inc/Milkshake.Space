
package entities.space;

import haxe.exception.Exception;
import milkshake.core.GameObject;
import milkshake.core.Node;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.space.Space;

class Planet extends GameObject implements IBodyObject
{
	public var body(default, null):Body;

	public function new(radius:Float, mass:Float, ?x:Float = 0, ?y:Float = 0)
	{
		super();
		
		this.x = x;
		this.y = y;

		body = new Body(BodyType.STATIC);
		body.shapes.add(new Circle(radius));
		body.mass = mass;
		body.position.x = x;
		body.position.y = y;
	}
}
