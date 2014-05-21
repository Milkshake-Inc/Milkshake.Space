package entities.ship;

/**
 * ...
 * @author Milkshake-Inc
 */
class ModuleManager 
{
	private var coreX: Int;
	private var coreY: Int;
	private var map: Hash<ShipModule>;
	public var list(default, null): Array<ShipModule>;
	
	public function new() 
	{
		map = new Hash<ShipModule>();
		list = new Array<ShipModule>();
		coreX = coreY = 0;
	}
	
	public function get(x: Int, y: Int): ShipModule
	{
		return map.get(x + "," + y);
	}
	
	private function set(x: Int, y: Int, v: ShipModule): Void
	{
		map.set(x + "," + y, v);
	}
	
	public function add(module:ShipModule, x: Int, y: Int):ShipModule
	{
		module.moduleX = x;
		module.moduleY = y;
		list.push(module);
		set(x, y, module);
		if (Std.is(module, CoreModule))
		{
			coreX = x;
			coreY = y;
		}
		return module;
	}
	
	public function occupied(x: Int, y: Int): Bool
	{
		return map.exists(x + "," + y);
	}
	
	public function getCore(): ShipModule
	{
		return get(coreX, coreY);
	}
	
	public function remove(module:ShipModule, detachNeighbours:Bool = false):Void
	{
		set(module.moduleX, module.moduleY, null);
		list.remove(module);
	}
	
	public function each(func: ShipModule -> Void): Void
	{
		for (m in list)
		{
			func(m);
		}
	}j