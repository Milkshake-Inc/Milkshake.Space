package ;

import milkshake.game.MilkshakeGame;
import net.handlers.GameHandler;
import net.handlers.RoomHandler;
import milkshake.io.net.MilkshakeNetworkManager;
import scenes.game.GameScene;
import scenes.lobby.LobbyScene;
import scenes.roomlist.RoomListScene;
import scenes.startmenu.StartMenuScene;

class SpaceGame extends MilkshakeGame
{
	 var roomHandler:RoomHandler;
	var gameHandler:GameHandler;
	public var networkManager:MilkshakeNetworkManager;
	
	var game:SpaceGame;
	
	static function main()
	{
		new SpaceGame();
	}

	public function new()
	{
		super();
		untyped window.world = game = this;
		boot(Globals.SCREEN_HEIGHT, Globals.SCREEN_WIDTH);
	}
	
	override public function boot(width:Float, height:Float):Void 
	{
		super.boot(width, height);
		
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
		
		sceneManager.addScene("startMenu", new StartMenuScene(core, sceneManager));
		sceneManager.addScene("roomListScene", new RoomListScene(core, roomHandler));
		sceneManager.addScene("lobbyScene", new LobbyScene(core, roomHandler));
		sceneManager.addScene("game", new GameScene(core, sceneManager));
		
		sceneManager.changeScene("startMenu");
		
		//viewManager.addView("debug", new DebugViewController(null, null, null));
	}


	override public function update(delta:Float):Void
	{
		super.update(delta);
	}
}