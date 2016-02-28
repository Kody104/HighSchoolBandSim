package com 
{
	import org.flixel.FlxU;
	import com.Enum.*;
	
	/**
	 * ...
	 * @author Kody104
	 */
	public class ComStudent 
	{
		private var marchSkill:uint;
		private var playSkill:uint;
		private var learnSkill:Number;
		private var sYear:String;
		
		public function ComStudent() 
		{
			var randomize:Number = Math.round(FlxU.random() * 3);
			
			switch(randomize)
			{
				case 0:
					sYear = Classes.FRESHMAN;
					break;
				case 1:
					sYear = Classes.SOPHMORE;
					break;
				case 2:
					sYear = Classes.JUNIOR;
					break;
				case 3:
					sYear = Classes.SENIOR;
					break;
			}
			
			switch(sYear)
			{
				case Classes.FRESHMAN:
					randomize = Math.round(FlxU.random() * 24) + 1;
					marchSkill = randomize;
					randomize = Math.round(FlxU.random() * 24) + 1;
					playSkill = randomize;
					break;
				case Classes.SOPHMORE:
					randomize = Math.round(FlxU.random() * 36) + 12;
					marchSkill = randomize;
					randomize = Math.round(FlxU.random() * 36) + 12;
					playSkill = randomize;
					break;
				case Classes.JUNIOR:
					randomize = Math.round(FlxU.random() * 48) + 24;
					marchSkill = randomize;
					randomize = Math.round(FlxU.random() * 48) + 24;
					playSkill = randomize;
					break;
				case Classes.SENIOR:
					randomize = Math.round(FlxU.random() * 60) + 36;
					marchSkill = randomize;
					randomize = Math.round(FlxU.random() * 60) + 36;
					playSkill = randomize;
					break;
					
			}
			
			randomize = (FlxU.random() * 1) + 1;
			
			learnSkill = randomize;
		}
		
		public function getMarchSkill():uint
		{
			return marchSkill;
		}
		
		public function trainMarchSkill():void
		{
			var basePlay:uint = Math.round((FlxU.random() * 4) + 1);
			var newPlay:uint = Math.round(basePlay * learnSkill);
			marchSkill += newPlay;
		}
		
		public function getPlaySkill():uint
		{
			return playSkill;
		}
		
		public function trainPlaySkill():void
		{
			var basePlay:uint = Math.round((FlxU.random() * 4) + 1);
			var newPlay:uint = Math.round(basePlay * learnSkill);
			playSkill += newPlay;
		}
		
		public function getLearnSkill():Number
		{
			return learnSkill;
		}
		
		public function getClass():String
		{
			return sYear;
		}
	}

}