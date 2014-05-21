package entities.ship;

import milkshake.core.BodySprite;
import milkshake.core.Sprite;

/**
 * ...
 * @author Milkshake-Inc
 */
class Ship extends BodySprite
{
	public var modules(default, null): ModuleManager;

	public function new(url:String, id:String="ship") 
	{
		super(url, id);
		modules = new ModuleManager();
	}
	
}