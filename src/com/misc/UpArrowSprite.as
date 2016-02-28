package com.misc 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Kody104
	 */
	
	public class UpArrowSprite extends FlxSprite
	{
		[Embed(source = "../data/up_arrow.png")] private var Img:Class;
		
		public function UpArrowSprite() 
		{
			super(x, y, Img);
		}
		
	}

}