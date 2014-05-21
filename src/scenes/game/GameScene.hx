package scenes.game ;

import entities.Terrain;
import entities.Tractor;
import helpers.MathHelper;
import milkshake.game.network.NetworkManager;
import milkshake.game.scene.Scene;
import milkshake.core.Sprite;
import milkshake.core.GameObject;
import milkshake.game.scene.SceneManager;
import milkshake.game.ui.component.Button;
import milkshake.IGameCore;
import milkshake.input.KeyboardCode;
import milkshake.input.PixiInput;
import nape.constraint.Constraint;
import nape.constraint.PivotJoint;
import nape.dynamics.InteractionGroup;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.shape.Shape;
import nape.space.Space;
import network.handlers.GameHandler;
import network.MilkshakeNetworkManager;
import network.packets.Player;
import pixi.InteractionData;


class GameScene extends Scene
{
	private var bunny:Sprite;
	private var space:Space;
	private var debug:PixiDebug;
	public var tractor:Tractor;
	var terrain:Terrain;
	var networkManager:NetworkManager;
	var remoteTractors:Map<String, Tractor>;
	
	public var isMultiplayer:Bool = false;
	
	private var tractorIgnoreGroup:InteractionGroup;
		
	public function new(core:IGameCore, sceneManager:SceneManager, networkManager:MilkshakeNetworkManager)
	{
		super(core, "gameScene");
		this.networkManager = networkManager;
		
		remoteTractors = new Map<String, Tractor>();
		
		tractorIgnoreGroup = new InteractionGroup(true);
		
		space = new Space(new Vec2(0, 300));
		
		addLogo();
		
		tractor = new Tractor(space, tractorIgnoreGroup);
		
		tractor.x = 1280 / 2;
		tractor.y = 720 / 2;
		
		addNode(tractor);
		
		debug = new PixiDebug();
		addNode(debug);
		
		core.input.addKeyDownHandler(KeyboardCode.UP, function()
		{
			tractor.body.angularVel += 0.05;
		});
		
		core.input.addKeyDownHandler(KeyboardCode.RIGHT, function()
		{
			tractor.backWheel.angularVel += 1;
			tractor.backWheel.torque = 5;
			tractor.frontWheel.angularVel += 0.5;
			
			tractor.body.angularVel += 0.05;
		});
		core.input.addKeyDownHandler(KeyboardCode.LEFT, function()
		{
			tractor.backWheel.angularVel -= 1;
			tractor.body.angularVel -= 0.1;
			//tractor.trailor.angularVel += 1;
		});
		
		
		addNode(terrain = new Terrain(space));
		
		var quitGameButton:Button = new Button(250, 50, "Quit Game", 0xA9F5A9, 0x58FA58);
		quitGameButton.x = 375;
		quitGameButton.y = 600;
		quitGameButton.displayObject.click = function(data:InteractionData):Void
		{
			if (isMultiplayer) networkManager.roomHandler.leaveRoom();
			else sceneManager.changeScene("startMenu");
		}
		addNode(quitGameButton);
	}

	private function addLogo():Void
	{
		var bunnyContainer:GameObject = new GameObject("bunnyContainer");
		scene.addNode(bunnyContainer);

		bunny = new Sprite("milkLogo.png");
		bunnyContainer.addNode(bunny);
	}

	public function lerp( amount:Float , start:Float, end:Float ):Float 
    {
        if ( start == end ) 
        {
            return start ;
        }
        return ( ( 1 - amount ) * start ) + ( amount * end ) ;
    };
	
	override public function update(delta:Float)
	{
		space.step(1 / 24);
		//tractor.body.velocity.y = -100;
		debug.pixiDebug.clear();
		debug.pixiDebug.drawBody(terrain.body);
		super.update(delta);
		//tractor.update(delta);
		
		this.x = -(tractor.x * scaleX) + (1024 / 2) ;
		this.y = -(tractor.y * scaleX)	 + (768 / 2);
		
		var scaleValue = (1 - (Math.abs(tractor.body.velocity.x) / 1000));
		
		tractor.body.angularVel *= 0.9;
		
		tractor.backWheel.angularVel = MathHelper.clamp(tractor.backWheel.angularVel, -100, 100);
		
		scaleX = scaleY = lerp(0.005, scaleX, Math.max(Math.min(scaleValue, 1), 0.5));
		//trace(bunny.y);
		//bunny.scaleX = Math.sin(delta / 400) * 2;
		//bunny.scaleY = Math.cos(delta / 100) * 2;
	}
	
	public function updateRemotePlayer(data:Player) 
	{
		var tractor:Tractor = remoteTractors.get(data.id);
		
		if (tractor == null)
		{
			tractor = new Tractor(space, tractorIgnoreGroup, true);
			remoteTractors.set(data.id, tractor);
			addNode(tractor);
		}
		
		tractor.x = data.x;
		tractor.y = data.y;
	}
}