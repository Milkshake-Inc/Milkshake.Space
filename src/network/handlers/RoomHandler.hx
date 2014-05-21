package network.handlers;
import js.node.SocketIo.SocketNamespace;
import milkshake.game.network.AbstractHandler;
import milkshake.game.scene.SceneManager;
import network.packets.Player;
import network.packets.room.CreateRoom;
import network.packets.room.JoinRoom;
import network.packets.room.Room;
import network.packets.room.RoomList;
import scenes.lobby.LobbyScene;

/**
 * ...
 * @author Milkshake-Inc
 */
class RoomHandler extends AbstractHandler
{
	private var sceneManager:SceneManager;
	private var currentRoom:Room;
	public var onRoomsLoadedCallback:RoomList -> Void;

	public function new(socket:SocketNamespace, sceneManager:SceneManager) 
	{
		super(socket);
		this.sceneManager = sceneManager;
		
		socket.on("joinedRoom", function(data : Room):Void
		{
			currentRoom = data;
			updateLobbyRoom();
			sceneManager.changeScene("lobbyScene");
		});
		
		socket.on("leftRoom", function( data:Dynamic ):Void
		{
			currentRoom = null;
			sceneManager.changeScene("startMenu");
		});
		
		socket.on("playerJoinedRoom", function(data:Player):Void
		{
			currentRoom.currentPlayers += 1;
			updateLobbyRoom();
		});
		
		socket.on("playerLeftRoom", function(data:Player):Void
		{
			currentRoom.currentPlayers -= 1;
			updateLobbyRoom();
		});
		
		socket.on("refreshRoomList", function(data:Dynamic):Void
		{
			getRoomList();
		});
	}
	
	public function getRoomList():Void
	{
		if (onRoomsLoadedCallback != null)
		{
			socket.on('roomList', onRoomsLoadedCallback);
			socket.emit("getRooms");
		}
	}
	
	public function createRoom(_name:String, _password:String, _maxPlayers:Int = 10):Void
	{
		var cr:CreateRoom = { name: _name, password: _password, maxPlayers: _maxPlayers };
		socket.emit("joinRoom", cr);
	}
	
	public function joinRoom(_name:String, _password:String = ""):Void
	{
		var jr:JoinRoom = { name: _name, password: _password };
		socket.emit("joinRoom", jr);
	}
	
	public function leaveRoom():Void
	{
		socket.emit("leaveRoom", currentRoom.name);
	}
	
	private function updateLobbyRoom():Void
	{
		var lobbyScene:LobbyScene = cast sceneManager.scenes.get("lobbyScene");
		lobbyScene.setRoom(currentRoom);
	}
	
}