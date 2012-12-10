package com.motionnexus.avateering
{
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	import flare.modifiers.SkinModifier;

	public class AvatarRigged
	{
		private var _skeletonMesh:Mesh3D
		private var _joints:Vector.<Pivot3D>;

		public static const LEFT_SHOULDER:String='leftShoulder';
		public static const RIGHT_SHOULDER:String='rightShoulder';
		public static const LEFT_ELBOW:String='leftElbow';
		public static const RIGHT_ELBOW:String='rightElbow';
		public static const LEFT_ARM:String='leftArm';
		public static const RIGHT_ARM:String='rightArm';
		public static const LEFT_HAND:String='leftHand';
		public static const RIGHT_HAND:String='rightHand';
		public static const SPINE:String='spine';
		public static const HEAD:String='head';
		public static const LEFT_HIP:String='leftHip';
		public static const RIGHT_HIP:String='rightHip';
		public static const LEFT_KNEE:String='leftKnee';
		public static const RIGHT_KNEE:String='rightKnee';
		public static const LEFT_FOOT:String='leftFoot';
		public static const RIGHT_FOOT:String='rightFoot';

		public function AvatarRigged(skeletonMesh:Mesh3D, resetJointFrames:Boolean=true)
		{
			_skeletonMesh=skeletonMesh;
			_joints=(_skeletonMesh.modifier as SkinModifier).bones;
			if (resetJointFrames)
			{
				internalResetJointFrames();
			}
		}

		public function get joints():Vector.<Pivot3D>
		{
			return _joints;
		}

		protected function internalResetJointFrames():void
		{
			for each (var joint:Pivot3D in _joints)
			{
				joint.frames=null;
			}
		}

		public function getJoint(jointID:String):Pivot3D
		{
			var foundJoint:Pivot3D=null;
			for each (var joint:Pivot3D in _joints)
			{
				if (joint.name == jointID)
				{
					foundJoint=joint;
					break;
				}
			}
			return foundJoint;
		}

		// Main skeletal
		public function get hipCenter():Pivot3D
		{
			return null;
		}

		public function get spine():Pivot3D
		{
			return null;
		}

		public function get shoulderCenter():Pivot3D
		{
			return null;
		}

		public function get head():Pivot3D
		{
			return null;
		}

		//Left poSkeletonDataPointDimensions

		public function get leftShoulder():Pivot3D
		{
			return null;
		}

		public function get leftElbow():Pivot3D
		{
			return null;
		}

		public function get leftWrist():Pivot3D
		{
			return null;
		}

		public function get leftHand():Pivot3D
		{
			return null;
		}

		public function get leftHip():Pivot3D
		{
			return null;
		}

		public function get leftKnee():Pivot3D
		{
			return null;
		}

		public function get leftAnkle():Pivot3D
		{
			return null;
		}

		public function get leftFoot():Pivot3D
		{
			return null;
		}

		public function get leftArm():Pivot3D
		{
			return null;
		}

		//right poSkeletonDataPointDimensions
		public function get rightShoulder():Pivot3D
		{
			return null;
		}

		public function get rightElbow():Pivot3D
		{
			return null;
		}

		public function get rightWrist():Pivot3D
		{
			return null;
		}

		public function get rightHand():Pivot3D
		{
			return null;
		}

		public function get rightHip():Pivot3D
		{
			return null;
		}

		public function get rightKnee():Pivot3D
		{
			return null;
		}

		public function get rightAnkle():Pivot3D
		{
			return null;
		}

		public function get rightFoot():Pivot3D
		{
			return null;
		}

		public function get rightArm():Pivot3D
		{
			return null;
		}
	}
}
