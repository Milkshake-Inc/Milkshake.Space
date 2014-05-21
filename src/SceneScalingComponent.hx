package ;

import milkshake.core.Sprite;
import milkshake.core.Node;
import milkshake.game.scene.component.SceneComponent;

class SceneScalingComponent extends SceneComponent
{
	public function new()
	{
		super("SceneScalingComponent");
	}

	override private function nodeAdded(node:Node):Void
	{
		if (Std.is(node, Sprite))
		{
			var sprite:Sprite = cast node;

			sprite.scaleX = 2;
			sprite.scaleY = 2;
		}
	}
}