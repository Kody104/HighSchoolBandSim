package com.misc 
{
	import flash.events.Event;
	import flash.text.TextFieldType;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Kody104
	 */
	
	public class FlxInputText extends FlxText
	{
		public function FlxInputText(X:Number, Y:Number, Width:uint, Text:String=null, EmbeddedFont:Boolean=false, Color:uint=0x000000) 
		{
			super(X, Y, Width, Text, EmbeddedFont);
			_tf.selectable = true;
			_tf.type = TextFieldType.INPUT;
			_tf.textColor = Color;
			_tf.background = true;
			_tf.backgroundColor = (~Color) & 0xffffff;
			_tf.border = true;
			_tf.borderColor = Color;
			_tf.visible = true;
			
			
			_tf.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_tf.addEventListener(Event.REMOVED_FROM_STAGE, onInputFieldRemoved);
			_tf.addEventListener(Event.CHANGE, onTextChange);
			FlxG.state.addChild(_tf);
		}
		
		private var nextFrameHide:Boolean = false;
		
		override public function render():void
		{
			_tf.x = x;
			_tf.y = y;
			_tf.visible = true;
			nextFrameHide = false;
		}
		
		private function onInputFieldRemoved(event:Event):void
		{
			_tf.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_tf.removeEventListener(Event.REMOVED, onInputFieldRemoved);
			_tf.removeEventListener(Event.CHANGE, onTextChange);
		}
		
		private function onEnterFrame(event:Event):void
		{
			if (nextFrameHide)
			{
				_tf.visible = false;
			}
			nextFrameHide = true;
		}
		
		private function onTextChange(event:Event):void
		{
			
		}
		
		public function getText():String
		{
			return _tf.text;
		}
		
	}

}