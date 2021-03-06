package ;

import milkshake.game.MilkshakeGame;
import net.handlers.GameHandler;
import net.handlers.RoomHandler;
import milkshake.io.net.MilkshakeNetworkManager;
import scenes.game.GameScene;
import scenes.lobby.LobbyScene;
import scenes.roomlist.RoomListScene;
import scenes.shipbuilder.ShipBuilderScene;
import scenes.startmenu.StartMenuScene;
import views.hud.DebugViewController;
import views.hud.ZoomViewController;
import views.hud.TeleportViewController;

class SpaceGame extends MilkshakeGame
{
	public var roomHandler:RoomHandler;
	public var gameHandler:GameHandler;
	public var networkManager:MilkshakeNetworkManager;
	
	var game:SpaceGame;
	
	static function main()
	{
		new SpaceGame();
	}

	public function new()
	{
		super();
		untyped window.game = game = this;
		boot(Globals.SCREEN_WIDTH, Globals.SCREEN_HEIGHT, 0x2c3e50);
	}
	
	override public function boot(width:Float, height:Float, color:Int):Void 
	{
		super.boot(width, height, color);
		
		networkManager = new MilkshakeNetworkManager(sceneManager);
		
		networkManager.socket.on("connect", function(data:Dynamic):Void
		{
			roomHandler.getRoomList();
			
			networkManager.socket.emit('getSocketID');
		});
		
		networkManager.socket.on("disconnect", function(data:Dynamic):Void
		{
			sceneManager.changeScene("roomListScene");
		});
		
		roomHandler = new RoomHandler(networkManager.socket, sceneManager);
		gameHandler = new GameHandler(networkManager.socket, sceneManager, roomHandler);
		
		sceneManager.addScene("startMenu", new StartMenuScene(this));
		sceneManager.addScene("roomListScene", new RoomListScene(this));
		sceneManager.addScene("lobbyScene", new LobbyScene(this));
		sceneManager.addScene("game", new GameScene(this));
		sceneManager.addScene("shipbuilder", new ShipBuilderScene(this));
		
		sceneManager.changeScene("game");
	}

	override public function update(delta:Float):Void
	{
		super.update(delta);
	}
}