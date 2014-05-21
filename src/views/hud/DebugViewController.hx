package views.hud;
import js.Browser;
import js.JQuery;
import milkshake.game.ui.view.AngularViewController;
import milkshake.game.ui.view.AngularViewScope;

interface DebugScope extends AngularViewScope
{
	var openView:String->Void;
	var alert:Void->Void;
}

@:expose
class DebugViewController extends AngularViewController<DebugScope>
{
	public function new(scope:DebugScope, element:JQuery, attrs:Dynamic) 
	{
		super(scope, element, attrs);
		
		scope.alert = function():Void
		{
			Browser.window.alert("Testing!");
		}
	}


}