package ;

/**
 * ...
 * @author Milkshake-Inc
 */
class Globals
{
	public static var SERVER_ADDRESS(default, never):String = "127.0.0.1:3000";
	
	//Dimensions
	public static var SCREEN_WIDTH(default, never):Int = 1280;
	public static var SCREEN_HEIGHT(default, never):Int = 720;
	
	public static var HALF_SCREEN_HEIGHT(default, never):Float = SCREEN_HEIGHT * 0.5;
	public static var HALF_SCREEN_WIDTH(default, never):Float = SCREEN_WIDTH * 0.5;
}