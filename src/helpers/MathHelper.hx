package helpers;

class MathHelper
{
	public static function clamp(value:Float, min:Float, max:Float):Float 
	{
		return value > max ? max : value < min ? min : value;
	}	
}