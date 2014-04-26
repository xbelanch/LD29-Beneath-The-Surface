package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxGroup;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
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

class Room {

	public var id:Int;
	public var movement:Dynamic; // {up, right, down, left}
	public var background:FlxSprite;

	public function new (id:Int, movement:Dynamic, backgroundImg:String):Void
	{
		this.id = id;
		this.movement = movement;
		this.background = new FlxSprite();
		this.background.loadGraphic("assets/rooms/" + backgroundImg); 
	}

	// paint everything: background + Controls   
	public function update():Void {

	}

	private function controls():Void{

	}
}

// Scene contains a Room Background + n Items 
class Scene extends FlxGroup {

	public var id:Int;

	public function new(id:Int):Void {

		this.id = id;
		super();
	}
}