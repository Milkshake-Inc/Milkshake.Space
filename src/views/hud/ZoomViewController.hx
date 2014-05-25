package views.hud;
import js.Browser;
import js.JQuery;
import milkshake.game.camera.Camera;
import milkshake.game.MilkshakeGame;
import milkshake.game.ui.view.AngularViewController;
import milkshake.game.ui.view.AngularViewScope;

interface ZoomScope extends AngularViewScope
{
	var openView:String->Void;
	var zoomIn:Void->Void;
	var zoomOut:Void->Void;
}

@:expose
class ZoomViewController extends AngularViewController<ZoomScope>
{
	var camera(get, null):Camera;
	
	public function new(scope:ZoomScope, element:JQuery, attrs:Dynamic) 
	{
		super(scope, element, attrs);
		
		scope.zoomIn = function():Void
		{
			camera.zoom *= 1.2;
		}
		
		scope.zoomOut = function():Void
		{
			camera.zoom *= 0.8;
		}
		
		//open on creation
		open();
	}
	
	function get_camera():Camera
	{
		return MilkshakeGame.instance.sceneManager.currentScene.cameraManager.currentCamera;
	}
}