package entities.space;

import entities.IBodyObject;
import entities.space.Planet;
import milkshake.core.GameObject;
import milkshake.core.Node;
import nape.geom.Geom;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.space.Space;

class Universe extends GameObject
{
	public var space(default, null):Space;
	public var planets(default, null):Array<Planet>;

	public var physicsDebug:PixiDebug;

	public var samplePoint(default, null):Body;

	public function new():Void
	{
		super();

		this.space = new Space();
		
		samplePoint = new Body();
        samplePoint.shapes.add(new Circle(0.001));

		planets = [];

		addNode(physicsDebug = new PixiDebug());
	}

	override public function addNode(node:Node):Void
	{
		if(Std.is(node, IBodyObject))
		{
			var bodyObject:IBodyObject = cast node;
			bodyObject.body.space = space;
		}

		if(Std.is(node, Planet))
		{
			planets.push(cast node);
		}

		super.addNode(node);
	}

	override public function update(detlaTime:Float):Void
	{
		for(planet in planets) calculatePlanetGravity(planet, 1 / 24);

		space.step(1 / 24);

		physicsDebug.drawSpace(space);

		super.update(detlaTime);
	}

	function calculatePlanetGravity(planet:Planet, deltaTime:Float)
	{
		for (body in space.liveBodies)
		{
			body.applyImpulse(getForce(planet.body, body).muleq(deltaTime));
        }
    }

    function getForce(planet:Body, rocket:Body):Vec2
	{
		var closestA = Vec2.get();
    	var closestB = Vec2.get();

        samplePoint.position.set(rocket.position);
        var distance = Geom.distanceBody(planet, samplePoint, closestA, closestB);

        // Gravitational force.
        var force = closestA.sub(rocket.position, true);

		force.length = 1 * ((rocket.mass * planet.mass) / distance);

		closestA.dispose();
        closestB.dispose();

		return force;
	}
}