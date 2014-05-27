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
	var inputX:Float;
	var inputY:Float;
	var currentX:Int;
	var currentY:Int;
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
			if (scope.inputX != null && scope.inputY != null)
			{
				ship.x = scope.inputX;
				ship.y = scope.inputY;
				ship.stopVelocity();
			}
		}
		
		//open on creation
		open();
	}
	
	override public function update(deltaTime:Float):Void 
	{
		if (ship == null) return;
		
		if (scope.currentX != ship.x || scope.currentY != ship.y)
		{
			scope.currentX = Math.round(ship.x);
			scope.currentY = Math.round(ship.y);
			scope.apply();
		}
		
		super.update(deltaTime);
	}
	
	function get_ship():Ship
	{
		var game:GameScene = cast MilkshakeGame.instance.sceneManager.currentScene;
		return game.ship;
	}
}