package net.handlers;

import js.html.Point;
import js.node.SocketIo.SocketNamespace;
import milkshake.game.network.AbstractHandler;
import milkshake.game.scene.SceneManager;
import net.packets.game.GameUpdate;
import net.packets.game.SocketID;
import net.packets.game.StartGame;
import scenes.game.GameScene;

/**
 * ...
 * @author Milkshake-Inc
 */
class GameHandler extends AbstractHandler
{
	private var socketID:String;
	
	private var gameScene:GameScene;

	public function new(socket:SocketNamespace, sceneManager:SceneManager, roomHandler:RoomHandler ) 
	{
		super(socket);
		
		socket.on("socketID", function(data:SocketID):Void
		{
			socketID = data.socketID;
		});
		
		socket.on("startGame", function(data:Dynamic):Void
		{
			gameScene = cast sceneManager.scenes.get("game");
			sceneManager.changeScene("game");
		});
		
		socket.on("gameUpdate", function(data:GameUpdate):Void
		{
			for (player in data.players)
			{
				if (player.id != socketID)
				{
					gameScene.updateRemotePlayer(player);
				}
			}
			
			socket.emit("updatePosition", 
			{
				position: { x: gameScene.ship.x, y: gameScene.ship.y },
				velocity: { x: gameScene.ship.body.velocity.x, y: gameScene.ship.body.velocity.y },
				rotation: gameScene.ship.rotation
			});
		});
		
		socket.on("endGame", function(data:Dynamic):Void
		{
			roomHandler.leaveRoom();
		});
	}
	
}