package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.plugin.MouseEventManager;
import flixel.util.FlxSpriteUtil;

// Action are transparent regions player can interact 

class Action extends FlxSprite {

	public var cursorEye:FlxSprite;
	public var testSnow:Bool;

	override public function new(action:Dynamic){

		testSnow = false;
		
		super(action.position.x, action.position.y);

		// esto dependerá del gráfico de la acción
		// transparente en el caso del control
		// transparente en el caso de mirar un objeto

		// esto me lleva a pensar que:
		// action extends object y éste object extends FlxSprite? 

		// en cambio, el control básico de movimiento debería formar parte 
		// de la Scene, és decir, la interacción básica: moverse entre ellas
		// luego es necesario cargarse la class Control.

		// por otro lado, mejor separar las cosas
		// un objeto puede tener una acción
		// if (has_action){
		//		action = new Action(type)	
		// }		

		this.makeGraphic(action.area.width, action.area.height, FlxColor.RED);		

		// Mouse Event handle
		MouseEventManager.add(this, onMouseDown, null, onMouseOver, onMouseOut, false, true, false);	

		// Graphic Cursor Handle
		// si es de control movimiento
		// si es de mirar, el ojo
		// si es de coger, la mano
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