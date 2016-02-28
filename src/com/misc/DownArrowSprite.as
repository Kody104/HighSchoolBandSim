package com.misc 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Kody104
	 */
	
	public class DownArrowSprite extends FlxSprite
	{
		[Embed(source = "../data/down_arrow.png")] private var Img:Class;
		
		public function DownArrowSprite() 
		{
			super(x, y, Img);
		}
		
	}

}