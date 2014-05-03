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


	override public function create():Void
	{



		// test
		mainID = Reg.idView;
		scene = new Scene(Reg.idView);
		inventory = new Inventory();

		add(scene.view);
		add(scene.actions);
		add(inventory);
		
		// mouse debug
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

		if (Reg.idView != mainID){
			scene.update(Reg.idView);
			mainID = Reg.idView;
		}
		// need to handle here actions like see or other things 
		// scene.actions.update();

		// show info location pointer mouse
		tf.text = "mouseX = " + Math.floor(FlxG.mouse.x) + "\n" + "mouseY = " + Math.floor(FlxG.mouse.y);
		super.update();
	}	
}



// where we handle the movemement between views of the room
class Direction extends FlxSprite {

	public var idRoom: Int;

	override public function new(Direction, idRoom:Int){

		super();
		this.idRoom = idRoom;
		this.makeGraphic(32, 32, 0xffff0000);

		switch (Direction) {
			case Reg.Dir.Top:
				this.x = Math.floor(FlxG.width / 2 - this.width/2); 
			case Reg.Dir.Right: {
				this.x = Math.floor(FlxG.width - this.width); 
				this.y = Math.floor(FlxG.height/2  - this.height/2); 
			}
			case Reg.Dir.Bottom: {
				this.x = Math.floor(FlxG.width / 2 - this.width/2); 
				this.y = Math.floor(FlxG.height  - this.height); 
			}
			case Reg.Dir.Left: {
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

class Inventory extends FlxTypedGroup<FlxSprite> {

	public var Items:Array<Item>;

	override public function new(){
		super();

	} 

	override public function update(){

	}

}


class Action extends FlxSprite {

	public var cursorEye:FlxSprite;

	override public function new(action:Dynamic){
		
		super(action.position.x, action.position.y);
		this.makeGraphic(action.area.width, action.area.height, FlxColor.RED);
		// drawCircle();
		MouseEventManager.add(this, onMouseDown, null, onMouseOver, onMouseOut, false, true, false);	

		// mouse cursor shapes because its kind (moving, pickeable, sighting)
		// next cursor is only a test
		cursorEye = new FlxSprite();
		cursorEye.makeGraphic(15, 15, FlxColor.TRANSPARENT);
		cursorEye.drawCircle();
	}

	override public function destroy(){
		MouseEventManager.remove(this);
		cursorEye.destroy();
	}


	private function onMouseOver(Sprite:FlxSprite):Void{
		// Load the sprite's graphic to the cursor
		FlxG.mouse.load(cursorEye.pixels);
	}

	private function onMouseOut(Sprite:FlxSprite):Void {
		// return original cursor
		FlxG.mouse.unload();
	}

	private function onMouseDown(Sprite:FlxSprite):Void{
		// it depends on kind of "object"
		// for test purposes we test a simple moving to another view
		trace("Check onMouseDown");

	}

}


class Item extends FlxSprite {

	public var id:Int;
	public var graphic:FlxSprite;
	public var action:FlxClickArea;
	public var type:Reg.ItemType;
	public var position:Dynamic;
	public var area:Dynamic;
	public var isPickeable:Bool; // if not only works for navigate
	public var cursorEye:FlxSprite;
	public var idView:Int;

	override public function new (item:Dynamic){ // we must add a callback if it have an interaction

		super();
		this.id = item.id;
		// this.isPickeable = item.isPickeable; 
		this.x = item.position.x;
		this.y = item.position.y;
		this.idView = item.idView;


		// add a "object" that player can pick up to and fit into inventory
			
		this.makeGraphic(item.area.width, item.area.height, FlxColor.TRANSPARENT);
		// handle mouse events
		MouseEventManager.add(this, onMouseDown, null, onMouseOver, onMouseOut, false, true, false);	
		
		// mouse cursor shapes because its kind (moving, pickeable, sighting)
		// next cursor is only a test
		cursorEye = new FlxSprite();
		cursorEye.makeGraphic(15, 15, FlxColor.TRANSPARENT);
		cursorEye.drawCircle();


	} 

	override public function destroy(){
		MouseEventManager.remove(this);
	}


	private function onMouseOver(Sprite:FlxSprite):Void{
		// Load the sprite's graphic to the cursor
		FlxG.mouse.load(cursorEye.pixels);
	}

	private function onMouseOut(Sprite:FlxSprite):Void {
		// return original cursor
		FlxG.mouse.unload();
	}

	private function onMouseDown(Sprite:FlxSprite):Void{
		// it depends on kind of "object"
		// for test purposes we test a simple moving to another view
		FlxG.mouse.unload();
		Reg.idView = this.idView;
	}



}

// Scene contains a View background + n Items 
class Scene {

	public var view:FlxTypedGroup<Dynamic>;
	public var actions:FlxTypedGroup<Action>;
	public var sceneID:Dynamic;
	public var background:FlxSprite;
	public var dir:Int;

	public function new(id:Int):Void {

		sceneID = Reg.room[id];
		view = new FlxTypedGroup<FlxSprite>();
		actions = new FlxTypedGroup<Action>();

		// add background
		background = new FlxSprite();
		background.loadGraphic("assets/images/views/" + sceneID.background); 
		view.add(background);

		// add controls
		addControls();

		// add actions
		addActions();

	}

	public function update(idRoom:Int){
		sceneID = Reg.room[idRoom];
		background.loadGraphic("assets/images/views/" + sceneID.background);
		// remove controls
		// background -> member 0
		for (i in 1...view.members.length){
			view.remove(view.members[i]);
		}
		for (i in 0...actions.members.length){
			actions.remove(actions.members[i]);
		}
		// add controls for the new view
		addControls();

		// add items if the view has any of them
		addItems();

		// add actions :
		addActions();

		// handle room events test
		if (idRoom==5){
			Reg.room[0].background = "6.png";
		}
	}

	// add items 
	private function addItems(){

		var objects:Array<Dynamic> = sceneID.items;
		if(objects.length > 0){
			for (object in objects){
				var item:Item = new Item(object);
				view.add(item);
			}
		}
	}

	// add actions
	private function addActions(){

		var _actions:Array<Dynamic> = sceneID.actions;
		if(_actions.length > 0){
			for (_action_ in _actions){
				trace(_action_);
				var a:Action = new Action(_action_);
				actions.add(a);
			}
		}
	}

	private function addControls() {
				// add directions controls
		if (sceneID.controls.top){
			var top = new Direction(Reg.Dir.Top, sceneID.directions.top);
			view.add(top);
		}

		if (sceneID.controls.right){
			var right = new Direction(Reg.Dir.Right, sceneID.directions.right);
			view.add(right);
		}

		if (sceneID.controls.bottom){
			var bottom = new Direction(Reg.Dir.Bottom, sceneID.directions.bottom);
			view.add(bottom);
		}

		if (sceneID.controls.left){
			var left = new Direction(Reg.Dir.Left, sceneID.directions.left);
			view.add(left);
		}
	}

}





