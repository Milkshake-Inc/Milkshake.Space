package entities;

import milkshake.core.Sprite;
import milkshake.game.scene.Scene;
import nape.constraint.DistanceJoint;
import nape.constraint.LineJoint;
import nape.constraint.PivotJoint;
import nape.dynamics.InteractionGroup;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.space.Space;

class Sheep extends Sprite
{
	var body:Body;
	
	public function new(space:Space, int:InteractionGroup)
	{
		super("sheeps/sheep0001.png");
		
		body = new Body(BodyType.DYNAMIC);
		body.shapes.add(new Circle(16));
		body.position.x = 50;
		body.mass = 4;
		body.space = space;
		body.group = int;
		
		scaleX = scaleY = 0.25;
	}
	
	override public function update(deltaTime:Float):Void 
	{
		super.update(deltaTime);
		
		x = body.position.x;
		y = body.position.y;
		rotation = body.rotation;
	}
}

class Tractor extends Sprite
{
	public var body(default, null):Body;
	public var backWheel(default, null):Body;
	public var frontWheel(default, null):Body;
	
	public var frontWheelSprite:Sprite;
	public var backWheelSprite:Sprite;
	public var tractorTop:Sprite;
	
	public var trailorSprite:Sprite;
	
	public var frontTrailorWheelSprite:Sprite;
	public var backTrailorWheelSprite:Sprite;
	
	var trailorBackWheel: Body;
	var trailorFrontWheel: Body;
	
	var space:Space;
	var ignoreGroup:InteractionGroup;
	var isRemote:Bool;
	public var trailor:Body;
	
	public function new(space:Space, tractorIgnoreGroup:InteractionGroup, isRemote:Bool = false)
	{
		super("pimpmobile/tractor_back.png");
		this.isRemote = isRemote;
		this.space = space;
		
		var ignoreGroup = new InteractionGroup(true);
		ignoreGroup.group = tractorIgnoreGroup;
		
		body = new Body(BodyType.DYNAMIC, new Vec2(600, 200));
		body.shapes.add(new Polygon(Polygon.rect(-60, 0, 120, 70)));
		body.group = ignoreGroup;
		
		backWheel = new Body(BodyType.DYNAMIC);
		backWheel.shapes.add(new Circle(60));
		backWheel.group = ignoreGroup;
		
		frontWheel = new Body(BodyType.DYNAMIC);
		frontWheel.shapes.add(new Circle(32));
		frontWheel.group = ignoreGroup;
		
		body.space = space;
		backWheel.space = space;
		frontWheel.space = space;
		
		//new PivotJoint(body, backWheel, new Vec2(-(160 / 2), 30), new Vec2()).space = space;
		//new PivotJoint(body, frontWheel, new Vec2((90 / 2), 35), new Vec2()).space = space;}
		
		var l:LineJoint = new LineJoint(body, backWheel, new Vec2( -60, 45), new Vec2(), new Vec2(0, 5), 1, 5);
		l.space = space;
		l.ignore = true;
		var l:LineJoint = new LineJoint(body, frontWheel, new Vec2((90 / 2), 60), new Vec2(), new Vec2(0, 5), 1, 5);
		l.space = space;
		l.ignore = true;
		
		
		trailor = new Body(BodyType.DYNAMIC);
		
		trailor.shapes.add(new Polygon(Polygon.rect(-130, 0, 10, 55)));
		trailor.shapes.add(new Polygon(Polygon.rect(60, 0, 10, 55)));
		trailor.shapes.add(new Polygon(Polygon.rect(-130, 55, 270, 10)));
		
		trailor.group = ignoreGroup;
		
		trailorFrontWheel = new Body(BodyType.DYNAMIC);
		trailorFrontWheel.shapes.add(new Circle(30));
		trailorFrontWheel.group = ignoreGroup;
		trailorFrontWheel.space = space;
		
		trailorBackWheel = new Body(BodyType.DYNAMIC);
		trailorBackWheel.shapes.add(new Circle(30));
		trailorBackWheel.group = ignoreGroup;
		trailorBackWheel.space = space;
		
		var p:PivotJoint = new PivotJoint(trailor, trailorBackWheel, new Vec2( -80, 70), new Vec2());
		p.space = space;
		p.ignore = true;
		var p:PivotJoint = new PivotJoint(trailor, trailorFrontWheel, new Vec2(60, 70), new Vec2());
		p.space = space;
		p.ignore = true;
		
		var line = new LineJoint(body, trailor, new Vec2(-150, 100), new Vec2(125, 120), new Vec2( -10, 0), 1, 20);
		line.space = space;
		line.ignore = true;
		
		trailor.space = space;		
		trailor.mass = 2;
	}	
	
	override public function setScene(scene:Scene):Void 
	{
		super.setScene(scene);
		
		
		scene.addNode(frontWheelSprite = new Sprite("pimpmobile/tractor_wheel.png"));
		
		
		frontWheelSprite.scaleX = frontWheelSprite.scaleY = (32 * 2) / 117;
		
		
		//scene.addNode(new Sheep(space));
		scene.addNode(new Sheep(space, ignoreGroup));
		scene.addNode(new Sheep(space, ignoreGroup));
		scene.addNode(new Sheep(space, ignoreGroup));
		scene.addNode(new Sheep(space, ignoreGroup));
		scene.addNode(new Sheep(space, ignoreGroup));
		scene.addNode(new Sheep(space, ignoreGroup));
		scene.addNode(new Sheep(space, ignoreGroup));
		scene.addNode(new Sheep(space, ignoreGroup));
		scene.addNode(new Sheep(space, ignoreGroup));
		scene.addNode(new Sheep(space, ignoreGroup));
		scene.addNode(new Sheep(space, ignoreGroup));
		
		scene.addNode(trailorSprite = new Sprite("pimpmobile/trailer_back.png"));
		scene.addNode(tractorTop = new Sprite("pimpmobile/tractor_top.png"));
		
		
		scene.addNode(backTrailorWheelSprite = new Sprite("pimpmobile/trailer_wheels.png"));		
		scene.addNode(frontTrailorWheelSprite = new Sprite("pimpmobile/trailer_wheels.png"));
		scene.addNode(backWheelSprite = new Sprite("pimpmobile/tractor_wheel.png"));
		backWheelSprite.scaleX = backWheelSprite.scaleY = (60 * 2) / 117;
		
		backTrailorWheelSprite.scaleX = backTrailorWheelSprite.scaleY = (30 * 2) / 47;		
		frontTrailorWheelSprite.scaleX = frontTrailorWheelSprite.scaleY = (30 * 2) / 47;
		//scene.addNode(new Sheep(space));
	}
	
	override public function update(deltaTime:Float):Void 
	{
		if (!isRemote)
		{
			x = body.position.x - 20;
			y = body.position.y;
		}
		rotation = body.rotation;
		
		tractorTop.x = x;
		tractorTop.y = y;
		tractorTop.rotation = rotation;
		
		frontWheelSprite.x = frontWheel.position.x;
		frontWheelSprite.y = frontWheel.position.y;
		frontWheelSprite.rotation = frontWheel.rotation;
		
		backWheelSprite.x = backWheel.position.x;
		backWheelSprite.y = backWheel.position.y;
		backWheelSprite.rotation = backWheel.rotation;
		
		trailorSprite.x = trailor.position.x;
		trailorSprite.y = trailor.position.y;
		trailorSprite.rotation = trailor.rotation;
		
		backTrailorWheelSprite.x = trailorBackWheel.position.x;
		backTrailorWheelSprite.y = trailorBackWheel.position.y;
		backTrailorWheelSprite.rotation = trailorBackWheel.rotation;
		
		frontTrailorWheelSprite.x = trailorFrontWheel.position.x;
		frontTrailorWheelSprite.y = trailorFrontWheel.position.y;
		frontTrailorWheelSprite.rotation = trailorFrontWheel.rotation;
		
		super.update(deltaTime);
	}
}