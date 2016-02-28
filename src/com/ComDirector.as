package com 
{
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author Kody104
	 */
	public class ComDirector 
	{
		private var level:uint;
		private var trains:uint;
		
		private var marchFavor:uint;
		private var playFavor:uint;
		
		private var popularity:uint;
		
		public function ComDirector(Level:uint=0) 
		{
			if (Level == 0)
			{
				level = 1;
			}
			else
			{
				level = Level;
			}
			
			trains = (((level - 1) / 2) + 1);
			
			popularity = 50;
			
			var randomize:Number = Math.round(FlxU.random() * 4) + 1;
			var helpR:Number = FlxU.random();
			
			if (helpR < 0.5)
			{
				marchFavor = randomize;
				playFavor = 5 - randomize;
			}
			else 
			{
				playFavor = randomize;
				marchFavor = 5 - randomize;
			}
		}
		
		public function getLevel():uint
		{
			return level;
		}
		
		public function updateTrains(amount:int=0):void
		{
			if (amount == 0)
			{
				trains = (((level - 1) / 2) + 1);
			}
			else
			{
				trains += amount;
			}
		}
		
		public function getTrains():uint
		{
			return trains;
		}
		
		public function getMarchFavor():uint
		{
			return marchFavor;
		}
		
		public function getPlayFavor():uint
		{
			return playFavor;
		}
		
		public function gainPopularity(amount:uint=0):void
		{
			popularity += amount;
		}
		
		public function losePopularity(amount:uint=0):void
		{
			popularity -= amount;
		}
	}

}