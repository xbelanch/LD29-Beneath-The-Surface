package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flixel.plugin.MouseEventManager;
import flash.display.Bitmap;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.display.Sprite;

import  flixel.addons.ui.FlxClickArea;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */

	public var mainID:Int;
	public var scene:Scene;
	public var inventory:Inventory;
	public var tf:FlxText;

	// test
	public var __dir:FlxSprite;

	override public function create():Void
	{

		mainID = Reg.idView;
		scene = new Scene(Reg.idView);
		inventory = new Inventory();

		add(scene.view);
		add(scene.actions);
		add(inventory);

		////////////// test zone //////////////

		// __dir = new FlxSprite();
		// __dir.loadGraphic("assets/graphics/items/controls.png", false, 8, 15);
		// __dir.loadGraphic("assets/graphics/items/tree.png");
		// __dir.x = FlxG.width / 2;
		// __dir.y = FlxG.height / 2;
		// __dir.scale.set(10, 10);
		// add(__dir);
		
		///////////////////////////////////////		 

		////////////// mouse debug //////////////
		tf = new FlxText();
		tf.x = 15;
		tf.y = 15;
		tf.width = FlxG.width;
		add(tf);
		/////////////////////////////////////////


		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{

		if (Reg.idView != mainID){
			scene.update(Reg.idView);
			mainID = Reg.idView;
		}

		// need to handle here actions like see or other things 
		scene.actions.update();

		// need to handle with animations 
		// scene.animations.update();

		// show info location pointer mouse
		tf.text = "mouseX = " + Math.floor(FlxG.mouse.x) + "\n" + "mouseY = " + Math.floor(FlxG.mouse.y);
		super.update();
	}	
}






