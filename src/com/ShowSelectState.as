package com 
{
	import com.misc.DownArrowButton;
	import com.misc.LeftArrowButton;
	import com.misc.RightArrowButton;
	import com.misc.UpArrowButton;
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	
	/**
	 * ...
	 * @author Kody104
	 */
	
	public class ShowSelectState extends FlxState
	{
		[Embed(source = "data/charSelect.csv", mimeType = "application/octet-stream")] private var charSelectMap:Class;
		[Embed(source = "data/charSelect_tileset.png")] private var charSelectTileset:Class;
		private var studentList:Array = new Array();
		public var map:FlxTilemap;
		private var backgroundBox:FlxSprite;
		private var text:FlxText;
		private var index:uint = 0;
		private var showIndex:uint = 0;
		private var curShowSlide:uint = 1;
		private var slideText:FlxText;
		private var errorBG:FlxSprite;
		private var errorText:FlxText;
		private var showSpeedText:FlxText;
		
		private var upButton:UpArrowButton;
		private var downButton:DownArrowButton;
		private var leftButton:LeftArrowButton;
		private var rightButton:RightArrowButton;
		private var switchLeft:LeftArrowButton;
		private var switchRight:RightArrowButton;
		private var prevSlide:LeftArrowButton;
		private var nextSlide:RightArrowButton;
		private var previewButton:FlxButton;
		private var backButton:FlxButton;
		private var errorYes:FlxButton;
		private var errorNo:FlxButton;
		private var speed1:FlxButton;
		private var speed2:FlxButton;
		private var speed3:FlxButton;
		
		private var studentTBG:FlxSprite;
		private var studentT:FlxText;
		
		private var baseLayer:FlxGroup = new FlxGroup();
		private var midLayer:FlxGroup = new FlxGroup();
		private var errorLayer:FlxGroup = new FlxGroup();
		
		public function ShowSelectState(studentList:Array) 
		{
			map = new FlxTilemap();
			map.loadMap(new charSelectMap, charSelectTileset, 32, 32);
			baseLayer.add(map);
			backgroundBox = new FlxSprite(10, 10);
			backgroundBox.createGraphic(492, 492, 0xff00364a);
			backgroundBox.alpha = 0.75;
			baseLayer.add(backgroundBox);
			this.studentList = studentList;
			for (var i:uint = 0; i < studentList.length; i++)
			{
				if (studentList[i].getIsMoving())
				{
					studentList[i].resetWalk();
				}
				studentList[i].tele(8, 8);
				studentList[i].look("DOWN");
				studentList[i].setMap(3, map);
				studentList[i].visible = false;
				if (i == 0)
				{
					studentList[i].visible = true;
				}
				midLayer.add(studentList[i]);
			}
			text = new FlxText((backgroundBox.width / 2) - 66, backgroundBox.y + 5, 487);
			text.setFormat(null, 18);
			text.text = "Create a show!"
			slideText = new FlxText((backgroundBox.width / 2) - 26, backgroundBox.y + 35, 150);
			slideText.text = "Slide: " + curShowSlide + "/" + GlobalData.getShowSlides();
			slideText.setFormat(null, 14);
			baseLayer.add(text);
			baseLayer.add(slideText);
			switchLeft = new LeftArrowButton(224, 256, prevChar);
			switchLeft.visible = false;
			switchRight = new RightArrowButton(288, 256, nextChar);
			upButton = new UpArrowButton(160, 416, inputUp);
			downButton = new DownArrowButton(192, 416, inputDown);
			leftButton = new LeftArrowButton(320, 416, inputLeft);
			rightButton = new RightArrowButton(352, 416, inputRight);
			prevSlide = new LeftArrowButton(240, 64, gotoPrevSlide);
			prevSlide.visible = false;
			nextSlide = new RightArrowButton(272, 64, gotoNextSlide);
			midLayer.add(switchLeft);
			midLayer.add(switchRight);
			midLayer.add(upButton);
			midLayer.add(downButton);
			midLayer.add(leftButton);
			midLayer.add(rightButton);
			midLayer.add(prevSlide);
			midLayer.add(nextSlide);
			studentTBG = new FlxSprite(7 * 32, 6 * 32);
			studentTBG.alpha = 0.75;
			studentTBG.scrollFactor.x = 0;
			studentTBG.scrollFactor.y = 0;
			studentT = new FlxText(0, 0, 120, "Not Init");
			studentT.text = "Name: " + studentList[0].getName() + "\nClass: " + studentList[0].getClass() + "\nInstrument: " + studentList[0].getInstrument() + 
				"\nMarching Skill: " + studentList[0].getMarchSkill() + "\nInstrument Skill: " + studentList[0].getPlaySkill()  + "\nDirection: " + (studentList[0].getShowMove(0) > 0 ? (studentList[0].getShowMove(0) == 1 ? "Up" : (studentList[0].getShowMove(0) == 2 ? "Down" : (studentList[0].getShowMove(0) == 3 ? "Left" : (studentList[0].getShowMove(0) == 4 ? "Right" : "Error!")))) : "None");
			studentT.y = studentTBG.y;
			studentT.x = studentTBG.x + 4;
			studentTBG.createGraphic(120, studentT.height, 0xff333333);
			midLayer.add(studentTBG);
			midLayer.add(studentT);
			backButton = new FlxButton(10, 20, goBack);
			backButton.loadText(new FlxText(33, 3, 27, "Back"));
			previewButton = new FlxButton(402, 20, check);
			previewButton.loadText(new FlxText(27, 3, 44, "Preview"));
			midLayer.add(backButton);
			midLayer.add(previewButton);
			showSpeedText = new FlxText(406, 50, 122, "Show Speed");
			showSpeedText.size = 12;
			midLayer.add(showSpeedText);
			speed1 = new FlxButton(402, 80, setSlowSpeed);
			speed1.loadText(new FlxText(35, 3, 34, "Slow"));
			midLayer.add(speed1);
			speed2 = new FlxButton(402, 110, setMidSpeed);
			speed2.loadText(new FlxText(35, 3, 24, "Mid"));
			midLayer.add(speed2);
			speed3 = new FlxButton(402, 140, setFastSpeed);
			speed3.loadText(new FlxText(35, 3, 44, "Fast"));
			midLayer.add(speed3);
			errorBG = new FlxSprite(150, 95);
			errorBG.createGraphic(FlxG.width / 2 - 5, 71, 0xff333333);
			errorText = new FlxText(errorBG.x + 10, errorBG.y + 10, errorBG.width - 10, "Your show isn't complete! Preview anyways?");
			errorText.size = 12;
			errorYes = new FlxButton(150, 146, previewShow);
			errorYes.loadText(new FlxText(35, 3, 24, "Yes"));
			errorNo = new FlxButton(301, 146, setErrorFalse);
			errorNo.loadText(new FlxText(39, 3, 20, "No"));
			errorLayer.add(errorBG);
			errorLayer.add(errorText);
			errorLayer.add(errorYes);
			errorLayer.add(errorNo);
			errorLayer.visible = false;
			add(baseLayer);
			add(midLayer);
			add(errorLayer);
			FlxG.mouse.show();
			if (GlobalData.getShowSpeed() == 3)
			{
				setSlowSpeed();
			}
			else if (GlobalData.getShowSpeed() == 2)
			{
				setMidSpeed();
			}
			else
			{
				setFastSpeed();
			}
		}
		
		private function nextChar():void
		{
			if (!(index >= 9)) {
				studentList[index].visible = false;
				index++;
				
				if (studentList[index].getShowMove(showIndex) == 1)
				{
					studentList[index].look("UP");
				}
				else if (studentList[index].getShowMove(showIndex) == 2)
				{
					studentList[index].look("DOWN");
				}
				else if (studentList[index].getShowMove(showIndex) == 3)
				{
					studentList[index].look("LEFT");
				}
				else if (studentList[index].getShowMove(showIndex) == 4)
				{
					studentList[index].look("RIGHT");
				}
				else {
					studentList[index].look("DOWN");
				}
				
				studentT.text = "Name: " + studentList[index].getName() + "\nClass: " + studentList[index].getClass() + "\nInstrument: " + studentList[index].getInstrument() + 
				"\nMarching Skill: " + studentList[index].getMarchSkill() + "\nInstrument Skill: " + studentList[index].getPlaySkill() + "\nDirection: " + (studentList[index].getShowMove(showIndex) == 1 ? "Up":(studentList[index].getShowMove(showIndex) == 2 ? "Down":(studentList[index].getShowMove(showIndex) == 3 ? "Left":(studentList[index].getShowMove(showIndex) == 4 ? "Right":"None"))));
				
				studentList[index].visible = true;
				switchLeft.visible = true;
			}
			if (index == 9)
			{
				switchRight.visible = false;
			}
		}
		
		private function prevChar():void
		{
			if (index > 0)
			{
				studentList[index].visible = false;
				index--;
				
				if (studentList[index].getShowMove(showIndex) == 1)
				{
					studentList[index].look("UP");
				}
				else if (studentList[index].getShowMove(showIndex) == 2)
				{
					studentList[index].look("DOWN");
				}
				else if (studentList[index].getShowMove(showIndex) == 3)
				{
					studentList[index].look("LEFT");
				}
				else if (studentList[index].getShowMove(showIndex) == 4)
				{
					studentList[index].look("RIGHT");
				}
				else {
					studentList[index].look("DOWN");
				}
				
				studentT.text = "Name: " + studentList[index].getName() + "\nClass: " + studentList[index].getClass() + "\nInstrument: " + studentList[index].getInstrument() + 
				"\nMarching Skill: " + studentList[index].getMarchSkill() + "\nInstrument Skill: " + studentList[index].getPlaySkill() + "\nDirection: " + (studentList[index].getShowMove(showIndex) == 1 ? "Up":(studentList[index].getShowMove(showIndex) == 2 ? "Down":(studentList[index].getShowMove(showIndex) == 3 ? "Left":(studentList[index].getShowMove(showIndex) == 4 ? "Right":"None"))));
				
				studentList[index].visible = true;
				switchRight.visible = true;
			}
			if (index == 0)
			{
				switchLeft.visible = false;
			}
		}
		
		private function gotoNextSlide():void
		{
			if (!(showIndex >= (GlobalData.getShowSlides() - 1)))
			{
				showIndex++;
				curShowSlide++;
				prevSlide.visible = true;
				
				if (studentList[index].getShowMove(showIndex) == 1)
				{
					studentList[index].look("UP");
				}
				else if (studentList[index].getShowMove(showIndex) == 2)
				{
					studentList[index].look("DOWN");
				}
				else if (studentList[index].getShowMove(showIndex) == 3)
				{
					studentList[index].look("LEFT");
				}
				else if (studentList[index].getShowMove(showIndex) == 4)
				{
					studentList[index].look("RIGHT");
				}
				else {
					studentList[index].look("DOWN");
				}
				
				studentT.text = "Name: " + studentList[index].getName() + "\nClass: " + studentList[index].getClass() + "\nInstrument: " + studentList[index].getInstrument() + 
				"\nMarching Skill: " + studentList[index].getMarchSkill() + "\nInstrument Skill: " + studentList[index].getPlaySkill() + "\nDirection: " + (studentList[index].getShowMove(showIndex) == 1 ? "Up":(studentList[index].getShowMove(showIndex) == 2 ? "Down":(studentList[index].getShowMove(showIndex) == 3 ? "Left":(studentList[index].getShowMove(showIndex) == 4 ? "Right":"None"))));
			}
			if (showIndex == (GlobalData.getShowSlides() - 1))
			{
				nextSlide.visible = false;
			}
		}
		
		private function gotoPrevSlide():void
		{
			if (showIndex > 0)
			{
				showIndex--;
				curShowSlide--;
				nextSlide.visible = true;
				
				if (studentList[index].getShowMove(showIndex) == 1)
				{
					studentList[index].look("UP");
				}
				else if (studentList[index].getShowMove(showIndex) == 2)
				{
					studentList[index].look("DOWN");
				}
				else if (studentList[index].getShowMove(showIndex) == 3)
				{
					studentList[index].look("LEFT");
				}
				else if (studentList[index].getShowMove(showIndex) == 4)
				{
					studentList[index].look("RIGHT");
				}
				else {
					studentList[index].look("DOWN");
				}
				
				studentT.text = "Name: " + studentList[index].getName() + "\nClass: " + studentList[index].getClass() + "\nInstrument: " + studentList[index].getInstrument() + 
				"\nMarching Skill: " + studentList[index].getMarchSkill() + "\nInstrument Skill: " + studentList[index].getPlaySkill() + "\nDirection: " + (studentList[index].getShowMove(showIndex) == 1 ? "Up":(studentList[index].getShowMove(showIndex) == 2 ? "Down":(studentList[index].getShowMove(showIndex) == 3 ? "Left":(studentList[index].getShowMove(showIndex) == 4 ? "Right":"None"))));
			}
			if (showIndex == 0)
			{
				prevSlide.visible = false;
			}
		}
		
		private function inputUp():void
		{
			if (studentList[index].getShowMove(showIndex) != 1)
			{
				studentList[index].addShowMove("UP", true, showIndex);
			}
			studentT.text = "Name: " + studentList[index].getName() + "\nClass: " + studentList[index].getClass() + "\nInstrument: " + studentList[index].getInstrument() + 
				"\nMarching Skill: " + studentList[index].getMarchSkill() + "\nInstrument Skill: " + studentList[index].getPlaySkill() + "\nDirection: Up";
			studentList[index].look("UP");
		}
		
		private function inputDown():void
		{
			if (studentList[index].getShowMove(showIndex) != 2)
			{
				studentList[index].addShowMove("DOWN", true, showIndex);
			}
			studentT.text = "Name: " + studentList[index].getName() + "\nClass: " + studentList[index].getClass() + "\nInstrument: " + studentList[index].getInstrument() + 
				"\nMarching Skill: " + studentList[index].getMarchSkill() + "\nInstrument Skill: " + studentList[index].getPlaySkill() + "\nDirection: Down";
			studentList[index].look("DOWN");
		}
		
		private function inputLeft():void
		{
			if (studentList[index].getShowMove(showIndex) != 3)
			{
				studentList[index].addShowMove("LEFT", true, showIndex);
			}
			studentT.text = "Name: " + studentList[index].getName() + "\nClass: " + studentList[index].getClass() + "\nInstrument: " + studentList[index].getInstrument() + 
				"\nMarching Skill: " + studentList[index].getMarchSkill() + "\nInstrument Skill: " + studentList[index].getPlaySkill() + "\nDirection: Left";
			studentList[index].look("LEFT");
		}
		
		private function inputRight():void
		{
			if (studentList[index].getShowMove(showIndex) != 4)
			{
				studentList[index].addShowMove("RIGHT", true, showIndex);
			}
			studentT.text = "Name: " + studentList[index].getName() + "\nClass: " + studentList[index].getClass() + "\nInstrument: " + studentList[index].getInstrument() + 
				"\nMarching Skill: " + studentList[index].getMarchSkill() + "\nInstrument Skill: " + studentList[index].getPlaySkill() + "\nDirection: Right";
			studentList[index].look("RIGHT");
		}
		
		private function check():void
		{
			for (var index in studentList)
			{
				if (studentList[index].getShowMoves().length != GlobalData.getShowSlides())
				{
					errorLayer.visible = true;
					upButton.visible = false;
					downButton.visible = false;
					leftButton.visible = false;
					rightButton.visible = false;
					switchLeft.visible = false;
					switchRight.visible = false;
					prevSlide.visible = false;
					nextSlide.visible = false;
					previewButton.visible = false;
					backButton.visible = false;
					showSpeedText.visible = false;
					speed1.visible = false;
					speed2.visible = false;
					speed3.visible = false;
					return;
				}
			}
			previewShow();
		}
		
		private function setErrorFalse():void
		{
			errorLayer.visible = false;
			upButton.visible = true;
			downButton.visible = true;
			leftButton.visible = true;
			rightButton.visible = true;
			switchLeft.visible = true;
			switchRight.visible = true;
			prevSlide.visible = true;
			nextSlide.visible = true;
			previewButton.visible = true;
			backButton.visible = true;
			showSpeedText.visible = true;
			speed1.visible = true;
			speed2.visible = true;
			speed3.visible = true;
			
		}
		
		private function setSlowSpeed():void
		{
			GlobalData.setShowSpeed(3);
			speed1.on = true;
			speed2.on = false;
			speed3.on = false;
		}
		
		private function setMidSpeed():void
		{
			GlobalData.setShowSpeed(2);
			speed1.on = false;
			speed2.on = true;
			speed3.on = false;
		}
		
		private function setFastSpeed():void
		{
			GlobalData.setShowSpeed(1);
			speed1.on = false;
			speed2.on = false;
			speed3.on = true;
		}
		
		private function goBack():void
		{
			FlxG.state = new PrePlayState();
		}
		
		private function previewShow():void
		{
			FlxG.state = new PreviewShowState(studentList);
		}
		
		override public function update():void
		{	
			if (!errorLayer.visible)
			{
				slideText.text = "Slide: " + curShowSlide + "/" + GlobalData.getShowSlides();
				
				if (FlxG.keys.justPressed("D"))
				{
					nextChar();
				}
				else if (FlxG.keys.justPressed("A"))
				{
					prevChar();
				}
				
				if (FlxG.keys.justPressed("E"))
				{
					gotoNextSlide();
				}
				else if (FlxG.keys.justPressed("Q"))
				{
					gotoPrevSlide();
				}
				
				if (FlxG.keys.justPressed("UP"))
				{
					inputUp();
				}
				else if (FlxG.keys.justPressed("DOWN"))
				{
					inputDown();
				}
				if (FlxG.keys.justPressed("LEFT"))
				{
					inputLeft();
				}
				else if (FlxG.keys.justPressed("RIGHT"))
				{
					inputRight();
				}
				
				if (FlxG.keys.justPressed("ONE"))
				{
					GlobalData.updateExp(250);
				}
			}
			super.update();
		}
	}

}