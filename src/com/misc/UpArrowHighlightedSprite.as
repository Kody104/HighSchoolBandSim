package com.misc 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Kody104
	 */
	
	public class UpArrowHighlightedSprite extends FlxSprite
	{
		[Embed(source = "../data/Up_arrow_highlight.png")] private var Img:Class;
		
		public function UpArrowHighlightedSprite() 
		{
			super(x, y, Img);
		}
		
	}

}