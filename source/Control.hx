package;

// basic movement controls: up, right, down, left

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;
import flash.display.Sprite;

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
					this.makeGraphic(FlxG.width, 45, 0x6600cccc);
					// this.drawTriangle(FlxG.width*0.5 - 15, 5, 35, 0xffff0000);
					var triangle:Sprite = new Sprite();
					triangle.graphics.beginFill(0xccffffff);
					triangle.graphics.drawTriangles(flash.Vector.ofArray([FlxG.width * 0.5 - 18, 35, FlxG.width * 0.5, 10, FlxG.width * 0.5 + 18, 35]));
					triangle.graphics.endFill();
					this.pixels.draw(triangle);


				}
			case Right:
				{

					super(FlxG.width-45, 0, "", onClick);
					// we define a dir triangle
					this.makeGraphic(45, FlxG.height, 0x6600cccc);
					var triangle:Sprite = new Sprite();
					triangle.graphics.beginFill(0xccffffff);
					triangle.graphics.drawTriangles(flash.Vector.ofArray([10.0, FlxG.height*0.5-18, 35.0, FlxG.height*0.5, 10.0, FlxG.height*0.5 + 18]));
					triangle.graphics.endFill();
					this.pixels.draw(triangle);

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

		// only is visible at highlight 
		this.alpha = 0;

	}
	
	override public function update(){
		
		super.update();



		switch (status) {
			case FlxButton.HIGHLIGHT:
				this.alpha = 0.9;
			case FlxButton.NORMAL:
				this.alpha = 0;
		}

	}



	private function onClick():Void{
		trace("Hi");
	}

}