package com.misc 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kody104
	 */
	internal class RightArrowSprite extends FlxSprite
	{
		[Embed(source = "../data/right_arrow.png")] private var Img:Class;
		
		public function RightArrowSprite() 
		{
			super(x, y, Img);
		}
		
	}

}