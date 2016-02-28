package com 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Kody104
	 */
	
	public class CalendarObject extends FlxSprite
	{		
		public function CalendarObject(x:uint, y:uint, image:Class) 
		{
			this.x = (x * 32);
			this.y = (y * 32);
			
			loadGraphic(image, false, false, 32, 32);
		}
		
	}

}