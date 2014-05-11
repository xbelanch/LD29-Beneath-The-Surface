package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.plugin.MouseEventManager;


enum ItemKind {
	Mirror;
}


class Item extends FlxSprite {

	public var id:Int;
	public var kind:ItemKind;
	public var cursorEye:FlxSprite;

	override public function new (item:Dynamic){ // we must add a callback if it have an interaction

		super();
		this.id = item.id;
		this.kind = item.kind;
		this.x = item.position.x;
		this.y = item.position.y;

		
		// create the graphic object	
		// catch an exception if graphic don't load
		try {
			this.loadGraphic("assets/graphics/items" + item.graphic);
		} catch (msg : String) {
			trace("Could not load asset: " + msg);
		}
				
		// handle mouse events
		MouseEventManager.add(this, onMouseDown, null, onMouseOver, onMouseOut, false, true, false);	
		
		// mouse cursor shapes because its kind (moving, pickeable, sighting)
		// next cursor is only a test
		cursorEye = new FlxSprite();
		// cursorEye.makeGraphic(15, 15, FlxColor.TRANSPARENT);
		// cursorEye.drawCircle();


	} 

	override public function update(){
		// handle animations :? 
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
		// Reg.idView = this.idView;
	}



}