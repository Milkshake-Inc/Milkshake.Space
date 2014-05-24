package scenes.shipbuilder;
import milkshake.core.TilingSprite;
import milkshake.game.MilkshakeGame;
import milkshake.game.scene.Scene;
import milkshake.game.scene.SceneManager;
import milkshake.IGameCore;
import views.shipbuilder.ShipBuilderViewController;

/**
 * ...
 * @author Milkshake-Inc
 */
class ShipBuilderScene extends Scene
{
	var view:ShipBuilderViewController;
	var game:SpaceGame;
	
	public function new(game:SpaceGame)
	{
		super(game.core, "shipBuilderScene");
		this.game = game;
		
		addNode(new TilingSprite("scenes/shared/pattern.png", Globals.SCREEN_WIDTH, Globals.SCREEN_HEIGHT));
	}
	
	override function onLoaded():Void 
	{
		view = cast game.viewManager.getViewById("ship_builder");
		trace(view);
	}
}