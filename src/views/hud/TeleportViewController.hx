package views.hud;
import entities.ship.Ship;
import js.Browser;
import js.JQuery;
import milkshake.game.camera.Camera;
import milkshake.game.MilkshakeGame;
import milkshake.game.ui.view.AngularViewController;
import milkshake.game.ui.view.AngularViewScope;
import scenes.game.GameScene;

interface TeleportScope extends AngularViewScope
{
	var teleport:Void->Void;
	var x:Float;
	var y:Float;
}

@:expose
class TeleportViewController extends AngularViewController<TeleportScope>
{
	var ship(get, null):Ship;
	
	public function new(scope:TeleportScope, element:JQuery, attrs:Dynamic) 
	{
		super(scope, element, attrs);
		
		scope.teleport = function():Void
		{
			if (scope.x != null && scope.y != null)
			{
				ship.x = scope.x;
				ship.y = scope.y;
			}
		}
		
		//open on creation
		open();
	}
	
	function get_ship():Ship
	{
		var game:GameScene = cast MilkshakeGame.instance.sceneManager.currentScene;
		return game.ship;
	}
}