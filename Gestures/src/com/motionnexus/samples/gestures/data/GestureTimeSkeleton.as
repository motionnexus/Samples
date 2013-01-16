package com.motionnexus.samples.gestures.data
{
	
	import com.motionnexus.infastructure.IMotionNexusSkeleton;
	
	import flash.utils.getTimer;

	public class GestureTimeSkeleton
	{


		private var _skeleton:IMotionNexusSkeleton;
		private var _time:Number;

		public function GestureTimeSkeleton(skeleton:IMotionNexusSkeleton, time:Number):void
		{
			_skeleton=skeleton;
			_time=time;
		}

		public function get skeleton():IMotionNexusSkeleton
		{
			return _skeleton;
		}

		public function get time():Number
		{
			return _time;
		}

	}
}
