
package views.hud;
import js.Browser;
import js.JQuery;
import milkshake.game.ui.view.AngularViewController;
import milkshake.game.ui.view.AngularViewScope;

interface GameScope extends AngularViewScope
{
	var testing:Void->Void;
}

@:expose
class GameViewController extends AngularViewController<GameScope>
{
	public function new(scope:DebugScope, element:JQuery, attrs:Dynamic) 
	{
		super(scope, element, attrs);
		
		scope.testing = function():Void
		{
			Browser.window.alert("Testing!");
		}
		
		//open on creation
		open();
	}

	override public function open(data:Dynamic):Void
	{
		super.open(data);
	}
}