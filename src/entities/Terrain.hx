package entities;

import helpers.CatmullRom;
import milkshake.core.GameObject;
import nape.geom.GeomPoly;
import nape.geom.GeomPolyList;
import nape.geom.Vec2;
import nape.geom.Vec2List;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.shape.Shape;
import nape.space.Space;

using Lambda;
class Terrain extends GameObject
{
	public var body(default, null):Body;
	
	public function new(space:Space) 
	{
		super("terrain");
		
		
		
		body = new Body(BodyType.STATIC, new Vec2(1000, 160));
		var list:Vec2List = new Vec2List();
		
		var array:Array<Vec2> = [];
		
		
		for ( i in 0...100 )
		{
			var maxHeight = 750;
			var random = Math.random() * maxHeight;
			array.push(new Vec2(i * 750, random));
		}
		
		var smoothArray = CatmullRom.CatmullRom(array, 10);
		
		var newArray:Array<Vec2> = [];		
		newArray.push(new Vec2(-10000, 0));
		newArray.push(new Vec2(0, 0));
		
		for (a in smoothArray)
		{
			newArray.push(a);
		}
		//newArray.concat(smoothArray);	
		
		newArray.push(new Vec2(100 * 750, 6000));
		
		for ( i in 1...99 )
		{
			newArray.push(new Vec2((100 * 750) - i * 2000, 6000));
		}
		
		newArray.push(new Vec2(0, 6000));
		
		
		//array.push(new Vec2(-100, 100));
		var geomList:GeomPolyList = decompose(new GeomPoly(newArray));
		
		for (geom in geomList)
		{
			body.shapes.add(new Polygon(geom));
			trace("add");
		}
		//new Polygon(array));
		
		body.space = space;
	}
	
	private function decompose(poly:GeomPoly):GeomPolyList
	{
		var polys:GeomPolyList = new GeomPolyList();

		if (poly.isSimple())
		{
			polys.add(poly);
		}
		else
		{
			poly.simplify(2).convexDecomposition(polys);
		}

		var convexPolys:GeomPolyList = new GeomPolyList();
		polys.foreach(function (p:GeomPoly):Void
		{
			p.convexDecomposition(true, convexPolys);
		});

		return convexPolys;
	}
	
}