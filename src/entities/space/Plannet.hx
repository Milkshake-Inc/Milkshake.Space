
package entities.planet;

import haxe.exception.Exception;
import milkshake.core.GameObject;
import milkshake.core.Node;
import nape.phys.Body;
import nape.space.Space;

interface IBodyObject
{
  	var body(default, null):Body;
}

class Plannet extends GameObject implements IBodyObject
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

class Universe extends GameObject
{
	public var space(default, null):Space;
	public var plannets(default, null):Array<Plannet>;

	public function new(space:Space):Void
	{
		this.space = space;

		plannets = [];
	}

	override public function addNode(node:Node):Void
	{
		if(Std.is(node, IBodyObject))
		{
			var bodyObject:IBodyObject = cast node;

			bodyObject.space = space;
		}

		super.addNode(node);
	}

	public function addPlanet(planet:Planet):Void
	{
		plannets.push(planet);
	}
}