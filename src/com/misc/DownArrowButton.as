package com.misc 
{
	import org.flixel.FlxButton;
	
	/**
	 * ...
	 * @author Kody104
	 */
	
	public class DownArrowButton extends FlxButton
	{
		protected var Sprite:DownArrowSprite = new DownArrowSprite();
		protected var HighlightedSprite:DownArrowHighlightedSprite = new DownArrowHighlightedSprite();
		
		public function DownArrowButton(x:uint, y:uint, callback:Function) 
		{
			super(x, y, callback);
			loadGraphic(Sprite, HighlightedSprite);
			this.x = x;
			this.y = y;
		}
		
	}

}