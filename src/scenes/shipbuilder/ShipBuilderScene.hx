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
	public function new(core:IGameCore, sceneManager:SceneManager)
	{
		super(core, "shipBuilderScene");
		
		addNode(new TilingSprite("scenes/shared/pattern.png", Globals.SCREEN_WIDTH, Globals.SCREEN_HEIGHT));
	}
}