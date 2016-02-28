package com 
{
	import adobe.utils.ProductManager;
	import com.misc.FlxInputText;
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import com.Enum.Img;
	
	/**
	 * ...
	 * @author Kody104
	 */
	
	public class PrePlayState extends FlxState
	{
		[Embed(source = "data/bandhall.csv", mimeType = "application/octet-stream")] private var bandHallMap:Class;
		[Embed(source = "data/bandhall_tileset.png")] private var bandHallTileset:Class;
		public static var studentList:Array = new Array();
		private var tempstudent:Student
		private var map:FlxTilemap;
		private var camPos:FlxObject;
		private var calendar:CalendarObject;
		private var shows:ShowObject;
		private var counter:Number = 0;
		
		private var trainButton1:FlxButton;
		private var trainButton2:FlxButton;
		
		private var menuBG:FlxSprite;
		private var menuText:FlxText;
		private var studentTrainBG:FlxSprite;
		private var studentTrainText:FlxText;
		private var continueBG:FlxSprite;
		private var continueText:FlxText;
		
		private var overallM:Number = 0;
		private var overallP:Number = 0;
		
		private var continueCheck:Boolean = false;
		
		private var background:FlxGroup = new FlxGroup();
		private var foreground:FlxGroup = new FlxGroup();
		private var studentTrainGroup:FlxGroup = new FlxGroup();
		private var continueGroup:FlxGroup = new FlxGroup();
		private var GUI:FlxGroup = new FlxGroup();
		
		public function PrePlayState() 
		{
			FlxG.mouse.show();
			map = new FlxTilemap();
			map.startingIndex = 0;
			map.drawIndex = 0;
			map.loadMap(new bandHallMap, bandHallTileset, 32, 32);
			calendar = new CalendarObject(6, 10, Img.CALENDAR);
			shows = new ShowObject(16, 10, Img.SHOW);
			background.add(map);
			background.add(calendar);
			background.add(shows);
			for (var x:int = 0; x < studentList.length; x++)
			{
				studentList[x].visible = true;
				studentList[x].tele((7 + x), 12);
				studentList[x].setMap(1, map);
				studentList[x].look("DOWN");
				foreground.add(studentList[x]);
				overallM += studentList[x].getMarchSkill();
				overallP += studentList[x].getPlaySkill();
			}
			overallM = overallM / 10;
			overallP = overallP / 10 ;
			studentTrainText = new FlxText(0, 0, 160, "Init Text");
			studentTrainBG = new FlxSprite(0, 0);
			studentTrainBG.alpha = 0.75;
			studentTrainGroup.add(studentTrainBG);
			studentTrainGroup.add(studentTrainText);
			studentTrainGroup.visible = false;
			studentTrainGroup.active = false;
			continueText = new FlxText(0, 0, 160, "Init Text");
			continueBG = new FlxSprite(0, 0);
			continueBG.alpha = 0.75;
			continueGroup.add(continueBG);
			continueGroup.add(continueText);
			continueGroup.visible = false;
			continueGroup.active = false;
			menuBG = new FlxSprite(5, 5);
			menuBG.createGraphic(500, 32, 0xff333333);
			menuBG.alpha = 0.75;
			menuBG.scrollFactor.x = 0;
			menuBG.scrollFactor.y = 0;
			menuText = new FlxText(10, 14, menuBG.width - 10, "Init Text");
			menuText.scrollFactor.x = 0;
			menuText.scrollFactor.y = 0;
			GUI.add(menuBG);
			GUI.add(menuText);
			camPos = new FlxObject(352, 384, 32, 32);
			trainButton1 = new FlxButton(48, 442, trainMarchStudent, 60, 200, 0xff584a7d, 0xff2b253d);
			var trainText1:FlxText = new FlxText(23, 17, 200, "Train Marching");
			trainText1.size = 16;
			trainButton1.loadText(trainText1)
			trainButton1.scrollFactor.x = 0;
			trainButton1.scrollFactor.y = 0;
			trainButton2 = new FlxButton(258, 442, trainPlayStudent, 60, 200, 0xff584a7d, 0xff2b253d);
			var trainText2:FlxText = new FlxText(13, 17, 200, "Train Instrument");
			trainText2.size = 16;
			trainButton2.loadText(trainText2);
			trainButton2.scrollFactor.x = 0;
			trainButton2.scrollFactor.y = 0;
			studentTrainGroup.add(trainButton1);
			studentTrainGroup.add(trainButton2);
			add(background);
			add(foreground);
			add(studentTrainGroup);
			add(continueGroup);
			add(GUI);
			add(camPos);
		}
		
		private function menuUpdate(followee:Student):void
		{
			studentTrainText.text = "Name: " + followee.getName() + "\nClass: " + followee.getClass() + "\nInstrument: " + followee.getInstrument() + 
				"\nMarching Skill: " + followee.getMarchSkill() + "\nInstrument Skill: " + followee.getPlaySkill();
			studentTrainText.x = followee.x + 22;
			studentTrainText.y = followee.y;
			studentTrainText.setFormat(null, 10, 0xFFFFFF, null, 0);
			studentTrainBG.createGraphic(studentTrainText.width, studentTrainText.height, 0xff333333);
			studentTrainBG.x = followee.x + 18;
			studentTrainBG.y = followee.y;
			studentTrainGroup.visible = true;
			studentTrainGroup.active = true;
			if (GlobalData.getTrains() < 1)
			{
				trainButton1.visible = false;
				trainButton2.visible = false;
				trainButton1.active = false;
				trainButton2.active = false;
			}
			else {
				trainButton1.visible = true;
				trainButton2.visible = true;
				trainButton1.active = true;
				trainButton2.active = true;
			}
			tempstudent = followee;
		}
		
		private function getOverlapsStudent(target:Student):Boolean
		{
			if (FlxG.mouse.cursor.getScreenXY().x > target.getScreenXY().x &&
				FlxG.mouse.cursor.getScreenXY().x < target.getScreenXY().x + 16 &&
				FlxG.mouse.cursor.getScreenXY().y > target.getScreenXY().y &&
				FlxG.mouse.cursor.getScreenXY().y < target.getScreenXY().y + 16)
				{
					return true;
				}
				return false;
		}
		
		private function getOverlapsButtons():Boolean
		{
			if (FlxG.mouse.cursor.getScreenXY().x > trainButton1.getScreenXY().x &&
			FlxG.mouse.cursor.getScreenXY().x < (trainButton1.getScreenXY().x + trainButton1.width) &&
			FlxG.mouse.cursor.getScreenXY().y > trainButton1.getScreenXY().y &&
			FlxG.mouse.cursor.getScreenXY().y < (trainButton1.getScreenXY().y + trainButton1.height))
			{
				return true;
			}
			else if (FlxG.mouse.cursor.getScreenXY().x > trainButton2.getScreenXY().x &&
			FlxG.mouse.cursor.getScreenXY().x < (trainButton2.getScreenXY().x + trainButton2.width) &&
			FlxG.mouse.cursor.getScreenXY().y > trainButton2.getScreenXY().y &&
			FlxG.mouse.cursor.getScreenXY().y < (trainButton2.getScreenXY().y + trainButton2.height))
			{
				return true;
			}
			return false;
		}
		
		private function getOverlapsCalendar():Boolean
		{
			if (FlxG.mouse.cursor.getScreenXY().x > calendar.getScreenXY().x &&
			FlxG.mouse.cursor.getScreenXY().x < (calendar.getScreenXY().x + calendar.width) &&
			FlxG.mouse.cursor.getScreenXY().y > calendar.getScreenXY().y &&
			FlxG.mouse.cursor.getScreenXY().y < (calendar.getScreenXY().y + calendar.height))
			{
				return true;
			}
			return false;
		}
		
		private function getOverlapsShows():Boolean
		{
			if (FlxG.mouse.cursor.getScreenXY().x > shows.getScreenXY().x &&
			FlxG.mouse.cursor.getScreenXY().x < (shows.getScreenXY().x + shows.width) &&
			FlxG.mouse.cursor.getScreenXY().y > shows.getScreenXY().y &&
			FlxG.mouse.cursor.getScreenXY().y < (shows.getScreenXY().y + shows.height))
			{
				return true;
			}
			return false;
		}
		
		private function preContinue():void
		{
			continueCheck = true;
			continueText.text = "Your show isn't complete yet. Click again to go anyways.";
			continueText.setFormat(null, 10, 0xFFFFFF, null, 0);
			continueBG.createGraphic(continueText.width + 8, continueText.height + 8, 0xff333333);
			continueBG.x = calendar.x - ((continueBG.width / 2) - calendar.width);
			continueBG.y = calendar.y;
			continueText.x = continueBG.x + 5;
			continueText.y = continueBG.y + 5;
			continueGroup.visible = true;
			continueGroup.active = true;
		}
		
		private function trainMarchStudent():void
		{
			if (GlobalData.getTrains() > 0)
			{
				tempstudent.trainMarchSkill();
				studentTrainText.setFormat(null, 14);
				studentTrainText.text = "You have trained " + tempstudent.getName() + "'s marching skill to " + tempstudent.getMarchSkill() + "!";
				studentTrainText.x = tempstudent.x + 22;
				studentTrainText.y = tempstudent.y;
				studentTrainBG.createGraphic(studentTrainText.width, studentTrainText.height, 0xff333333);
				studentTrainBG.x = tempstudent.x + 18;
				studentTrainBG.y = tempstudent.y;
				GlobalData.updateTrains( -1);
				overallM = 0;
				for (var index in studentList)
				{
					overallM += studentList[index].getMarchSkill();
				}
				overallM = overallM / 10;
			}
			if (GlobalData.getTrains() < 1)
			{
				trainButton1.visible = false;
				trainButton2.visible = false;
				trainButton1.active = false;
				trainButton2.active = false;
			}
		}
		
		private function trainPlayStudent():void
		{
			if (GlobalData.getTrains() > 0)
			{
				tempstudent.trainPlaySkill();
				studentTrainText.setFormat(null, 14);
				studentTrainText.text = "You have trained " + tempstudent.getName() + "'s instrument skill to " + tempstudent.getPlaySkill() + "!";
				studentTrainText.x = tempstudent.x + 22;
				studentTrainText.y = tempstudent.y;
				studentTrainBG.createGraphic(studentTrainText.width, studentTrainText.height, 0xff333333);
				studentTrainBG.x = tempstudent.x + 18;
				studentTrainBG.y = tempstudent.y;
				GlobalData.updateTrains( -1);
				overallP = 0;
				for (var index in studentList)
				{
					overallP += studentList[index].getPlaySkill();
				}
				overallP = overallP / 10;
			}
			if (GlobalData.getTrains() < 1)
			{
				trainButton1.visible = false;
				trainButton2.visible = false;
				trainButton1.active = false;
				trainButton2.active = false;
			}
		}
		
		override public function update():void
		{
			FlxG.follow(camPos);
			FlxG.followBounds(0, 0, 768, 768);
			counter += FlxG.elapsed;
			
			menuText.text = "Week: " + GlobalData.getWeek() + "  |  Trains: " + GlobalData.getTrains() + "  |  Level: " + GlobalData.getLevel() + "  |  Exp: " + GlobalData.getExp() + "/" + GlobalData.getNextExp() + "                 Overall Marching: " + Math.round(overallM) + "  |  Overall Playing: " + Math.round(overallP);
			
			if (counter >= 0.5)
			{
				var randomize:Number = Math.round((FlxU.random() * (studentList.length - 1)));
				var tempdir:Number = Math.round(FlxU.random() * 3);
				switch(tempdir)
				{
					case 0:
						studentList[randomize].move("DOWN");
						break;
					case 1:
						studentList[randomize].move("UP");
						break;
					case 2:
						studentList[randomize].move("LEFT");
						break;
					case 3:
						studentList[randomize].move("RIGHT");
						break;
				}
				counter = 0;
			}
			
			if ((FlxG.keys.UP || FlxG.keys.W) && camPos.y > 224)
			{
				camPos.y = camPos.y - 8;
			}
			else if ((FlxG.keys.DOWN || FlxG.keys.S) && camPos.y < 416)
			{
				camPos.y = camPos.y + 8;
			}
			
			if ((FlxG.keys.LEFT || FlxG.keys.A) && camPos.x > 240)
			{
				camPos.x = camPos.x - 8;
			}
			else if ((FlxG.keys.RIGHT || FlxG.keys.D) && camPos.x < 496)
			{
				camPos.x = camPos.x + 8;
			}
			
			if (FlxG.keys.justPressed("T"))
			{
				GlobalData.updateTrains(50);
			}
			
			if (FlxG.mouse.justPressed())
			{
				if (!studentTrainGroup.visible)
				{
					for (var index in studentList)
					{
						if (getOverlapsStudent(studentList[index]))
						{
							menuUpdate(studentList[index]);
							break;
						}
					}
				}
				else if (!getOverlapsButtons())
				{
					studentTrainGroup.visible = false;
					studentTrainGroup.active = false;
				}
				
				if (continueCheck) 
				{
					if (getOverlapsCalendar())
					{
						GlobalData.simSchools();
						if(GlobalData.getWeek() < 6)
							FlxG.state = new PlayState(studentList, GlobalData.getSchool(GlobalData.getWeek() - 1));
						if (GlobalData.getWeek() >= 6)
						{
							var go:uint;
							switch(GlobalData.getWeek())
							{
								case 6:
									go = 0;
									break;
								case 7:
									go = 1;
									break;
								case 8:
									go = 2;
									break;
								case 9:
									go = 3;
									break;
								case 10:
									go = 4;
									break;
								case 11:
									go = 0;
									break;
								case 12:
									go = 1;
									break;
							}
							FlxG.state = new PlayState(studentList, GlobalData.getSchool(go));
						}
					}
					else {
						continueCheck = false;
						continueGroup.visible = false;
						continueGroup.active = false;
					}
				}
				
				if (getOverlapsCalendar())
				{
					for (var index in studentList)
					{
						if (studentList[index].getShowMoves().length != GlobalData.getShowSlides())
						{
							preContinue();
							break;
						}
					}
				}
				
				if (getOverlapsShows())
				{
					FlxG.state = new ShowSelectState(studentList);
				}
			}
			
			super.update();
		}
		
	}

}