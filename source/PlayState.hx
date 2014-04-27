package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxGroup;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flixel.plugin.MouseEventManager;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */

	public var view:View;
	public var move:Bool;
	public var tf:FlxText;
	public var scene:FlxGroup;



	override public function create():Void
	{

		move = false;
		view = new View(Reg.idView); // starts from zero 
		add(view.background);
		add(view.controls);

		tf = new FlxText();
		tf.x = 15;
		tf.y = 15;
		tf.width = FlxG.width;
		add(tf);
	


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

		if (move){
			// mainScene.destroy();
			// mainScene  = new  Scene(Reg.idView);
			trace("Dummy");
		}

		// show info location pointer mouse
		tf.text = "mouseX = " + Math.floor(FlxG.mouse.x) + "\n" + "mouseY = " + Math.floor(FlxG.mouse.y);
		super.update();
	}	
}

class Item {

	public var id:Int;
	public var graphic:FlxSprite;
	public var position:Dynamic; // x, y 

	public function new (id:Int, position:Dynamic, graphicImg:String/*, ?CallBack:Void*/){ // we must add a callback if it have an interaction

		this.id = id;
		this.graphic = new FlxSprite(position.x, position.y);
		this.graphic.loadGraphic("assets/items/" +  graphicImg);
	} 

	public function update():Void {

	}

}

// where we handle the movemement between views of the room
class Controls {


}

class Inventory {

}

class View {

	public var id:Int;
	public var movement:Dynamic; // {up, right, down, left}
	public var controls:FlxGroup;
	public var background:FlxSprite;
	private var rightDirection:FlxSprite;
	private var leftDirection:FlxSprite;

	public function new (id:Int, ?movement:Dynamic):Void
	{
		this.id = id;
		this.movement = movement;
		this.controls = new FlxGroup();
		this.background = new FlxSprite();
		this.background.loadGraphic("assets/images/views/" + Std.int(id) + ".png"); 
		
		this.rightDirection = new FlxSprite();
		rightDirection.makeGraphic(64, 640, 0xffefefef);
		rightDirection.x = FlxG.width - 64;
		controls.add(rightDirection);

		this.leftDirection = new FlxSprite();



		MouseEventManager.add(rightDirection, onDown, null, onOver, onOut); 
		MouseEventManager.add(leftDirection, onDown, null, onOver, onOut); 


	}

	// paint everything: background + Controls   
	public function update():Void {

	}

	// mouse callbacks
	private function onDown(Sprite:FlxSprite){
		Sprite.color = 0xffff0000;
		id = 1;
	}
	
	private function onOver(Sprite:FlxSprite){
		Sprite.alpha = 0.5;
	}

	private function onOut(Sprite:FlxSprite){
		Sprite.alpha = 0.3;
	}
}

// Scene contains a View background + n Items 
class Scene extends FlxGroup {

	public var id:Int;

	public function new(id:Int):Void {

		this.id = id;
		super();
	}
}