package com 
{
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author Kody104
	 */
	public class School 
	{
		private var studentList:Array = new Array();
		
		private var name:String;
		
		private var director:ComDirector;
		
		public function School(Name:String, Lvl:uint=0) 
		{
			this.name = Name;
			
			if (Lvl != 0)
			{
				director = new ComDirector(Lvl);
			}
			else
			{
				director = new ComDirector();
			}
			
			for (var i:uint = 0; i < 10; i++)
			{
				var temp:ComStudent = new ComStudent();
				studentList[i] = temp;
			}
		}
		
		public function getStudentList():Array
		{
			return studentList;
		}
		
		public function getName():String
		{
			return name;
		}
		
		public function trainStudents():void
		{
			var allMarch:Array = new Array();
			var allPlay:Array = new Array();
			
			for (var index in studentList)
			{
				allMarch.push({key:index, value:studentList[index].getMarchSkill()});
				allPlay.push({key:index, value:studentList[index].getPlaySkill()});
			}
			
			allMarch.sortOn("value", Array.NUMERIC);
			allPlay.sortOn("value", Array.NUMERIC);
			
			var marchIndex:uint = 0;
			var playIndex:uint = 0;
			var tempMarch:uint = director.getMarchFavor();
			var tempPlay:uint = director.getPlayFavor();
			var toggle:Boolean = false;
			
			while(director.getTrains() != 0)
			{
				trace(name);
				if (!toggle)
				{
					trace("Marching: " + studentList[allMarch[marchIndex].key].getMarchSkill());
					if (tempMarch != 0)
					{
						studentList[allMarch[marchIndex].key].trainMarchSkill();
						marchIndex += 1;
						tempMarch -= 1;
						if (marchIndex >= (allMarch.length - 1))
						{
							marchIndex = 0;
						}
						if (tempMarch == 0)
						{
							tempMarch = director.getMarchFavor();
							toggle = true;
						}
					}
					else 
					{
						toggle = true;
					}
				}
				else 
				{
					trace("Instrument: " + studentList[allPlay[playIndex].key].getPlaySkill());
					if (tempPlay != 0)
					{
						studentList[allPlay[playIndex].key].trainPlaySkill();
						playIndex += 1;
						tempPlay -= 1;
						if (playIndex >= (allPlay.length - 1))
						{
							playIndex = 0;
						}
						if (tempPlay == 0)
						{
							tempPlay = director.getPlayFavor();
							toggle = false;
						}
					}
					else 
					{
						toggle = false;
					}
				}
				director.updateTrains(-1);
			}
		}
		
		public function update():void
		{
			director.updateTrains();
		}
		
	}

}