package com 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kody104
	 */
	public class ShowObject extends FlxSprite
	{
		
		public function ShowObject(x:uint, y:uint, image:Class)
		{
			this.x = (x * 32);
			this.y = (y * 32);
			
			loadGraphic(image, false, false, 32, 32);
		}
		
	}

}