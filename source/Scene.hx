package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.plugin.MouseEventManager;
import flixel.group.FlxTypedGroup;


// Scene contains a View background + n Items 
class Scene {

	public var view:FlxTypedGroup<Dynamic>;
	public var actions:FlxTypedGroup<Action>;
	public var sceneID:Dynamic;
	public var background:FlxSprite;
	public var dir:Int;

	public function new(id:Int):Void {

		sceneID = Reg.view[id];
		view = new FlxTypedGroup<FlxSprite>();
		actions = new FlxTypedGroup<Action>();

		// add background
		background = new FlxSprite();
		background.loadGraphic("assets/graphics/views/" + sceneID.background); 
		view.add(background);

		// add controls
		addControls();

		// add actions
		addActions();

	}

	public function update(idRoom:Int){
		sceneID = Reg.view[idRoom];
		background.loadGraphic("assets/graphics/views/" + sceneID.background);
		

		// remove elements
		// you must handle the 0 element 
		for (i in 1...view.members.length){
			view.members[i].destroy();
		}
		for (i in 0...actions.members.length){
			// actions.remove(actions.members[i]);
			actions.members[i].destroy();
		}

		// add controls for the new view
		addControls();

		// add items if the view has any of them
		addItems();

		// add actions :
		addActions();

		// handle room events test
		if (idRoom==5){
			Reg.view[0].background = "6.png";
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


