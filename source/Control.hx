package;

// basic movement controls: up, right, down, left

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

class Control extends FlxButton {

	public var id:Int;
	private var control:Dynamic = {
		top:   {id: 0 },
		right: {id: 1 }, 
		down:  {id: 2 }, 
		left:  {id: 3 }  
	}
	

	override public function new(dir:Reg.Dir, ?view:Dynamic) {

		switch (dir) {
			case Top:
				{
					super(0, 0, "", onClick);
					this.makeGraphic(FlxG.width, 45, 0xff000000);
					this.drawCircle(20, 20, 19, 0xffff0000);
					this.alpha = 0;

				}
			case Right:
				{
					super(control.right);
				}
			case Left:
				{
					super(control.down);
				}

			case Bottom:
				{
					super(control.left);
				}
		}

	}
	∫
	override public function update(){
		
		super.update();



		switch (status) {
			case FlxButton.HIGHLIGHT:
				this.alpha = 0.65;
			case FlxButton.NORMAL:
				this.alpha = 0;
		}

	}



	private function onClick():Void{
		trace("Hi");
	}

}