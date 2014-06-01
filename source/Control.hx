package;

// basic movement controls: up, right, down, left

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;

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
					super(FlxG.width*0.5, 15, "", onClick);
					// var arrow:FlxSprite = new FlxSprite();
					// arrow.loadGraphic("assets/graphics/controls/top.png");
					this.loadGraphic("assets/graphics/controls/topB.png");
					// this.loadGraphicFromSprite(arrow);

					// this.scale.set(6, 6); //?
					this.color = 0xffff0000;
					// this.width = arrow.width * 6;
					// this.height = arrow.height * 6;
					// arrow.origin.x = this.origin.x;
					// arrow.origin.y = this.origin.y;

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

	override public function update(){
		
		super.update();



		switch (status) {
			case FlxButton.HIGHLIGHT:
				color = 0xffffff00;
				// scale.set(6,6);
			case FlxButton.NORMAL:
				color = 0xff3f3f3f;
				// scale.set(6,6);

			case FlxButton.PRESSED:
				color = 0xffff0000;
				scale.set(8, 8);
		}

	}



	private function onClick():Void{
		trace("Hi");
	}

}