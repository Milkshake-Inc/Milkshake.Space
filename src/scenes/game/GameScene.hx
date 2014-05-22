package scenes.game ;

import milkshake.core.Sprite;
import milkshake.core.TilingSprite;
import milkshake.game.scene.Scene;
import milkshake.game.scene.SceneManager;
import milkshake.IGameCore;

class GameScene extends Scene
{
	public function new(core:IGameCore, sceneManager:SceneManager)
	{
		super(core, "gameScene");
		
		
		addNode(new TilingSprite("assets/pattern.png", Globals.SCREEN_WIDTH, Globals.SCREEN_HEIGHT));
	}
}