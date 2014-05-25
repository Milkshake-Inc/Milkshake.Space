package ;

import milkshake.core.GameObject;
import nape.constraint.LineJoint;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.space.Space;
import nape.util.Debug;
import nape.phys.Body;
import pixi.Graphics;

class PixiDebug extends GameObject
{
	public var pixiDebug:PixiDebugRenderer;
	
	public function new()
	{
		super();
		
		pixiDebug = new PixiDebugRenderer();
		displayObject.addChild(pixiDebug.graphics);
	}
	
	public function drawSpace(space:Space)
	{
		pixiDebug.draw(space);
	}
	
	
}

class PixiDebugRenderer extends Debug
{
	public var graphics:Graphics;

	public function new()
	{
		graphics = new Graphics();
	}
	
	public function clear()
	{
		graphics.clear();
	}
	
	public function drawBody(body:Body)
	{
		for (shape in body.shapes)
		{
			if (Std.is(shape, Polygon))
			{
				graphics.beginFill(0x99FF33, 0.5);					
				//graphics.lineStyle(3, 0x558F1D);
				
				var polygon:Polygon = cast shape;
				
				for (index in 0 ... polygon.worldVerts.length)
				{
					var position = polygon.worldVerts.at(index);
					
					if (index == 0) graphics.moveTo(position.x, position.y);
					else graphics.lineTo(position.x, position.y);						
				}
			}
			
			if (Std.is(shape, Circle))
			{
				var circle:Circle = cast shape;
				graphics.beginFill(0x00FF00, 0.5);
				graphics.lineStyle(1, 0x00FF00);
				
				graphics.drawCircle(circle.worldCOM.x, circle.worldCOM.y, circle.radius);
				
				graphics.moveTo(circle.worldCOM.x, circle.worldCOM.y);
				graphics.lineTo(body.position.x + circle.radius * Math.cos(body.rotation), body.position.y +circle.radius * Math.sin(body.rotation));
			}
		}
	}	
	
	public function draw(space:Space)
	{
		
		graphics.clear();		
	
		for (body in space.bodies)
		{
			for (constraint in body.constraints)
			{
				if (Std.is(constraint, LineJoint))
				{
					var lineJoint:LineJoint = cast constraint;
					
					graphics.moveTo(lineJoint.body1.worldCOM.x + lineJoint.anchor1.x, lineJoint.body1.worldCOM.y + lineJoint.anchor1.y);
					graphics.lineTo(lineJoint.body2.worldCOM.x + lineJoint.anchor2.x, lineJoint.body2.worldCOM.y + lineJoint.anchor2.y);					
				}
			}			
			
			drawBody(body);
		}
		
	}
	
}