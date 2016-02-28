package com.misc 
{
	import org.flixel.FlxButton;
	/**
	 * ...
	 * @author Kody104
	 */
	public class LeftArrowButton extends FlxButton
	{
		protected var Sprite:LeftArrowSprite = new LeftArrowSprite();
		protected var HighlightedSprite:LeftArrowHighlightedSprite = new LeftArrowHighlightedSprite();
		
		public function LeftArrowButton(x:uint, y:uint, callback:Function) 
		{
			super(x, y, callback);
			loadGraphic(Sprite, HighlightedSprite);
		}
		
	}

}