package entities.ship.modules;

/**
 * @author Milkshake-Inc
 */

typedef ModuleData =
{
	id:Int,
	type:ModuleType,
	//Module Connection that connects this module to the ship
	moduleConnectedTo:ModuleConnectionData,
	//Module Connections that connects other modules to this module
	moduleConnectedBy:Array<ModuleConnectionData>
}