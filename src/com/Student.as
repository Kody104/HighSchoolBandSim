package com
{
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	import com.Enum.*;
	
	/**
	 * ...
	 * @author Kody104
	 */
	
	public class Student extends FlxSprite
	{
		public var hasCustom:Boolean = false;
		private var isMoving:Boolean = false;
		private var moveDir:String = "DOWN";
		private var move_dis:uint = 0;
		private var mapIndex:uint = 0;
		private var map:Array = new Array();
		private var name:String;
		private var sYear:String;
		private var instrument:String;
		
		private var showMoves:Array = new Array();
		
		private var marchSkill:uint;
		private var playSkill:uint;
		private var learnSkill:Number;
		
		public function Student(x:uint, y:uint, image:Class, map:FlxTilemap, isMale:Boolean) 
		{
			this.map[0] = map;
			this.x = (x * 32);
			this.y = (y * 32);
			
			loadGraphic(image, true, false, 16, 16);
			
			addAnimation("DOWN_IDLE", [0]);
			addAnimation("UP_IDLE", [3]);
			addAnimation("LEFT_IDLE", [6]);
			addAnimation("RIGHT_IDLE", [9]);
			
			addAnimation("DOWN_WALK", [1, 2], 6);
			addAnimation("UP_WALK", [4, 5], 6);
			addAnimation("LEFT_WALK", [7, 8], 6);
			addAnimation("RIGHT_WALK", [10, 11], 6);
			
			var randomize:Number = Math.round(FlxU.random() * (Names.BOYNAMES.length - 1));
			
			if (isMale)
			{
				name = Names.BOYNAMES[randomize];
			}
			else
			{
				name = Names.GIRLNAMES[randomize];
			}
			
			randomize = Math.round(FlxU.random() * 3);
			
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
			
			randomize = Math.round(FlxU.random() * 8);
			
			instrument = Instruments.INSTRUMENT[randomize];
			
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
		
		private function getNextTile(dir:String):Point
		{
			var next:Point = new Point();
			next.x = x;
			next.y = y;
			
			switch(dir)
			{
				case "DOWN":
					next.y += 32;
					break;
				case "UP":
					next.y -= 32;
					break;
				case "LEFT":
					next.x -= 32;
					break;
				case "RIGHT":
					next.x += 32;
					break;
			}
			return next;
		}
		
		private function checkWall(dir:String):Boolean
		{
			switch(mapIndex)
			{
				case 1:
					if (map[mapIndex].getTile(getNextTile(dir).x / 32, getNextTile(dir).y / 32) > 7)
					{
						return true;
					}
					return false;
					break;
				case 2:
					return true;
					break;
				case 3:
					return true;
					break;
			}
			
			return false;
		}
		
		private function checkStudent(dir:String):Boolean
		{
			switch(mapIndex)
			{
				case 1:
					for (var i:uint = 0; i < PrePlayState.studentList.length; i++)
					{
						if (getNextTile(dir).x == PrePlayState.studentList[i].x && 
						getNextTile(dir).y == PrePlayState.studentList[i].y)
						{
							return false;
						}
					}
					return true;
					break;
				case 2:
					return true;
					break;
				case 3:
					return true;
					break;
			}
			
			return false;
		}
		
		public function move(dir:String):void
		{
			if (!isMoving && move_dis <= 0)
			{
				if (checkWall(dir) && checkStudent(dir))
				{
					move_dis = 32;
					isMoving = true;
					moveDir = dir;
					switch(dir)
					{
						case "DOWN":
							play("DOWN_WALK");
							break;
						case "UP":
							play("UP_WALK");
							break;
						case "LEFT":
							play("LEFT_WALK");
							break;
						case "RIGHT":
							play("RIGHT_WALK");
							break;
					}
				}
				else 
				{
					look(dir);
				}
			}
		}
		
		public function look(dir:String):void
		{
			moveDir = dir;
			
			switch(dir)
			{
				case "DOWN":
					play("DOWN_IDLE");
					break;
				case "UP":
					play("UP_IDLE");
					break;
				case "LEFT":
					play("LEFT_IDLE");
					break;
				case "RIGHT":
					play("RIGHT_IDLE");
					break;
			}
		}
		
		public function addShowMove(dir:String, splice:Boolean=false, index:int=-1):void
		{
			if (splice)
			{
				if (index < 0)
				{
					index = showMoves.length;
					switch(dir)
					{
						case "UP":
							showMoves.splice(index, 1, 1);
							break;
						case "DOWN":
							showMoves.splice(index, 1, 2);
							break;
						case "LEFT":
							showMoves.splice(index, 1, 3);
							break;
						case "RIGHT":
							showMoves.splice(index, 1, 4);
							break;
					}
				}
				else
				{
					switch(dir)
					{
						case "UP":
							showMoves.splice(index, 1, 1);
							break;
						case "DOWN":
							showMoves.splice(index, 1, 2);
							break;
						case "LEFT":
							showMoves.splice(index, 1, 3);
							break;
						case "RIGHT":
							showMoves.splice(index, 1, 4);
							break;
					}
				}
			}
			else {
				switch(dir)
				{
					case "UP":
						showMoves.push(1);
						break;
					case "DOWN":
						showMoves.push(2);
						break;
					case "LEFT":
						showMoves.push(3);
						break;
					case "RIGHT":
						showMoves.push(4);
						break;
				}
			}
		}
		
		public function getShowMove(index:uint):uint
		{
			return showMoves[index];
		}
		
		public function getShowMoves():Array
		{
			return showMoves;
		}
		
		public function tele(x:uint, y:uint):void
		{
			this.x = (x * 32);
			this.y = (y * 32);
		}
		
		public function setMap(index:uint, map:FlxTilemap):void
		{
			mapIndex = index;
			this.map[mapIndex] = map;
		}
		
		public function getName():String
		{
			return name;
		}
		
		public function setName(Name:String):void
		{
			name = Name;
			hasCustom = true;
		}
		
		public function getClass():String
		{
			return sYear;
		}
		
		public function setClass(sYear:String):void
		{
			this.sYear = sYear;
		}
		
		public function getInstrument():String
		{
			return instrument;
		}
		
		public function setInstrument(instrument:String):void
		{
			this.instrument = instrument;
		}
		
		public function getMarchSkill():uint
		{
			return marchSkill;
		}
		
		public function trainMarchSkill():void
		{
			var basePlay:uint = Math.round((FlxU.random() * 4) + 1);
			var newPlay:uint = Math.round(basePlay * learnSkill);
			this.marchSkill += newPlay;
			if (this.marchSkill > 100)
			{
				this.marchSkill = 100;
			}
		}
		
		public function getPlaySkill():uint
		{
			return playSkill;
		}
		
		public function trainPlaySkill():void
		{
			var basePlay:uint = Math.round((FlxU.random() * 4) + 1);
			var newPlay:uint = Math.round(basePlay * learnSkill);
			this.playSkill += newPlay;
			if (this.playSkill > 100)
			{
				this.playSkill = 100;
			}
		}
		
		public function getLearnSkill():uint
		{
			return learnSkill;
		}
		
		public function getIsMoving():Boolean
		{
			return isMoving;
		}
		
		public function resetWalk():void
		{
			isMoving = false;
			var moveBack:uint = 32 - move_dis;
			switch(moveDir)
			{
				case "DOWN":
					tele(this.x, this.y - moveBack);
					break;
				case "UP":
					tele(this.x, this.y + moveBack);
					break;
				case "LEFT":
					tele(this.x - moveBack, this.y);
					break;
				case "RIGHT":
					tele(this.x + moveBack, this.y);
					break;
			}
			moveDir = "DOWN";
			move_dis = 0;
		}
		override public function update():void
		{
			if (!isMoving)
			{
				look(moveDir);
			}
			else 
			{
				if (move_dis > 0)
				{
					move_dis--;
					switch(moveDir)
					{
						case "DOWN":
							this.y++;
							break;
						case "UP":
							this.y--;
							break;
						case "LEFT":
							this.x--;
							break;
						case "RIGHT":
							this.x++;
							break;
					}
				}
				else
				{
					isMoving = false;
				}
			}
			super.update();
		}
	}

}