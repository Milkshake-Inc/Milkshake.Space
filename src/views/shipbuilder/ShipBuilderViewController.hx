package views.shipbuilder;
import js.JQuery;
import milkshake.game.ui.view.AngularViewController;
import milkshake.game.ui.view.AngularViewScope;
import scenes.shipbuilder.ShipPart;

interface ShipBuilderScope extends AngularViewScope
{
	var openView:String->Void;
	var shipParts:Array<ShipPart>;
}

@:expose
class ShipBuilderViewController extends AngularViewController<ShipBuilderScope>
{
	public function new(scope:ShipBuilderScope, element:JQuery, attrs:Dynamic) 
	{
		super(scope, element, attrs);
		
		untyped element.draggable();
		
		scope.shipParts = new Array<ShipPart>();
		
		var part1 = new ShipPart("scenes/shipbuilder/parts/part1.png", "part1");
		scope.shipParts.push(part1);
		
		scope.apply();
		//open();
	}
	
}