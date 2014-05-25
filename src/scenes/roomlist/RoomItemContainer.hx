package scenes.roomlist;
import milkshake.core.GameObject;
import milkshake.core.Sprite;
import milkshake.core.Text;
import net.packets.room.Room;
import pixi.Graphics;
import pixi.Rectangle;

/**
 * ...
 * @author Milkshake-Inc
 */
class RoomItemContainer extends GameObject
{
	public var selected(default, set):Bool;
	public var room:Room;
	public var playerText(default, null):Text;
	
	var graphics:Graphics;
	var height:Float;
	var width:Float;
	
	public function new(room:Room, width:Float, height:Float) 
	{
		super("RoomListItem" + room.name);
		this.room = room;
		this.height = height;
		this.width = width;
		
		graphics = new Graphics();
		graphics.hitArea = new Rectangle(0, 0, width, height );
		displayObject.addChild(graphics);
		
		selected = false;
		
		var nameText = new Text(room.name, "nameText");
		nameText.x = 20;
		nameText.y = 7;
		addNode(nameText);
		
		playerText = new Text(room.currentPlayers + " / " + room.maxPlayers, "playerText");
		playerText.x = 330;
		playerText.y = 7;
		addNode(playerText);
	}
	
	private function drawBackground():Void
	{
		var color:Int = selected ? 0xFF0000 : 0x58ACFA;
		
		graphics.clear();

		graphics.beginFill(color);
		graphics.drawRect(0, 0, width, height);
		graphics.endFill();
	}
	
	public function set_selected(value:Bool):Bool
	{
		return selected = value;
	}
	
	override public function update(deltaTime:Float):Void 
	{
		drawBackground();
		super.update(deltaTime);
	}
}