package com
{
	import flash.text.Font;
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
	
	public class PreviewShowState extends FlxState
	{
		[Embed(source = "data/outworld.csv", mimeType = "application/octet-stream")] private var outworldMap:Class;
		[Embed(source = "data/outworld_tileset.png")] private var outworldTileset:Class;
		public var studentList:Array = new Array();
		private var overlayBG:FlxSprite;
		private var backgroundBG:FlxSprite;
		private var isMenuUp:Boolean = false;
		private var hasStarted:Boolean = false;
		private var overlayText:FlxText;
		private var backgroundText:FlxText;
		public var map:FlxTilemap;
		public var tempStudent:Student;
		private var showIndex:uint = 0;
		
		private var background:FlxGroup = new FlxGroup();
		private var foreground:FlxGroup = new FlxGroup();
		private var GUI:FlxGroup = new FlxGroup();
		private var misc:FlxGroup = new FlxGroup();
		
		private var counter:Number = 0;
		
		public var camPos:FlxObject;
		
		public function PreviewShowState(studentList:Array)
		{
			FlxG.mouse.show();
			map = new FlxTilemap();
			map.startingIndex = 0;
			map.drawIndex = 0;
			map.loadMap(new outworldMap, outworldTileset, 32, 32);
			background.add(map);
			this.studentList = studentList;
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
			backgroundText = new FlxText(backgroundBG.x + 10,  backgroundBG.y + 10, backgroundBG.width - 10, "Click here to preview!");
			backgroundText.size = 12;
			misc.add(backgroundBG);
			misc.add(backgroundText);
			add(background);
			add(foreground);
			add(GUI);
			add(misc);
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
						switch(studentList[ii].getShowMove(showIndex))
						{
							case 0:
								FlxG.state = new ShowSelectState(studentList);
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
					}
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
				super.update();
			}
			else
			{
				if (FlxG.mouse.justPressed())
				{
					if (FlxG.mouse.cursor.overlaps(backgroundBG))
					{
						hasStarted = true;
						misc.visible = false;
						counter = GlobalData.getShowSpeed();
					}
				}
				if (FlxG.keys.justPressed("SPACE"))
				{
					hasStarted = true;
					misc.visible = false;
					counter = GlobalData.getShowSpeed();
				}
			}
		}
	}
}