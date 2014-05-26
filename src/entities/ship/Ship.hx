package entities.ship;

import entities.PhysicsGameObject;
import entities.ship.modules.Anchor;
import entities.ship.modules.CoreModule;
import entities.ship.modules.HullModule;
import entities.ship.modules.ShipModule;
import entities.space.Universe;
import milkshake.core.GameObject;
import milkshake.core.Node;
import milkshake.core.Sprite;
import milkshake.IGameCore;
import milkshake.io.input.KeyboardCode;
import nape.constraint.WeldJoint;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.space.Space;

class Ship extends CoreModule
{	
	public var shipModules:Array<ShipModule>;
	
	public function new(id:String="ship") 
	{
		super(id);
		shipModules = [];
	}
	
	public function addShipModule(shipModule:ShipModule, shipAnchor:Anchor, shipModuleAnchor:Anchor)
	{
		shipModules.push(shipModule);
		addNode(shipModule);
		
		shipModule.connect(shipAnchor, shipModuleAnchor);
	}
	
}