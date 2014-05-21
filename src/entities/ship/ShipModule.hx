package entities.ship;

import nape.shape.Shape;
import nape.phys.Material;
import nape.geom.Vec2;
import nme.display.DisplayObject;
import nme.events.MouseEvent;
import nme.geom.Matrix;
import com.tutsplus.boilerplate.BodySprite;

/**
 * ...
 * @author Nemanja Stojanovic
 */

class ShipModule 
{
	public var moduleX(default, default): Int;
	public var moduleY(default, default): Int;
	public var shape(getShape, null): Shape;
	public var display(getDisplay, null): DisplayObject;
	public var orientation(default, default): Int;
	public var parent(default, default): BodySprite;
	public var attachedToShip(default, default): Bool = false;
	public var timestamp(default, default): Int = 0;
	
	public static var material: Material = new Material(0.2, 0.57, 0.74, 1.0, 0.001);
	public static inline var unitWidth = 32;
	public static inline var unitHeight = 32;
	public static inline var unitWidthHalf = 16;
	public static inline var unitHeightHalf = 16;
	
	public static inline var NORTH = 270;
	public static inline var EAST = 0;
	public static inline var SOUTH = 90;
	public static inline var WEST = 180;
	
	public function new() 
	{
		orientation = EAST;
	}
	
	private function createShape(): Shape
	{
		throw "should be overriden";
		return null;
	}
	
	private function createDisplay(): DisplayObject 
	{
		throw "should be overriden";
		return null;
	}
	
	public function destroyShape(): Void
	{
		this.shape = null;
	}
	
	/**
	 * Resets the display transformation matrix to what
	 * it originally was
	 */
	public function resetDisplayTransform(): Void
	{
		if (display != null)
		{
			var m: Matrix = display.transform.matrix;
			m.identity();
			m.translate(-unitWidthHalf, -unitHeightHalf);
			m.rotate(orientation * 0.0174532925);
			m.translate(unitWidthHalf, unitHeightHalf);
			display.transform.matrix = m;
		}
	}
	
	/**
	 * Returns an existing display object or creates a new one
	 * @return
	 */
	private function getDisplay(): DisplayObject
	{
		if (this.display == null)
		{
			this.display = createDisplay();
			if (orientation != 0)
			{
				resetDisplayTransform();
			}
		}
		return this.display;
	}
	
	/**
	 * Returns an existing shape or creates a new one
	 * @return
	 */
	private function getShape(): Shape
	{
		if (shape == null)
		{
			shape = createShape();
			if (orientation != 0)
			{
				var t = new Vec2( -unitWidthHalf, -unitHeightHalf);
				shape.translate(t);
				shape.rotate(orientation * 0.0174532925);
				t.x *= -1;
				t.y *= -1;
				shape.translate(t);
			}
		}
		return shape;
	}
	
	/**
	 * Returns the world position of this module
	 * @return
	 */
	public function getWorldPos(): Vec2
	{
		if (parent != null)
			return parent.body.localToWorld(new Vec2(parent.shapeAnchorX + moduleX * unitWidth + unitWidthHalf, parent.shapeAnchorY + moduleY * unitHeight + unitHeightHalf));
		else
			throw "There is no parent, can't get world position";
	}
	
	/**
	 * Returns true if the module can connect in the (rx, ry) direction.
	 * @param	rx (-1, 0, 1)
	 * @param	ry (-1, 0, 1)
	 * @return
	 */
	public function connectsTo(rx: Int, ry: Int): Bool
	{
		return true;
	}
	
	public function attached(): Void
	{
		attachedToShip = true;
	}
	
	public function detached(): Void
	{
		attachedToShip = false;
	}
	
	public function update(): Void
	{
		
	}
