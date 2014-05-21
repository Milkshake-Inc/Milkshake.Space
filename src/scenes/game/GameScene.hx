package scenes.game ;

import milkshake.game.scene.Scene;
import milkshake.game.scene.SceneManager;
import milkshake.IGameCore;


class GameScene extends Scene
{
	public function new(core:IGameCore, sceneManager:SceneManager)
	{
		super(core, "gameScene");		
	}
}