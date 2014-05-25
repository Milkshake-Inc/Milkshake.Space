package scenes.game ;

import entities.ship.Ship;
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

	var ship:Ship;

	public function new(game:SpaceGame)
	{
		super(game.core, "gameScene");
		
		addNode(new TilingSprite("scenes/shared/pattern.png", Globals.SCREEN_WIDTH, Globals.SCREEN_HEIGHT));
		
		addNode(universe = new Universe());
		var planet;
		universe.addNode(planet = new Planet(200, 2000, 1280 / 2, 720 / 2));

		ship = new Ship(core, "player");
		ship.position.x = (1280 / 2);
		ship.position.y = 0;
		ship.space = universe.space;
		addNode(ship);
		
		cameraManager.currentCamera.target = planet;
	}

	override public function update(delta:Float):Void
	{
		super.update(delta);
	}

	public function getVecFromAngle(angle):Vec2
	{
		return new Vec2(Math.cos(angle), Math.sin(angle));
	}
}