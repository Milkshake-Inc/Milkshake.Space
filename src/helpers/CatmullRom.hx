package helpers;

import nape.geom.Vec2;

class CatmullRom
{
	public static function CatmullRom(inCoordinates:Array<Vec2>, samples:Int):Array<Vec2>
	{
		var results:Array<Vec2> = new Array<Vec2>();
	 
		for(n in 1 ... inCoordinates.length - 2)
		{
			for(i in 1 ... samples)
			{
				results.push(PointOnCurve(inCoordinates[n - 1], inCoordinates[n], inCoordinates[n + 1], inCoordinates[n + 2], (1 / samples) * i ));
			}
		}
	 
		results.push(inCoordinates[inCoordinates.length - 2]);
	 
		return results;
	}

	public static function PointOnCurve(p0:Vec2, p1:Vec2, p2:Vec2, p3:Vec2, t:Float): Vec2
	{
		var result:Vec2 = new Vec2();
		
		
		var t0:Float = ((-t + 2) * t - 1) * t * 0.5;
		var t1:Float = (((3 * t - 5) * t) * t + 2) * 0.5;
		var t2:Float = ((-3 * t + 4) * t + 1) * t * 0.5;
		var t3:Float = ((t - 1) * t * t) * 0.5;
		
		result.x = p0.x * t0 + p1.x * t1 + p2.x * t2 + p3.x * t3;
		result.y = p0.y * t0 + p1.y * t1 + p2.y * t2 + p3.y * t3;
		
		return result;
	}
	
}