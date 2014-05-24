package entities.space;

class Universe extends GameObject
{
	public var space(default, null):Space;
	public var planets(default, null):Array<Planet>;

	public function new(space:Space):Void
	{
		this.space = space;

		planets = [];
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
		planets.push(planet);
	}
}