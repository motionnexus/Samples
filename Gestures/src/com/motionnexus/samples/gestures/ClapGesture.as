package com.motionnexus.samples.gestures
{
	import com.motionnexus.infastructure.IMotionNexusSkeleton;
	import com.motionnexus.samples.gestures.processors.GestureProcessor;
	import com.motionnexus.utilities.MotionNexusConversions;
	
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;

	[Event(name="clap", type="flash.events.Event")]
	/**
	 *
	 * @author Justin
	 *
	 */

	public class ClapGesture extends GestureProcessor
	{

		public static const CLAP_EVENT:String='clap';

		private static const MAX_HEIGHT_PIXELS:Number=20;
		private static const MIMIMUM_DISTANCE_PIXELS:Number=15;
		private static const MINIMUM_VELOCITY_PIXELS:Number=5;
		
		private var _timeBetweenGestures:Number=1000;
		private var _lastGesture:Number=0;

		override public function testGesture(skeleton:IMotionNexusSkeleton):void
		{
			var timeSinceLastGesture:Number=getTimer() - _lastGesture;
			if (timeSinceLastGesture < _timeBetweenGestures)
			{
				return;
			}
			
			var distanceX:Number=Math.abs(skeleton.leftHand.depth.x - skeleton.rightHand.depth.y);
			var distanceY:Number=Math.abs(skeleton.leftHand.depth.x - skeleton.rightHand.depth.y);
			var velocityLeft:Number = Math.abs(skeleton.leftHand.depth.x - getPreviousSkeleton(skeleton.trackingId).skeleton.leftHand.depth.x)/2;
			var velocityRight:Number = Math.abs(skeleton.rightHand.depth.x - getPreviousSkeleton(skeleton.trackingId).skeleton.rightHand.depth.x)/2;
			var avgVelocity:Number = (velocityLeft + velocityRight)/2;
			
			if(distanceY<MAX_HEIGHT_PIXELS){
				if(distanceX < MIMIMUM_DISTANCE_PIXELS){
					if(distanceX > avgVelocity){
						dispatchEvent(new Event(CLAP_EVENT));
						_lastGesture=getTimer();
					}
				}
			}
		}
	}
}
