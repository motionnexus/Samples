package com.motionnexus.avateering.avatars
{
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	import com.motionnexus.avateering.AvatarRigged;

	public class JustinSkeleton extends AvatarRigged
	{
		public static const SKELETON_UID:String='Toon_Geo';


		[Embed(source='com/motionnexus/avateering/avatars/Justin.dae', mimeType='application/octet-stream')]
		public static var DAEFile:Class;

		public function JustinSkeleton(skeletonMesh:Mesh3D)
		{
			super(skeletonMesh);
		}

		// Main skeletal
		override public function get hipCenter():Pivot3D
		{
			return getJoint('Justin_Hips');
		}

		override public function get spine():Pivot3D
		{
			return getJoint('Justin_Spine');
		}

		public function get spine1():Pivot3D
		{
			return getJoint('Justin_Spine1');
		}

		public function get spine2():Pivot3D
		{
			return getJoint('Justin_Spine2');
		}

		override public function get shoulderCenter():Pivot3D
		{
			return getJoint('Justin_Neck');
		}

		override public function get head():Pivot3D
		{
			return getJoint('Justin_Head');
		}

		//Left poSkeletonDataPointDimensions

		override public function get leftShoulder():Pivot3D
		{
			return getJoint('Justin_LeftShoulder');
		}

		override public function get leftElbow():Pivot3D
		{

			return getJoint('Justin_LeftForeArm');
		}

		override public function get leftArm():Pivot3D
		{
			return getJoint('Justin_LeftArm');
		}

		override public function get leftWrist():Pivot3D
		{
			return getJoint('Justin_LeftHand');
		}

		override public function get leftHand():Pivot3D
		{
			return getJoint('Justin_LeftHand');
		}

		override public function get leftHip():Pivot3D
		{
			return getJoint('Justin_LeftUpLeg');
		}

		override public function get leftKnee():Pivot3D
		{
			return getJoint('Justin_LeftLeg');
		}

		override public function get leftAnkle():Pivot3D
		{
			return getJoint('Justin_LeftFoot');
		}

		override public function get leftFoot():Pivot3D
		{
			return getJoint('Justin_LeftFoot');
		}

		//right poSkeletonDataPointDimensions
		override public function get rightShoulder():Pivot3D
		{
			return getJoint('Justin_RightShoulder');
		}

		override public function get rightElbow():Pivot3D
		{
			//Justin_RightForeArm
			return getJoint('Justin_RightForeArm');
		}

		override public function get rightArm():Pivot3D
		{
			return getJoint('Justin_RightArm');
		}

		override public function get rightWrist():Pivot3D
		{
			return getJoint('Justin_RightHand');
		}

		override public function get rightHand():Pivot3D
		{
			return getJoint('Justin_RightHand');
		}

		override public function get rightHip():Pivot3D
		{
			return getJoint('Justin_RightUpLeg');
		}

		override public function get rightKnee():Pivot3D
		{
			return getJoint('Justin_RightLeg');
		}

		override public function get rightAnkle():Pivot3D
		{
			return getJoint('Justin_RightFoot');
		}

		override public function get rightFoot():Pivot3D
		{
			return getJoint('Justin_RightFoot');
		}
	}
}
