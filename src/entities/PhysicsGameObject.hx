package entities;

import milkshake.core.Node;
import nape.phys.Body;
import entities.IBodyObject;
import milkshake.core.GameObject;

class PhysicsGameObject extends GameObject implements IBodyObject
{	
	public var body(default, null):Body;

	override public function addNode(node:Node):Void
	{
		if(Std.is(node, IBodyObject))
		{
			var bodyObject:IBodyObject = cast node;

			bodyObject.body.space = body.space;
		}

		super.addNode(node);
	}
}