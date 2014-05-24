package entities.space;

class Universe extends GameObject
{
	public var space(default, null):Space;
	public var plannets(default, null):Array<Plannet>;

	public function new(space:Space):Void
	{
		this.space = space;

		plannets = [];
	}

	override public function addNode(node:Node):Void
	{
		if(Std.is(node, IBodyObject))
		{
			var bodyObject:IBodyObject = cast node;

			bodyObject.space = space;
		}

		super.addNode(node);
	}

	public function addPlanet(planet:Planet):Void
	{
		plannets.push(planet);
	}
}