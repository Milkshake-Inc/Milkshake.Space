package scenes.lobby;
import milkshake.core.Text;
import milkshake.game.scene.Scene;
import milkshake.game.scene.SceneManager;
import milkshake.IGameCore;
import network.MilkshakeNetworkManager;
import network.packets.room.Room;
import pixi.InteractionData;
import milkshake.game.ui.component.Button;

class LobbyScene extends Scene
{	
	private var lobbyText:Text;	
	private var currentRoom:Room;

	public function new(core:IGameCore, networkManager:MilkshakeNetworkManager) 
	{
		super(core, "LobbyScene");
		
		lobbyText = new Text("");
		lobbyText.x = 300;
		lobbyText.y = 300;
		addNode(lobbyText);
		
		var quitRoomButton:Button = new Button(250, 50, "Quit Room", 0xA9F5A9, 0x58FA58);
		quitRoomButton.x = 375;
		quitRoomButton.y = 600;
		quitRoomButton.displayObject.click = function(data:InteractionData):Void
		{
			networkManager.roomHandler.leaveRoom();
		}
		addNode(quitRoomButton);
	}
	
	public function setRoom(room:Room) 
	{
		this.currentRoom = room;
		var waitingForPlayers:Int = room.maxPlayers - room.currentPlayers;
		lobbyText.setText("You are currently in " + room.name + "!\nWaiting on " + waitingForPlayers + " more players to start...");
	}
	
	override public function update(deltaTime:Float):Void 
	{
		super.update(deltaTime);
	}
	
}