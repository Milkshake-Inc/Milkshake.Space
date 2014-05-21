package scenes.roomlist;
import milkshake.core.GameObject;
import milkshake.core.Sprite;

/**
 * ...
 * @author Milkshake-Inc
 */
class LoadingGameObject extends GameObject
{
	
	private var loadingImage:Sprite;

	public function new() 
	{
		super("loadingContainer");
		loadingImage = new Sprite("/scenes/serverListScene/loading.png");
		loadingImage.x = Globals.HALF_SCREEN_WIDTH;
		loadingImage.y = Globals.HALF_SCREEN_HEIGHT;
		addNode(loadingImage);
	}
	
	override public function update(deltaTime:Float):Void 
	{
		loadingImage.rotation += 0.01;
		super.update(deltaTime);
	}
	
}