package;

import flixel.util.FlxSave;

// Direction for controls 
enum Dir {
	Top;
	Right;
	Bottom;
	Left;
}

// Action
enum ActionType {
	GoTo;
	See;
}

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{

	public static var idView:Int = 0;
	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];


	public static var view:Array<Dynamic> = [
		{
			id: 0,
			background: "0.png",
			controls: {top: true, right: true, bottom: false, left: true},
			directions: {top: 1, right: 2, left: 3},
			items: [],
			actions: [{id: 0, position: {x: 0, y: 0}, area: {width: 75, height: 75}, action: ActionType.See}]

		},
		{
			id: 1,
			background: "1.png",
			controls: {bottom: true},
			directions: {bottom: 0},
			items: [],
			actions: []

		},
		{
			id: 2,
			background: "2.png",
			controls: {top: false, right: true, bottom: false, left: true},
			directions: {right: 4, left: 0},
			items: [],
			actions: []

		},
		{
			id: 3,
			background: "3.png",
			controls: {top: false, right: true, bottom: false, left: true},
			directions: {right: 0, left: 4},
			items: [],
			actions: []
		},
		{
			id: 4,
			background: "4.png",
			controls: {top: false, right: true, bottom: false, left: true},
			directions: {right: 3, left: 2},
			actions: [{ id: 0, position: {x:310, y: 310}, area: {width: 15, height: 15}, idView: 5}],
			items: []
		},
		{
			id: 5,
			background: "5.png",
			controls: {bottom: true},
			directions: {bottom: 4},
			items: [],
			actions: []

		},
	]; // end of
}