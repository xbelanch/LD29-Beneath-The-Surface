package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flixel.plugin.MouseEventManager;
import flash.display.Bitmap;
import flash.events.Event;


/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */

	public var mainID:Int;
	public var tf:FlxText;
	public var scene:Scene;



	override public function create():Void
	{



		// test
		mainID = Reg.idView;
		scene = new Scene(Reg.idView);
		add(scene.view);
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
			trace(Reg.idView);
			scene.update(Reg.idView);
			mainID = Reg.idView;
		}

		super.update();
	}	
}

class Item extends FlxSprite {

	public var id:Int;
	public var position:Dynamic; // x, y 

	override public function new (id){ // we must add a callback if it have an interaction

		super();
		this.id = id;

	} 

}


// Direction for controls 
enum Dir {
	Top;
	Right;
	Bottom;
	Left;
}

// where we handle the movemement between views of the room
class Direction extends FlxSprite {

	public var idRoom: Int;

	override public function new(Direction, idRoom:Int){

		super();
		this.idRoom = idRoom;
		this.makeGraphic(32, 32, 0xffff0000);

		switch (Direction) {
			case Dir.Top:
				this.x = Math.floor(FlxG.width / 2 - this.width/2); 
			case Dir.Right: {
				this.x = Math.floor(FlxG.width - this.width); 
				this.y = Math.floor(FlxG.height/2  - this.height/2); 
			}
			case Dir.Bottom: {
				this.x = Math.floor(FlxG.width / 2 - this.width/2); 
				this.y = Math.floor(FlxG.height  - this.height); 
			}
			case Dir.Left: {
				this.y = Math.floor(FlxG.height/2  - this.height/2);	
			}
		}

		MouseEventManager.add(this, onDown, onUp, onOver, onOut, false, true, true); 
	}

	override public function destroy(){
		MouseEventManager.remove(this);
	}

	private function onDown(Sprite:FlxSprite){
		Sprite.color = 0xffffffff;
		trace(idRoom);
		Reg.idView = idRoom;
	}

	private function onUp(Sprite:FlxSprite){
		Sprite.color = 0xffffffff;
	}

	private function onOver(Sprite:FlxSprite){
		Sprite.color = 0xff00ffff;
	}

	private function onOut(Sprite:FlxSprite){
		Sprite.color = 0xffff0000;
	}

}

class Inventory {

}


// Scene contains a View background + n Items 
class Scene {

	public var view:FlxTypedGroup<FlxSprite>;
	public var sceneID:Dynamic;
	public var background:FlxSprite;
	public var dir:Int;


	public function new(id:Int):Void {

		sceneID = Reg.room[id];
		view = new FlxTypedGroup<FlxSprite>();

		// add background
		background = new FlxSprite();
		background.loadGraphic("assets/images/views/" + sceneID.background); 
		view.add(background);

		// add controls
		addControls();
	}

	public function update(idRoom:Int){
		sceneID = Reg.room[idRoom];
		background.loadGraphic("assets/images/views/" + sceneID.background);
		// remove controls
		// background -> member 0
		for (i in 1...view.members.length){
			view.remove(view.members[i]);
		}
		// add controls for the new view
		addControls();
	}


	private function addControls() {
				// add directions controls
		if (sceneID.controls.top){
			var top = new Direction(Dir.Top, sceneID.directions.top);
			view.add(top);
		}

		if (sceneID.controls.right){
			var right = new Direction(Dir.Right, sceneID.directions.right);
			view.add(right);
		}

		if (sceneID.controls.bottom){
			var bottom = new Direction(Dir.Bottom, sceneID.directions.bottom);
			view.add(bottom);
		}

		if (sceneID.controls.left){
			var left = new Direction(Dir.Left, sceneID.directions.left);
			view.add(left);
		}
	}

}





