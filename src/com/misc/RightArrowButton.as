package com.misc 
{
	import org.flixel.FlxButton;
	/**
	 * ...
	 * @author Kody104
	 */
	public class RightArrowButton extends FlxButton
	{
		protected var Sprite:RightArrowSprite = new RightArrowSprite();
		protected var HighlightedSprite:RightArrowHighlightedSprite = new RightArrowHighlightedSprite();
		
		public function RightArrowButton(x:uint, y:uint, callback:Function) 
		{
			super(x, y, callback);
			loadGraphic(Sprite, HighlightedSprite);
		}
		
	}

}