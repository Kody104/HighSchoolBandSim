package com.misc 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kody104
	 */
	internal class RightArrowHighlightedSprite extends FlxSprite
	{
		[Embed(source = "../data/Right_arrow_highlight.png")] private var Img:Class;
		
		public function RightArrowHighlightedSprite()
		{
			super(x, y, Img);
		}
		
	}

}