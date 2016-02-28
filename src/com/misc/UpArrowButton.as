package com.misc 
{
	import org.flixel.FlxButton;
	/**
	 * ...
	 * @author Kody104
	 */
	public class UpArrowButton extends FlxButton
	{
		protected var Sprite:UpArrowSprite = new UpArrowSprite();
		protected var HighlightedSprite:UpArrowHighlightedSprite = new UpArrowHighlightedSprite();
		
		public function UpArrowButton(x:uint, y:uint, callback:Function) 
		{
			super(x, y, callback);
			loadGraphic(Sprite, HighlightedSprite);
		}
		
	}

}