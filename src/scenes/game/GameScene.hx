package scenes.game ;

import entities.space.Planet;
import entities.space.Universe;
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
	public var universe:Universe;

	var rocket:Body;

	public function new(game:SpaceGame)
	{
		super(game.core, "gameScene");
		
		addNode(new TilingSprite("scenes/shared/pattern.png", Globals.SCREEN_WIDTH, Globals.SCREEN_HEIGHT));
		
		addNode(universe = new Universe());
			


		universe.addNode(new Planet(200, 10, 1280 / 2, 720 / 2));

		
		/*
		rocket = new Body(BodyType.DYNAMIC);
		rocket.shapes.add(new Polygon(Polygon.box(20, 30)));
		rocket.position.x = (1280 /2);
        rocket.position.y = 0;
		rocket.space = space;

		

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
		/*
		// Camera
		x = -(rocket.position.x * scaleX) + (1024 / 2);
		y = -(rocket.position.y * scaleY) + (720 / 2);		
		scaleX = 0.5;
		scaleY = 0.5;
		*/
		super.update(delta);
	}

	public function getVecFromAngle(angle):Vec2
	{
		return new Vec2(Math.cos(angle), Math.sin(angle));
	}
}