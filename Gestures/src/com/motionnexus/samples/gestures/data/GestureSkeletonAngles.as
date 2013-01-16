package com.motionnexus.samples.gestures.data
{

	import com.motionnexus.infastructure.IMotionNexusSkeleton;
	import com.motionnexus.infastructure.IMotionNexusSkeletonJoint;
	
	import flash.geom.Vector3D;

	/**
	 *
	 * @author Justin
	 */
	public class GestureSkeletonAngles 
	{

		private var _jointGroups:Vector.<GestureSkeletonJointAngle>;
		//Joint groupings for angles
		/**
		 *
		 * @default
		 */
		public static const JOINT_GROUP_LEFT_WRIST_ELBOW_SHOULDER:Number=0;

		/**
		 *
		 * @default
		 */
		public static const JOINT_GROUP_RIGHT_WRIST_ELBOW_SHOULDER:Number=1;

		/**
		 *
		 * @default
		 */
		public static const JOINT_GROUP_LEFT_ELBOW_SHOULDER_HIP:Number=2;

		/**
		 *
		 * @default
		 */
		public static const JOINT_GROUP_RIGHT_ELBOW_SHOULDER_HIP:Number=3;

		/**
		 *
		 * @default
		 */
		public static const JOINT_GROUP_LEFT_SHOULDER_HIP_KNEE:Number=4;

		/**
		 *
		 * @default
		 */
		public static const JOINT_GROUP_RIGHT_SHOULDER_HIP_KNEE:Number=5;

		/**
		 *
		 * @default
		 */
		public static const JOINT_GROUP_LEFT_HIP_KNEE_ANKLE:Number=6;

		/**
		 *
		 * @default
		 */
		public static const JOINT_GROUP_RIGHT_HIP_KNEE_ANKLE:Number=7;

		/**
		 *
		 * @default
		 */
		public static const JOINT_GROUP_CENTER_RIGHT_SHOULDER_ELBOW:Number=8;

		/**
		 *
		 * @default
		 */
		public static const JOINT_GROUP_CENTER_LEFT_SHOULDER_ELBOW:Number=9;

		/**
		 *
		 * @param kinectSkeleton
		 */
		public function GestureSkeletonAngles():void
		{
			initilizeAngles();
		}

		/**
		 *
		 *
		 */
		private function initilizeAngles():void
		{
			//joint groups
			_jointGroups=new Vector.<GestureSkeletonJointAngle>(8, true);
			_jointGroups[0]=new GestureSkeletonJointAngle();
			_jointGroups[1]=new GestureSkeletonJointAngle();
			_jointGroups[2]=new GestureSkeletonJointAngle();
			_jointGroups[3]=new GestureSkeletonJointAngle();
			_jointGroups[4]=new GestureSkeletonJointAngle();
			_jointGroups[5]=new GestureSkeletonJointAngle();
			_jointGroups[6]=new GestureSkeletonJointAngle();
			_jointGroups[7]=new GestureSkeletonJointAngle();
		}

		/**
		 *
		 * @param skeleton
		 *
		 */
		public function update($skeleton:IMotionNexusSkeleton):void
		{
			_jointGroups[0].update(translateJointFlat($skeleton.leftHand), translateJointFlat($skeleton.leftElbow), translateJointFlat($skeleton.leftShoulder));
			_jointGroups[1].update(translateJointFlat($skeleton.rightHand), translateJointFlat($skeleton.rightElbow), translateJointFlat($skeleton.rightShoulder));
			_jointGroups[2].update(translateJointFlat($skeleton.leftElbow), translateJointFlat($skeleton.leftShoulder), translateJointFlat($skeleton.leftHip));
			_jointGroups[3].update(translateJointFlat($skeleton.rightElbow), translateJointFlat($skeleton.rightShoulder), translateJointFlat($skeleton.rightHip));
			_jointGroups[4].update(translateJointFlat($skeleton.leftShoulder), translateJointFlat($skeleton.leftHip), translateJointFlat($skeleton.leftKnee));
			_jointGroups[5].update(translateJointFlat($skeleton.rightShoulder), translateJointFlat($skeleton.rightHip), translateJointFlat($skeleton.rightKnee));
			_jointGroups[6].update(translateJointFlat($skeleton.leftHip), translateJointFlat($skeleton.leftKnee), translateJointFlat($skeleton.leftFoot));
			_jointGroups[7].update(translateJointFlat($skeleton.rightHip), translateJointFlat($skeleton.rightKnee), translateJointFlat($skeleton.rightFoot));
		}



		public function translateJointFlat(joint:IMotionNexusSkeletonJoint):IMotionNexusSkeletonJoint
		{
			var transformedJoint:IMotionNexusSkeletonJoint=joint.cloneJoint();
			transformedJoint.y=transformedJoint.y * -1;
			return transformedJoint;
		}

		/**
		 *
		 * @param value
		 * @return
		 */
		public function getJointGroupAngle(value:Number):Number
		{
			if (value > 10)
			{
				return 0
			}
			var jointGroup:GestureSkeletonJointAngle=_jointGroups[value];
			return jointGroup.angle;
		}
	}
}
