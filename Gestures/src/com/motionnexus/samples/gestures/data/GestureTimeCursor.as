package com.motionnexus.samples.gestures.data
{
	import com.motionnexus.data.cursor.MotionNexusCursor;
	
	import flash.geom.Point;
	

	public class GestureTimeCursor
	{


		private var _time:Number;
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		private var _trackingId:Number;
		private var _UID:String;
		private var _type:String;
		
		private var _depth:Point;

		public function GestureTimeCursor($cursor:MotionNexusCursor, time:Number):void
		{
			_trackingId = $cursor.trackingId;
			_UID = $cursor.cursorUID;
			_type = $cursor.type;
			_x=$cursor.x;
			_y=$cursor.y;
			_z=$cursor.z;
			_depth = new Point($cursor.depthPosition.x,$cursor.depthPosition.y);
			_time=time;
		}

		public function get time():Number
		{
			return _time;
		}

		public function get x():Number
		{
			return _x;
		}

		public function get y():Number
		{
			return _y;
		}

		public function get z():Number
		{
			return _z;
		}

		public function get depth():Point
		{
			return _depth;
		}

		public function set depth(value:Point):void
		{
			_depth = value;
		}

		public function get trackingId():Number
		{
			return _trackingId;
		}

		public function set trackingId(value:Number):void
		{
			_trackingId = value;
		}

		public function get UID():String
		{
			return _UID;
		}

		public function set UID(value:String):void
		{
			_UID = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}


	}
}
