package com.misc 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kody104
	 */
	internal class LeftArrowSprite extends FlxSprite
	{
		[Embed(source = "../data/left_arrow.png")] private var Img:Class;
		
		public function LeftArrowSprite() 
		{
			super(x, y, Img);
		}
		
	}

}