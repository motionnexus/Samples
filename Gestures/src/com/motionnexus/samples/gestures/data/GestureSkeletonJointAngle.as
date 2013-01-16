package com.motionnexus.samples.gestures.data
{
	import com.motionnexus.infastructure.IMotionNexusSkeletonJoint;
	
	import flash.display.Graphics;
	import flash.geom.Vector3D;

	public class GestureSkeletonJointAngle
	{
		private var _jointA:IMotionNexusSkeletonJoint;
		private var _jointB:IMotionNexusSkeletonJoint;
		private var _jointC:IMotionNexusSkeletonJoint;

		public function update(jointA:IMotionNexusSkeletonJoint, jointB:IMotionNexusSkeletonJoint, jointC:IMotionNexusSkeletonJoint):void
		{
			_jointA=jointA;
			_jointB=jointB;
			_jointC=jointC;
		}

		public function get angle():Number
		{
			// compute Vector 1's components
			var V1dx:Number=_jointA.x - _jointB.x;
			var V1dy:Number=_jointA.y - _jointB.y;
			var V1dz:Number=_jointA.z - _jointB.z;
			var V1m:Number=Math.sqrt(sq(V1dx) + sq(V1dy) + sq(V1dz)); // pythagoras

			// compute Vector 2's components
			var V2dx:Number=_jointC.x - _jointB.x;
			var V2dy:Number=_jointC.y - _jointB.y;
			var V2dz:Number=_jointC.z - _jointB.z;
			var V2m:Number=Math.sqrt(sq(V2dx) + sq(V2dy) + sq(V2dz)); // pythagoras

			// compute the Dot Product
			var V1dV2:Number=V1dx * V2dx + V1dy * V2dy + V1dz * V2dz;
			var thetaD:Number=degrees(Math.acos(V1dV2 / (V1m * V2m)));
			return Math.round(thetaD);
		}

		protected function sq(value:Number):Number
		{
			return value * value;
		}

		protected function degrees(value:Number):Number
		{
			return value * 180 / Math.PI;
		}
	}

}
