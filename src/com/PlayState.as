package com
{
	import flash.text.Font;
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import com.Enum.Img;
	
	/**
	 * ...
	 * @author Kody104
	 */
	
	public class PlayState extends FlxState
	{
		[Embed(source = "data/outworld.csv", mimeType = "application/octet-stream")] private var outworldMap:Class;
		[Embed(source = "data/outworld_tileset.png")] private var outworldTileset:Class;
		public var studentList:Array = new Array();
		private var overlayBG:FlxSprite;
		private var backgroundBG:FlxSprite;
		private var isMenuUp:Boolean = false;
		private var hasStarted:Boolean = false;
		private var judgeTime:Boolean = false;
		private var overlayText:FlxText;
		private var backgroundText:FlxText;
		public var map:FlxTilemap;
		public var tempStudent:Student;
		private var showIndex:uint = 0;
		
		private var judgeBG:FlxSprite;
		private var judgeText:FlxText;
		private var okButton:FlxButton;
		
		private var school:School;
		private var hasPlayed:Boolean = false;
		
		private var marchScore:Number = 0;
		private var playScore:Number = 0;
		private var expGain:uint = 0;
		
		private var background:FlxGroup = new FlxGroup();
		private var foreground:FlxGroup = new FlxGroup();
		private var GUI:FlxGroup = new FlxGroup();
		private var misc:FlxGroup = new FlxGroup();
		private var judgeGroup:FlxGroup = new FlxGroup();
		
		private var counter:Number = 0;
		
		public var camPos:FlxObject;
		
		public function PlayState(studentList:Array, at:School)
		{
			FlxG.mouse.show();
			map = new FlxTilemap();
			map.startingIndex = 0;
			map.drawIndex = 0;
			map.loadMap(new outworldMap, outworldTileset, 32, 32);
			background.add(map);
			this.studentList = studentList;
			this.school = at;
			for (var t:uint = 0; t < studentList.length; t++)
			{
				if (studentList[t].getIsMoving())
				{
					studentList[t].resetWalk();
				}
				studentList[t].visible = true;
				studentList[t].tele((7 + t), 8);
				studentList[t].setMap(2, map);
				studentList[t].look("DOWN");
				foreground.add(studentList[t]);
			}
			camPos = new FlxObject(224, 224, 32, 32);
			overlayBG = new FlxSprite(0, 0);
			overlayBG.createGraphic(160, 48, 0xFF333333);
			overlayBG.alpha = 0.75;
			GUI.visible = false;
			overlayText = new FlxText(0, 0, overlayBG.width - 10, "Init Text");
			GUI.add(overlayBG);
			GUI.add(overlayText);
			backgroundBG = new FlxSprite(camPos.x - 50, camPos.y);
			backgroundBG.createGraphic(FlxG.width / 2 - 66, 36, 0xFF333333);
			backgroundBG.alpha = 0.75;
			backgroundText = new FlxText(backgroundBG.x + 10,  backgroundBG.y + 10, backgroundBG.width - 10, "Show starts in: ");
			backgroundText.size = 12;
			misc.add(backgroundBG);
			misc.add(backgroundText);
			judgeBG = new FlxSprite((FlxG.width / 2) / 2, (FlxG.height / 2) / 2);
			judgeBG.createGraphic(FlxG.width / 2, (FlxG.height / 6) + 30, 0xff333333);
			judgeBG.scrollFactor.x = 0;
			judgeBG.scrollFactor.y = 0;
			judgeText = new FlxText(judgeBG.x + 10, judgeBG.y + 10, judgeBG.width - 10, "Init Text");
			judgeText.size = 10;
			judgeText.scrollFactor.x = 0;
			judgeText.scrollFactor.y = 0;
			okButton = new FlxButton(((judgeBG.x) + (judgeBG.width / 2) - 50), ((judgeBG.y) + (judgeBG.height) - 20), exit, 20, 100, 0xff777777, 0xff111111);
			okButton.loadText(new FlxText(40, 3, 60, "Ok"));
			okButton.scrollFactor.x = 0;
			okButton.scrollFactor.y = 0;
			judgeGroup.add(judgeBG);
			judgeGroup.add(judgeText);
			judgeGroup.add(okButton);
			judgeGroup.visible = false;
			judgeGroup.active = false
			add(background);
			add(foreground);
			add(GUI);
			add(misc);
			add(judgeGroup);
			add(camPos);
		}
		
		public function menuUpdate(followee:Student):void
		{
			overlayBG.x = followee.x + 18;
			overlayBG.y = followee.y;
			overlayText.setFormat(null, 10, 0xFFFFFF, null, 0);
			overlayText.text = "Name: " + followee.getName() + "\nClass: " + followee.getClass() + "\nInstrument: " + followee.getInstrument();
			overlayText.x = followee.x + 22;
			overlayText.y = followee.y;
			if (!GUI.visible)
			{
				GUI.visible = true;
			}
			
		}
		
		public function exit():void
		{
			GlobalData.updateExp(expGain);
			GlobalData.updateWeek();
			GlobalData.updateTrains();
			FlxG.state = new PrePlayState();
		}
		
		override public function update():void
		{	
			if (hasStarted)
			{
				FlxG.follow(camPos);
				FlxG.followBounds(0, 0, 768, 768);
				
				counter += FlxG.elapsed;
				
				if (FlxG.mouse.justPressed()){
					if (isMenuUp)
					{
						for (var i:uint = 0; i < studentList.length; i++)
						{
							if (FlxG.mouse.cursor.overlaps(studentList[i]))
							{
								tempStudent = studentList[i];
								isMenuUp = true;
								menuUpdate(tempStudent);
								break;
							}
							else {
								isMenuUp = false;
								GUI.visible = false;
							}
						}
					}
					else {
						for (var ii:uint = 0; ii < studentList.length; ii++)
						{
							if (FlxG.mouse.cursor.overlaps(studentList[ii]))
							{
								tempStudent = studentList[ii];
								isMenuUp = true;
								menuUpdate(tempStudent);
								break;
							}
						}
					}
				}
				
				if (isMenuUp)
				{
					menuUpdate(tempStudent);
				}
				
				
				if (counter >= GlobalData.getShowSpeed())
				{
					counter = 0;
					for (var ii:uint = 0; ii < studentList.length; ii++)
					{
						var thisMarch:Number = ((FlxU.random() * 0.2) + (studentList[ii].getMarchSkill() / 100));
						var thisPlay:Number = ((FlxU.random() * 0.2) + (studentList[ii].getPlaySkill() / 100));
						var roundedMarch:Number = int(Math.round(thisMarch * 10)) / 10;;
						var roundedPlay:Number = int(Math.round(thisPlay * 10)) / 10;
						trace("March: " + roundedMarch + " / " + thisMarch);
						trace("Play: " + roundedPlay + " / " + thisPlay);
						switch(studentList[ii].getShowMove(showIndex))
						{
							case 0:
								hasStarted = false;
								judgeTime = true;
								break;
							case 1:
								studentList[ii].move("UP");
								break;
							case 2:
								studentList[ii].move("DOWN");
								break;
							case 3:
								studentList[ii].move("LEFT");
								break;
							case 4:
								studentList[ii].move("RIGHT");
								break;
						}
						if (hasStarted)
						{
							if (roundedMarch >= 1.1)
							{
								marchScore += ((5 / 10) / GlobalData.getShowSlides());
								expGain += 1;
							}
							else if (roundedMarch >= 0.9)
							{
								marchScore += ((4 / 10) / GlobalData.getShowSlides());
								expGain += 3;
							}
							else if (roundedMarch >= 0.7)
							{
								marchScore += ((3 / 10) / GlobalData.getShowSlides());
								expGain += 5;
							}
							else if (roundedMarch >= 0.5)
							{
								marchScore += ((2 / 10) / GlobalData.getShowSlides());
								expGain += 8;
							}
							else if (roundedMarch >= 0.3)
							{
								marchScore += ((1 / 10) / GlobalData.getShowSlides());
								expGain += 10;
							}
							
							if (roundedPlay >= 1.1)
							{
								playScore += ((5 / 10) / GlobalData.getShowSlides());
								expGain += 1;
							}
							else if (roundedPlay >= 0.9)
							{
								playScore += ((4 / 10) / GlobalData.getShowSlides());
								expGain += 3;
							}
							else if (roundedPlay >= 0.7)
							{
								playScore += ((3 / 10) / GlobalData.getShowSlides());
								expGain += 5;
							}
							else if (roundedPlay >= 0.5)
							{
								playScore += ((2 / 10) / GlobalData.getShowSlides());
								expGain += 8;
							}
							else if (roundedPlay >= 0.3)
							{
								playScore += ((1 / 10) / GlobalData.getShowSlides());
								expGain += 10;
							}
						}
					}
					trace("March Score: " + Math.round(marchScore) + " / " + marchScore);
					trace("Play Score: " + Math.round(playScore) + " / " + playScore);
					showIndex++;
				}
				
				if ((FlxG.keys.LEFT || FlxG.keys.A) && camPos.x > 224)
				{
					camPos.x = camPos.x - 8;
				}
				else if ((FlxG.keys.RIGHT || FlxG.keys.D) && camPos.x < 496)
				{
					camPos.x = camPos.x + 8;
				}
				
				if ((FlxG.keys.UP || FlxG.keys.W) && camPos.y > 240)
				{
					camPos.y = camPos.y - 8;
				}
				else if ((FlxG.keys.DOWN || FlxG.keys.S) && camPos.y < 416)
				{
					camPos.y = camPos.y + 8;
				}
			}
			else if (judgeTime)
			{
				judgeGroup.visible = true;
				judgeGroup.active = true;
				if (!hasPlayed)
				{
					var tMarchScore:Number = 0;
					var tPlayScore:Number = 0;
					for (var index in school.getStudentList())
					{	
						for (var i:uint = 0; i < 6; i++)
						{
							var thisMarch:Number = ((FlxU.random() * 0.2) + (school.getStudentList()[index].getMarchSkill() / 100));
							var thisPlay:Number = ((FlxU.random() * 0.2) + (school.getStudentList()[index].getPlaySkill() / 100));
							var roundedMarch:Number = int(Math.round(thisMarch * 10)) / 10;;
							var roundedPlay:Number = int(Math.round(thisPlay * 10)) / 10;
							trace("Com March: " + roundedMarch + " / " + thisMarch);
							trace("Com Play: " + roundedPlay + " / " + thisPlay);
							
							if (roundedMarch >= 1.1)
							{
								tMarchScore += ((5 / 10) / 6);
							}
							else if (roundedMarch >= 0.9)
							{
								tMarchScore += ((4 / 10) / 6);
							}
							else if (roundedMarch >= 0.7)
							{
								tMarchScore += ((3 / 10) / 6);
							}
							else if (roundedMarch >= 0.5)
							{
								tMarchScore += ((2 / 10) / 6);
							}
							else if (roundedMarch >= 0.3)
							{
								tMarchScore += ((1 / 10) / 6);
							}
							
							if (roundedPlay >= 1.1)
							{
								tPlayScore += ((5 / 10) / 6);
							}
							else if (roundedPlay >= 0.9)
							{
								tPlayScore += ((4 / 10) / 6);
							}
							else if (roundedPlay >= 0.7)
							{
								tPlayScore += ((3 / 10) / 6);
							}
							else if (roundedPlay >= 0.5)
							{
								tPlayScore += ((2 / 10) / 6);
							}
							else if (roundedPlay >= 0.3)
							{
								tPlayScore += ((1 / 10) / 6);
							}
							
							trace("Com March Score: " + Math.round(tMarchScore) + " / " + tMarchScore);
							trace("Com Play Score: " + Math.round(tPlayScore) + " / " + tPlayScore);
						}
					}
					judgeText.text = "The band director of " + school.getName() + " says: ";
					if (tMarchScore > marchScore)
					{
						if ((tMarchScore - marchScore) > 4)
						{
							judgeText.text += "Your student's marching needs a lot of work. It's pretty awful.";
						}
						else if ((tMarchScore - marchScore) >= 3)
						{
							judgeText.text += "Your student's marching needs more work to be presentable.";
						}
						else if ((tMarchScore - marchScore) >= 2) 
						{
							judgeText.text += "Your student's marching is okay but could be better.";
						}
						else if ((tMarchScore - marchScore) >= 1)
						{
							judgeText.text += "Your student's marching is good but not great.";
						}
						else if ((tMarchScore - marchScore) >= 0.5)
						{
							judgeText.text += "Your student's marching is excellent but not perfect";
						}
						else
						{
							judgeText.text += "Your student's are pretty even with my student's in marching.";
						}
					}
					else
						judgeText.text += "Your student's marching is better than my student's.";
					if (tPlayScore > playScore)
					{
						if ((tPlayScore - playScore) > 4)
						{
							judgeText.text += " Your student's playing needs a lot of work. It's pretty awful.";
						}
						else if ((tPlayScore - playScore) >= 3)
						{
							judgeText.text += " Your student's playing needs more work to be presentable.";
						}
						else if ((tPlayScore - playScore) >= 2) 
						{
							judgeText.text += " Your student's playing is okay but could be better.";
						}
						else if ((tPlayScore - playScore) >= 1)
						{
							judgeText.text += " Your student's playing is good but not great.";
						}
						else if ((tPlayScore - playScore) >= 0.5)
						{
							judgeText.text += " Your student's playing is excellent but not perfect";
						}
						else 
						{
							judgeText.text += "Your student's are pretty even with my student's in playing.";
						}
					}
					else
						judgeText.text += " Your student's playing is better than my student's.";
					if (GlobalData.getLevel() < 5)
					{
						judgeText.text += " Once you get more experience you can train your students more.";
					}
					hasPlayed = true;
				}
			}
			else
			{
				counter += FlxG.elapsed;
				var dispNum:uint = counter;
				backgroundText.text = "Show starts in: " + (3 - dispNum);
				if (dispNum >= 3)
				{
					hasStarted = true;
					misc.visible = false;
					counter = GlobalData.getShowSpeed();
				}
			}
			super.update();
		}
	}
}