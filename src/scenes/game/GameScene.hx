package scenes.game ;

import entities.ship.Ship;
import milkshake.core.Sprite;
import milkshake.core.TilingSprite;
import milkshake.game.MilkshakeGame;
import milkshake.game.scene.Scene;
import milkshake.game.scene.SceneManager;
import milkshake.IGameCore;
import milkshake.io.input.KeyboardCode;
import nape.geom.Geom;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.space.Space;

class GameScene extends Scene
{
	public var space:Space;
	public var physicsDebug:PixiDebug;

	var rocket:Body;
	var ship:Ship;
	
	var planets:Array<Body>;

	var samplePoint:Body;

	public function new(game:SpaceGame)
	{
		super(game.core, "gameScene");
		
		space = new Space();
		
		planets = [];

		addNode(new TilingSprite("scenes/shared/pattern.png", Globals.SCREEN_WIDTH, Globals.SCREEN_HEIGHT));
		addNode(physicsDebug = new PixiDebug());

		addPlanet(1100, 500, 1280 / 2);
		
		ship = new Ship(core, "player");
		ship.position.x = (1280 / 2);
		ship.position.y = 0;
		ship.space = space;
		addNode(ship);
		
/*		rocket = new Body(BodyType.DYNAMIC);
		rocket.shapes.add(new Polygon(Polygon.box(20, 30)));
		rocket.position.x = (1280 /2);
        rocket.position.y = 0;
		rocket.space = space;

		samplePoint = new Body();
        samplePoint.shapes.add(new Circle(0.001));

        core.input.addKeyDownHandler(KeyboardCode.D, function():Void
		{
			rocket.applyAngularImpulse(0.5);	
		});

		core.input.addKeyDownHandler(KeyboardCode.A, function():Void
		{
			rocket.applyAngularImpulse(-0.5);	
		});
		
		core.input.addKeyDownHandler(KeyboardCode.W, function():Void
		{
			rocket.applyImpulse(getVecFromAngle(rocket.rotation - 90).mul(0.5));	
		});*/
	}

	override public function update(delta:Float):Void
	{
		for(planet in planets)
		{
			planetaryGravity(planet, 1 / 24);
		}

		space.step(1 / 24);
		
		physicsDebug.drawSpace(space);

/*		for(a in 0 ... 100)
		{
			var pos = getTrajectoryPoint(a * 10);
			physicsDebug.pixiDebug.graphics.drawCircle(pos.x + rocket.position.x, pos.y + rocket.position.y, 10);
		}
		// Camera
		x = -(rocket.position.x * scaleX) + (1024 / 2);
		y = -(rocket.position.y * scaleY) + (720 / 2);		
		scaleX = 0.5;
		scaleY = 0.5;*/
		
		super.update(delta);
	}

	private function getTrajectoryPoint(n:Float):Vec2
	{
	  var t:Float = 1 / 24.0;
	  var stepVelocity:Float = t * rocket.velocity.length; // m/s
	  var stepGravity:Vec2 = getForce(planets[0], rocket).mul(t * t);

	  return rocket.position.add(new Vec2(n, n)).mul(stepVelocity + 0.5 * (n*n+n) * stepGravity.length);
	}

	private function addPlanet(radius:Float, mass:Float, x:Float):Void
	{
		var planet = new Body(BodyType.KINEMATIC);

		planet.shapes.add(new Circle(radius));
		planet.position.x = x;
		planet.position.y = 1200; 
		planet.space = space;
		planet.mass = mass;

		planets.push(planet);
	}

	function planetaryGravity(planet:Body, deltaTime:Float)
	{
		for (body in space.liveBodies)
		{
			body.applyImpulse(getForce(planet, body).muleq(deltaTime));
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

	public function getVecFromAngle(angle):Vec2
	{
		return new Vec2(Math.cos(angle), Math.sin(angle));
	}
}