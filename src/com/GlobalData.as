package com 
{
	/**
	 * ...
	 * @author Kody104
	 */
	public class GlobalData 
	{
		private static var allSchools:Array = new Array();
		private static var trains = 1;
		private static var week:uint = 1;
		private static var level:uint = 1;
		private static var exp:uint = 0;
		private static var nextExp:uint = 250;
		private static var showSlides:uint = 6;
		private static var showSpeed:uint = 3;
		
		public static function initSchools():void
		{
			for (var i:uint = 0; i < 5; i++)
			{
				var temp:School;
				switch(i)
				{
					case 0:
						temp = new School("Houston ISD", 50);
						break;
					case 1:
						temp = new School("San Antonio ISD", 30);
						break;
					case 2:
						temp = new School("Dallas ISD", 20);
						break;
					case 3:
						temp = new School("Austin ISD", 10);
						break;
					case 4:
						temp = new School("Fort Worth ISD", 5);
						break;
				}
				allSchools[i] = temp;
			}
		}
		
		public static function getAllSchools():Array
		{
			return allSchools;
		}
		
		public static function getSchool(index:uint):School
		{
			return allSchools[index];
		}
		
		public static function simSchools():void
		{
			for (var index in allSchools)
			{
				allSchools[index].trainStudents();
				allSchools[index].update();
			}
		}
		
		public static function getTrains():uint
		{
			return trains;
		}
		
		public static function updateTrains(amount:int=0):void
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
		
		public static function getWeek():uint
		{
			return week;
		}
		
		public static function updateWeek():void
		{
			week++;
		}
		
		public static function getLevel():uint
		{
			return level;
		}
		
		public static function getExp():uint
		{
			return exp;
		}
		
		public static function updateExp(amount:uint):void
		{
			var again:Boolean = false;
			exp += amount;
			if (checkExp())
			{
				exp -= getNextExp();
				if (checkExp())
					again = true;
				updateLevel();
				updateSlides();
				updateTrains();
				if (again)
					updateExp(0);
			}
		}
		
		public static function getShowSlides():uint
		{
			return showSlides;
		}
		
		public static function updateSlides():void
		{
			showSlides = ((0.5 * level) + 6);
		}
		
		public static function getNextExp():uint
		{
			updateNextExp();
			return nextExp;
		}
		
		public static function getShowSpeed():uint
		{
			return showSpeed;
		}
		
		public static function setShowSpeed(setSpeed:uint):void
		{
			showSpeed = setSpeed;
		}
		
		private static function checkExp():Boolean
		{
			if (exp >= getNextExp())
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		private static function updateNextExp():void
		{
			nextExp = (level * 250);
		}
		
		private static function updateLevel():void
		{
			level++;
		}
	}

}