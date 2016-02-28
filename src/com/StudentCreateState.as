package com 
{
	import com.misc.LeftArrowButton;
	import com.misc.RightArrowButton;
	import com.misc.FlxInputText;
	import org.flixel.FlxSprite;
	import org.flixel.FlxButton;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import com.Enum.Img;
	import com.Enum.*;
	
	/**
	 * ...
	 * @author Kody104
	 */
	
	public class StudentCreateState extends FlxState
	{
		[Embed(source = "data/charSelect.csv", mimeType = "application/octet-stream")] private var charSelectMap:Class;
		[Embed(source = "data/charSelect_tileset.png")] private var charSelectTileset:Class;
		public var map:FlxTilemap;
		public var student:Array = new Array();
		public var nameField:FlxInputText;
		public var custName:FlxText;
		public var classYear:FlxText;
		public var instField:FlxText;
		public var leftbutton:LeftArrowButton = new LeftArrowButton(70, 248, prevChar);
		public var rightbutton:RightArrowButton = new RightArrowButton(122, 248, nextChar);
		public var leftbutton1:LeftArrowButton = new LeftArrowButton(FlxG.width / 2 + 140, 75, prevClass);
		public var rightbutton1:RightArrowButton = new RightArrowButton(FlxG.width / 2 + 160, 75, nextClass);
		public var leftbutton2:LeftArrowButton = new LeftArrowButton(FlxG.width / 2 + 140, 105, prevInstrument);
		public var rightbutton2:RightArrowButton = new RightArrowButton(FlxG.width / 2 + 160, 105, nextInstrument);
		public var confirm1:FlxButton = new FlxButton(FlxG.width / 2 + 140, 53, confirmName);
		public var startGameButton:FlxButton = new FlxButton(322, 472, startGame);
		public var index:uint = 0;
		
		public function StudentCreateState() 
		{
			map = new FlxTilemap();
			map.loadMap(new charSelectMap, charSelectTileset, 32, 32);
			add(map);
			FlxG.mouse.show();
			var textUnderlay:FlxSprite = new FlxSprite(FlxG.width / 2 - 20, 10);
			textUnderlay.createGraphic(FlxG.width / 2 + 10, FlxG.height - 20, 0xff00364a);
			textUnderlay.alpha = 0.75;
			add(textUnderlay);
			var label0:FlxText = new FlxText(textUnderlay.x + 20, textUnderlay.y + 5, 300, "Name your students!");
			label0.setFormat(null, 18);
			add(label0);
			for (var i:uint = 0; i < 10; i++)
			{
				var temp:Student;
				switch(i)
				{
					case 0:
						temp = new Student(3, 8, Img.MALE1, map, true);
						break;
					case 1:
						temp = new Student(3, 8, Img.FEMALE1, map, false);
						break;
					case 2:
						temp = new Student(3, 8, Img.MALE2, map, true);
						break;
					case 3:
						temp = new Student(3, 8, Img.FEMALE2, map, false);
						break;
					case 4:
						temp = new Student(3, 8, Img.MALE3, map, true);
						break;
					case 5:
						temp = new Student(3, 8, Img.FEMALE3, map, false);
						break;
					case 6:
						temp = new Student(3, 8, Img.MALE4, map, true);
						break;
					case 7:
						temp = new Student(3, 8, Img.FEMALE4, map, false);
						break;
					case 8:
						temp = new Student(3, 8, Img.MALE5, map, true);
						break;
					case 9:
						temp = new Student(3, 8, Img.FEMALE5, map, false);
						break;
				}
				student[i] = temp;
				temp.visible = false;
				if (i == 0)
				{
					temp.visible = true;
					if (student[i].getClass() == Classes.FRESHMAN)
					{
						leftbutton1.visible = false;
					}
					else if (student[i].getClass() == Classes.SENIOR)
					{
						rightbutton1.visible = false;
					}
				}
				add(temp);
			}
			leftbutton.visible = false;
			add(leftbutton);
			add(leftbutton1);
			add(leftbutton2);
			add(rightbutton);
			add(rightbutton1);
			add(rightbutton2);
			var label1:FlxText = new FlxText(FlxG.width / 2 - 15, 53, 100, "Name: ");
			label1.setFormat(null, 10);
			add(label1);
			custName = new FlxText(FlxG.width / 2 + 35, 50, 100, student[index].getName());
			custName.setFormat(null, 14);
			custName.visible = false;
			add(custName);
			var label2:FlxText = new FlxText(FlxG.width / 2 - 15, 83, 100, "Class: ");
			label2.setFormat(null, 10);
			add(label2);
			classYear = new FlxText(FlxG.width / 2 + 35, 80, 100, student[index].getClass());
			classYear.setFormat(null, 14);
			add(classYear);
			var label3:FlxText = new FlxText(FlxG.width / 2 - 15, 113, 100, "Instrument: ");
			label3.setFormat(null, 6);
			add(label3);
			instField = new FlxText(FlxG.width / 2 + 35, 110, 100, student[index].getInstrument());
			instField.setFormat(null, 14);
			add(instField);
			confirm1.loadText(new FlxText(25, 3, 100, "Confirm"));
			add(confirm1);
			startGameButton.loadText(new FlxText(20, 3, 100, "Start Game"));
			add(startGameButton);
		}
		
		override public function create():void
		{
			add(nameField = new FlxInputText(FlxG.width / 2 + 35, 50, 100, student[index].getName()));
		}
		
		private function nextChar():void
		{
			if (!(index >= 9)) {
				student[index].visible = false;
				index++;
				
				if (student[index].hasCustom)
				{
					nameField.visible = false;
					custName.visible = true;
					confirm1.visible = false;
				}
				else 
				{
					nameField.visible = true;
					custName.visible = false;
					confirm1.visible = true;
				}
				
				student[index].visible = true;
				leftbutton.visible = true;
				nameField.text = student[index].getName();
				classYear.text = student[index].getClass();
				instField.text = student[index].getInstrument();
				custName.text = student[index].getName();
				
				if (student[index].getClass() == Classes.FRESHMAN)
				{
					leftbutton1.visible = false;
					rightbutton1.visible = true;
				}
				else if (student[index].getClass() == Classes.SENIOR)
				{
					rightbutton1.visible = false;
					leftbutton1.visible = true;
				}
				else {
					leftbutton1.visible = true;
					rightbutton1.visible = true;
				}
				
				if (student[index].getInstrument() == Instruments.INSTRUMENT[0])
				{
					leftbutton2.visible = false;
					rightbutton2.visible = true;
				}
				else if (student[index].getInstrument() == Instruments.INSTRUMENT[Instruments.INSTRUMENT.length - 1])
				{
					leftbutton2.visible = true;
					rightbutton2.visible = false;
				}
				else {
					leftbutton2.visible = true;
					rightbutton2.visible = true;
				}
			}
			if (index == 9)
			{
				rightbutton.visible = false;
			}
		}
		
		private function prevChar():void
		{
			if (index > 0)
			{
				student[index].visible = false;
				index--;
				
				if (student[index].hasCustom)
				{
					nameField.visible = false;
					custName.visible = true;
					confirm1.visible = false;
				}
				else 
				{
					nameField.visible = true;
					custName.visible = false;
					confirm1.visible = true;
				}
				
				student[index].visible = true;
				rightbutton.visible = true;
				nameField.text = student[index].getName();
				classYear.text = student[index].getClass();
				instField.text = student[index].getInstrument();
				custName.text = student[index].getName();
				
				if (student[index].getClass() == Classes.FRESHMAN)
				{
					leftbutton1.visible = false;
					rightbutton1.visible = true;
				}
				else if (student[index].getClass() == Classes.SENIOR)
				{
					rightbutton1.visible = false;
					leftbutton1.visible = true;
				}
				else {
					leftbutton1.visible = true;
					rightbutton1.visible = true;
				}
				
				if (student[index].getInstrument() == Instruments.INSTRUMENT[0])
				{
					leftbutton2.visible = false;
					rightbutton2.visible = true;
				}
				else if (student[index].getInstrument() == Instruments.INSTRUMENT[Instruments.INSTRUMENT.length - 1])
				{
					leftbutton2.visible = true;
					rightbutton2.visible = false;
				}
				else {
					leftbutton2.visible = true;
					rightbutton2.visible = true;
				}
			}
			if (index == 0)
			{
				leftbutton.visible = false;
			}
		}
		
		private function nextClass():void
		{
			if (student[index].getClass() == Classes.FRESHMAN) 
			{
				student[index].setClass(Classes.SOPHMORE);
				leftbutton1.visible = true;
			}
			else if (student[index].getClass() == Classes.SOPHMORE)
			{
				student[index].setClass(Classes.JUNIOR);
			}
			else if (student[index].getClass() == Classes.JUNIOR)
			{
				student[index].setClass(Classes.SENIOR);
				rightbutton1.visible = false;
			}
			classYear.text = student[index].getClass();
		}
		
		private function prevClass():void
		{
			if (student[index].getClass() == Classes.SOPHMORE)
			{
				student[index].setClass(Classes.FRESHMAN);
				leftbutton1.visible = false;
			}
			else if (student[index].getClass() == Classes.JUNIOR)
			{
				student[index].setClass(Classes.SOPHMORE);
			}
			else if (student[index].getClass() == Classes.SENIOR)
			{
				student[index].setClass(Classes.JUNIOR);
				rightbutton1.visible = true;
			}
			classYear.text = student[index].getClass();
		}
		
		private function nextInstrument():void
		{
			var temp:int = -1;
			leftbutton2.visible = true;
			
			for (var i:uint = 0; i < Instruments.INSTRUMENT.length; i++)
			{
				if (student[index].getInstrument() == Instruments.INSTRUMENT[i])
				{
					temp = i;
					break;
				}
			}
			
			if (temp == (Instruments.INSTRUMENT.length - 2))
			{
				rightbutton2.visible = false;
			}
			else
			{
				rightbutton2.visible = true;
			}
			
			if ((temp != (Instruments.INSTRUMENT.length - 1)) && (temp != -1))
			{
				student[index].setInstrument(Instruments.INSTRUMENT[temp + 1]);
			}
			instField.text = student[index].getInstrument();
		}
		
		private function prevInstrument():void
		{
			var temp:int = -1;
			rightbutton2.visible = true;
			
			for (var i:uint = 0; i < Instruments.INSTRUMENT.length; i++)
			{
				if (student[index].getInstrument() == Instruments.INSTRUMENT[i])
				{
					temp = i;
					break;
				}
			}
			
			if (temp == 1)
			{
				leftbutton2.visible = false;
			}
			else
			{
				leftbutton2.visible = true;
			}
			
			if (temp > 0)
			{
				student[index].setInstrument(Instruments.INSTRUMENT[temp - 1]);
			}
			instField.text = student[index].getInstrument();
		}
		
		public function startGame():void
		{
			for (var i:uint = 0; i < student.length; i++)
			{
				PrePlayState.studentList.push(student[i]);
			}
			GlobalData.initSchools();
			FlxG.state = new PrePlayState();
		}
		
		private function confirmName():void
		{
			student[index].setName(nameField.getText());
			nameField.visible = false;
			custName.text = student[index].getName();
			custName.visible = true;
			confirm1.visible = false;
		}
	}

}