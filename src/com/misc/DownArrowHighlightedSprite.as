package com.misc 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Kody104
	 */
	
	public class DownArrowHighlightedSprite extends FlxSprite
	{
		[Embed(source = "../data/down_arrow_highlight.png")] private var Img:Class;
		
		public function DownArrowHighlightedSprite() 
		{
			super(x, y, Img);
		}
		
	}

}