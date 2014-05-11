package;

// handle with simple controls up / right / bottom / left
import flixel.FlxG;
import flixel.group.FlxTypedGroup;

static var inline top:Dynamic = {
	position: {x: 0 , y: 0}
}

class Control extends Action {

	public var id:Int;
	
	override public function new(dir:Reg.Dir, view:Dynamic) {

		switch (dir) {
			case Top:
				{
					super();
				}
			case Right:
				{
					super();
				}
			case Left:
				{
					super();
				}

			case Bottom:
		}



	}


}