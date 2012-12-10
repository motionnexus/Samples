package com.motionnexus.avateering.avatars
{
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	import com.motionnexus.avateering.AvatarRigged;

	public class AlexisSkeleton extends AvatarRigged
	{
		public static const SKELETON_UID:String='Alexis_Geo_High';


		[Embed(source='com/motionnexus/avateering/avatars/Alexis.dae', mimeType='application/octet-stream')]
		public static var DAEFile:Class;

		public function AlexisSkeleton(skeletonMesh:Mesh3D)
		{
			super(skeletonMesh);
		}

		// Main skeletal
		override public function get hipCenter():Pivot3D
		{
			return getJoint('Alexis_Hips');
		}

		override public function get spine():Pivot3D
		{
			return getJoint('Alexis_Spine');
		}

		public function get spine1():Pivot3D
		{
			return getJoint('Alexis_Spine1');
		}

		public function get spine2():Pivot3D
		{
			return getJoint('Alexis_Spine2');
		}

		override public function get shoulderCenter():Pivot3D
		{
			return getJoint('Alexis_Neck');
		}

		override public function get head():Pivot3D
		{
			return getJoint('Alexis_Head');
		}

		override public function get leftShoulder():Pivot3D
		{
			return getJoint('Alexis_LeftShoulder');
		}

		override public function get leftElbow():Pivot3D
		{

			return getJoint('Alexis_LeftForeArm');
		}

		override public function get leftArm():Pivot3D
		{
			return getJoint('Alexis_LeftArm');
		}

		override public function get leftWrist():Pivot3D
		{
			return getJoint('Alexis_LeftHand');
		}

		override public function get leftHand():Pivot3D
		{
			return getJoint('Alexis_LeftHand');
		}

		override public function get leftHip():Pivot3D
		{
			return getJoint('Alexis_LeftUpLeg');
		}

		override public function get leftKnee():Pivot3D
		{
			return getJoint('Alexis_LeftLeg');
		}

		override public function get leftAnkle():Pivot3D
		{
			return getJoint('Alexis_LeftFoot');
		}

		override public function get leftFoot():Pivot3D
		{
			return getJoint('Alexis_LeftFoot');
		}

		override public function get rightShoulder():Pivot3D
		{
			return getJoint('Alexis_RightShoulder');
		}

		override public function get rightElbow():Pivot3D
		{
			return getJoint('Alexis_RightForeArm');
		}

		override public function get rightArm():Pivot3D
		{
			return getJoint('Alexis_RightArm');
		}

		override public function get rightWrist():Pivot3D
		{
			return getJoint('Alexis_RightHand');
		}

		override public function get rightHand():Pivot3D
		{
			return getJoint('Alexis_RightHand');
		}

		override public function get rightHip():Pivot3D
		{
			return getJoint('Alexis_RightUpLeg');
		}

		override public function get rightKnee():Pivot3D
		{
			return getJoint('Alexis_RightLeg');
		}

		override public function get rightAnkle():Pivot3D
		{
			return getJoint('Alexis_RightFoot');
		}

		override public function get rightFoot():Pivot3D
		{
			return getJoint('Alexis_RightFoot');
		}
	}
}
