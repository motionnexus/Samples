package skeleton
{


	import com.motionnexus.plugin.data.skeleton.MotionNexusSkeleton;
	import com.motionnexus.plugin.data.skeleton.MotionNexusSkeletonJoint;
	import com.motionnexus.plugin.infastructure.IMotionNexusListener;
	import com.motionnexus.plugin.infastructure.IMotionNexusListenerSkeleton;
	import com.motionnexus.plugin.managers.MotionNexusDispatcher;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;

	import mx.core.UIComponent;
	import mx.events.ResizeEvent;

	import spark.core.SpriteVisualElement;

	/**
	 * Manages the visual world of the skeleton with Flare 3D
	 *
	 */
	public class SkeletonWorld extends SpriteVisualElement implements IMotionNexusListenerSkeleton
	{

		private var _skeletons:Shape;
		private var _joints:Vector.<Sprite>;


		////////////////////// 
		//
		// Constructor and initialization
		//
		/////////////////////

		public function SkeletonWorld():void
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		public function onAddedToStage(event:Event):void
		{
			MotionNexusDispatcher.addListener(this);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			_skeletons=addChild(new Shape()) as Shape;
			_joints=new Vector.<Sprite>;
			while (_joints.length < MotionNexusSkeleton.JOINT_COUNT)
			{
				var circle:Sprite=new Sprite();
				circle.graphics.beginFill(0xff0000);
				circle.graphics.drawCircle(0, 0, 10);
				circle.graphics.endFill();
				addChild(circle);
				circle.visible=false;
				_joints.push(circle);
			}
		}


		////////////////////// 
		//
		// Interface functions for skeleton data
		//
		/////////////////////


		public function updateSkeleton($skeleton:MotionNexusSkeleton):void
		{
			_skeletons.graphics.clear();
			_skeletons.graphics.lineStyle(2, 0xff0000, 1);
			drawSkeleton($skeleton, _skeletons.graphics);

			var joint:MotionNexusSkeletonJoint;
			var circle:Sprite;
			var jointtranslated:Point;

			for (var i:int=0; i < MotionNexusSkeleton.JOINT_COUNT; i++)
			{
				joint=$skeleton.joints[i];
				circle=_joints[i];
				if (joint != null)
				{
					jointtranslated=joint.scaleToScreen(this.width, this.height);
					//circle
					circle.x=jointtranslated.x;
					circle.y=jointtranslated.y;
					circle.visible=true;
				}
				else
				{
					circle.visible=false;
				}
			}

		}

		public function drawSkeleton(user:MotionNexusSkeleton, target:Graphics):void
		{
			if (user.seated == true)
			{
				moveTo(user.head, target);
				lineTo(user.shoulderCenter, target);

				moveTo(user.shoulderCenter, target);
				lineTo(user.leftShoulder, target);
				lineTo(user.leftElbow, target);
				lineTo(user.leftWrist, target);
				lineTo(user.leftHand, target);

				moveTo(user.shoulderCenter, target);
				lineTo(user.rightShoulder, target);
				lineTo(user.rightElbow, target);
				lineTo(user.rightWrist, target);
				lineTo(user.rightHand, target);

			}
			else
			{
				moveTo(user.head, target);
				lineTo(user.shoulderCenter, target);
				lineTo(user.spine, target);
				lineTo(user.hipCenter, target);
				lineTo(user.leftHip, target);
				lineTo(user.leftKnee, target);
				lineTo(user.leftAnkle, target);
				lineTo(user.leftFoot, target);

				moveTo(user.spine, target);
				lineTo(user.hipCenter, target);
				lineTo(user.rightHip, target);
				lineTo(user.rightKnee, target);
				lineTo(user.rightAnkle, target);
				lineTo(user.rightFoot, target);

				moveTo(user.shoulderCenter, target);
				lineTo(user.leftShoulder, target);
				lineTo(user.leftElbow, target);
				lineTo(user.leftWrist, target);
				lineTo(user.leftHand, target);

				moveTo(user.shoulderCenter, target);
				lineTo(user.rightShoulder, target);
				lineTo(user.rightElbow, target);
				lineTo(user.rightWrist, target);
				lineTo(user.rightHand, target);
			}
		}

		private function moveTo(joint:MotionNexusSkeletonJoint, target:Graphics):void
		{
			var translatedJoint:Point=joint.scaleToScreen(this.width, this.height);
			target.moveTo(translatedJoint.x, translatedJoint.y);
		}

		private function lineTo(joint:MotionNexusSkeletonJoint, target:Graphics):void
		{
			var translatedJoint:Point=joint.scaleToScreen(this.width, this.height);
			target.lineTo(translatedJoint.x, translatedJoint.y);
		}

		public function addSkeleton($skeleton:MotionNexusSkeleton):void
		{

		}

		public function removeSkeleton($skeleton:MotionNexusSkeleton):void
		{
		}
	}
}


