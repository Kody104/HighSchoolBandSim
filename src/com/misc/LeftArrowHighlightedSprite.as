package com.misc 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kody104
	 */
	internal class LeftArrowHighlightedSprite extends FlxSprite
	{
		[Embed(source = "../data/left_arrow_highlight.png")] private var Img:Class;
		
		public function LeftArrowHighlightedSprite()
		{
			super(x, y, Img);
		}
		
	}

}