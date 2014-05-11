package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.plugin.MouseEventManager;
import flixel.util.FlxSpriteUtil;

class Action extends FlxSprite {

	public var cursorEye:FlxSprite;
	public var testSnow:Bool;

	override public function new(action:Dynamic){

		testSnow = false;
		
		super(action.position.x, action.position.y);
		this.makeGraphic(action.area.width, action.area.height, FlxColor.RED);		

		// Mouse Event handle
		MouseEventManager.add(this, onMouseDown, null, onMouseOver, onMouseOut, false, true, false);	

		// Graphic Cursor Handle
		cursorEye = new FlxSprite();
		cursorEye.makeGraphic(15, 15, FlxColor.TRANSPARENT);
		FlxSpriteUtil.drawCircle(cursorEye);
	}


	override public function update(){
		// test snow
		if (testSnow){

		}
	}

	override public function destroy(){
		super.destroy();
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
		testSnow = !testSnow;
		trace("jurl");
	}

}