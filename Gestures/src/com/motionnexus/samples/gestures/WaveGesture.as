package com.motionnexus.samples.gestures
{
	

	
	import com.motionnexus.data.cursor.MotionNexusCursor;
	import com.motionnexus.samples.gestures.processors.GestureProcessor;
	import com.motionnexus.samples.gestures.data.GestureTimeCursor;
	import com.motionnexus.samples.gestures.data.GestureTimeSkeleton;
	
	import flash.events.Event;
	import flash.utils.getTimer;
	import com.motionnexus.samples.gestures.processors.GestureProcessor;
	
	[Event(name="waveGesture", type="flash.events.Event")]

	public class WaveGesture extends GestureProcessor
	{

		private var _swipeMinimalLength:Number=35;
		private var _swipeMaximalHeight:Number=20;
		private var _swipeMaximalDuration:Number=200;
		private var _timeBetweenGestures:Number=3000;
		private var _lastGesture:Number=0;
		private var _currentCount:Number=0;
		private var _lastDirection:String=DIRECTION_RIGHT;
		private static const MAX_COUNT:Number=4;
		public static const WAVE_GESTURE:String='waveGesture';
		private static const DIRECTION_RIGHT:String='right';
		private static const DIRECTION_LEFT:String='left';


		override public function updateCursor($cursor:MotionNexusCursor):void
		{
			super.updateCursor($cursor);
			var history:Vector.<GestureTimeCursor>=getCursorHistory($cursor.trackingId, $cursor.type);
			var currentCursor:GestureTimeCursor=getCurrentCursor($cursor.trackingId, $cursor.type);
			if (currentCursor == null)
			{
				return;
			}
			for each (var cursorEntry:GestureTimeCursor in history)
			{
				if (cursorEntry && cursorEntry.time != currentCursor.time)
				{
					if (testWaveGesture(currentCursor, cursorEntry) == true)
					{
						deleteCursorHistory($cursor.trackingId, $cursor.type);
						break;
					}
				}
			}
		}

		/**
		 *
		 * @param currentCursor
		 * @param previousCursor
		 * @return
		 */
		protected function testWaveGesture(currentCursor:GestureTimeCursor, previousCursor:GestureTimeCursor):Boolean
		{
			if (currentCursor == null || previousCursor == null)
			{
				return false;
			}
			var cursorDepth:Number;
			var skeleton:GestureTimeSkeleton=getCurrentSkeleton(currentCursor.trackingId);
			if (currentCursor.type == MotionNexusCursor.LEFT_HAND)
			{
				if (skeleton.skeleton.leftHand.depth.y > skeleton.skeleton.leftElbow.depth.y)
				{
					return false;
				}
				cursorDepth = skeleton.skeleton.leftHand.z;
			}
			else
			{
				if (skeleton.skeleton.rightHand.depth.y > skeleton.skeleton.rightElbow.depth.y)
				{
					return false;
				}
				cursorDepth = skeleton.skeleton.rightHand.z;
			}
			//Make sure the Y has not moved higher than maximal
			var diffY:Number=Math.abs((currentCursor.depth.y - previousCursor.depth.y)*cursorDepth);
			if ((diffY < _swipeMaximalHeight) == true)
			{

				//Validate length of movement
				var diffX:Number=Math.abs((currentCursor.depth.x - previousCursor.depth.x)*cursorDepth);
				if ((diffX > _swipeMinimalLength) == true)
				{

					var totalMilliseconds:Number=currentCursor.time - previousCursor.time;
					if (totalMilliseconds <= _swipeMaximalDuration && totalMilliseconds <= _swipeMaximalDuration)
					{
						var timeSinceLastGesture:Number=getTimer() - _lastGesture;
						if (timeSinceLastGesture > _timeBetweenGestures)
						{
							_currentCount=0;
							_lastGesture=getTimer();
							return false;
						}
						var currentDirection:String=getDirection(currentCursor, previousCursor);
						if (currentDirection != _lastDirection)
						{
							_lastGesture=getTimer();
							_currentCount=_currentCount + 1;
							_lastDirection=currentDirection;
							if (_currentCount == MAX_COUNT)
							{
								dispatchEvent(new Event(WAVE_GESTURE));
								_currentCount=0;
							}
							return true;
						}
					}

				}
			}
			return false;
		}

		protected function getDirection(currentCursor:GestureTimeCursor, previousCursor:GestureTimeCursor):String
		{
			if (currentCursor.type == MotionNexusCursor.LEFT_HAND)
			{
				if (currentCursor.depth.x > previousCursor.depth.x)
				{
					return DIRECTION_LEFT;
				}
				else
				{
					return DIRECTION_RIGHT;
				}
			}
			else
			{
				if (currentCursor.depth.x < previousCursor.depth.x)
				{
					return DIRECTION_LEFT;
				}
				else
				{
					return DIRECTION_RIGHT;
				}
			}
			return '';
		}


		public function get timeBetweenGestures():Number
		{
			return _timeBetweenGestures;
		}

		public function set timeBetweenGestures(value:Number):void
		{
			_timeBetweenGestures=value;
		}
	}
}
