package scenes.roomlist;
import milkshake.core.GameObject;
import milkshake.core.Text;
import net.packets.room.Room;
import net.packets.room.RoomList;
import pixi.InteractionData;
import scenes.roomlist.RoomItemContainer;

using Lambda;

/**
 * ...
 * @author Milkshake-Inc
 */
class RoomListGameObject extends GameObject
{
	private var ROOM_SPRITE_WIDTH(default, never):Float = 400;
	private var ROOM_SPRITE_HEIGHT(default, never):Float = 50;
	private var ROOM_SPRITE_GAP(default, never):Float = 50;
	
	private var roomList:Array<Room>;
	
	public var currentRoomSelected(default, null):RoomItemContainer;
	
	private var text:Text;
	
	public function new() 
	{
		super("RoomListGameObject");
	}
	
	public function setRooms(data:RoomList) 
	{
		roomList = data.rooms;
		updateList();
	}
	
	private function updateList() 
	{
		for (room in roomList)
		{
			var node:RoomItemContainer = getNodeById("RoomListItem" + room.name);
			
			if (node != null) node.playerText.setText(room.currentPlayers + " / " + room.maxPlayers);
			else
			{
				var roomSprite = new RoomItemContainer(room, ROOM_SPRITE_WIDTH, ROOM_SPRITE_HEIGHT);
				var index = roomList.indexOf(room);
				addNode(roomSprite);
				roomSprite.y = (ROOM_SPRITE_HEIGHT + ROOM_SPRITE_GAP) * index;
				roomSprite.displayObject.setInteractive(true);
				roomSprite.displayObject.click = function(data:InteractionData):Void
				{
					if(currentRoomSelected != null) currentRoomSelected.selected = false;
					currentRoomSelected = roomSprite;
					currentRoomSelected.selected = true;
				};
			}
		}
	}
}