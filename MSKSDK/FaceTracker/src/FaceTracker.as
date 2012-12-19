package
{
	import com.bit101.components.PushButton;
	import com.motionnexus.events.MotionNexusPluginStatusEvent;
	import com.motionnexus.events.MotionNexusSkeletonsUpdatedEvent;
	import com.motionnexus.infastructure.IMotionNexusSkeletonJoint;
	import com.motionnexus.msksdk.MotionNexus;
	import com.motionnexus.msksdk.data.settings.MotionNexusSettings;
	import com.motionnexus.msksdk.data.skeleton.MotionNexusSkeleton;
	import com.motionnexus.msksdk.data.skeleton.MotionNexusSkeletonJoint;
	import com.motionnexus.msksdk.events.MotionNexusFaceTrackingEvent;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[SWF(frameRate="60", width="640", height="480", backgroundColor="#000000")]
	public class FaceTracker extends Sprite
	{
		private var _startButton:PushButton;
		private var _skeletons:Shape;
		private var _joints:Vector.<Sprite>;

		public function FaceTracker()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			super();
		}

		public function onAddedToStage(event:Event):void
		{
			//Check the status of the Plugin to see if it is installed or not
			MotionNexus.addListener(MotionNexusPluginStatusEvent.PLUGIN_INSTALLED, onPluginStatus);
		}

		/**
		 * Once we know the plugin is or is not installed we can help identify to the user what is the next steps
		 */
		protected function onPluginStatus(event:MotionNexusPluginStatusEvent):void
		{
			if (event.description == 'true')
			{
				//Create button to launch plugin        
				_startButton=new PushButton(this, 0, 0, 'Lets GO!', onStart);
				this.addChild(_startButton);
				_startButton.x=(640 / 2) - (_startButton.width / 2);
				_startButton.y=(480 / 2) - (_startButton.height / 2);

				var settings:MotionNexusSettings = new MotionNexusSettings();
				settings.skeletonTrackingEnabled = true;
				settings.nearModeEnabled=true;
				settings.faceTrackingEnabled=true;
				//Retrieve information from plugin locally for a non collaborative environment  
				MotionNexus.pluginSettings=settings;

				//Used when face model information is updated   
				MotionNexus.addListener(MotionNexusFaceTrackingEvent.FACE_MODEL_AVAILABLE, onFaceModelUpdated);

				//Used when skeleton information is updated   
				MotionNexus.addListener(MotionNexusSkeletonsUpdatedEvent.SKELETONS_UPDATED, updateSkeleton);

				//Create initial joints and shape for skeleton
				_skeletons=addChild(new Shape()) as Shape;
				_joints=new Vector.<Sprite>;
				while (_joints.length < MotionNexusSkeleton.JOINT_COUNT)
				{
					var circle:Sprite=new Sprite();
					circle.graphics.beginFill(0xFFFFFF);
					circle.graphics.drawCircle(0, 0, 5);
					circle.graphics.endFill();
					addChild(circle);
					circle.visible=false;
					_joints.push(circle);
				}
			}
		}

		/**
		 * Face Model has been updated, so render as graphics
		 */
		protected function onFaceModelUpdated(event:MotionNexusFaceTrackingEvent):void
		{
			//faceModel.updateFaceModel(event.facemodel);
			graphics.clear();
			graphics.lineStyle(1, 0xFFFFFF);
			//Left eye brow
			graphics.moveTo(event.facemodel.leftEyeBrowPoints[0].x, event.facemodel.leftEyeBrowPoints[0].y);
			graphics.lineTo(event.facemodel.leftEyeBrowPoints[1].x, event.facemodel.leftEyeBrowPoints[1].y);
			graphics.lineTo(event.facemodel.leftEyeBrowPoints[2].x, event.facemodel.leftEyeBrowPoints[2].y);
			graphics.lineTo(event.facemodel.leftEyeBrowPoints[3].x, event.facemodel.leftEyeBrowPoints[3].y);
			graphics.lineTo(event.facemodel.leftEyeBrowPoints[4].x, event.facemodel.leftEyeBrowPoints[4].y);
			graphics.lineTo(event.facemodel.leftEyeBrowPoints[5].x, event.facemodel.leftEyeBrowPoints[5].y);
			graphics.lineTo(event.facemodel.leftEyeBrowPoints[6].x, event.facemodel.leftEyeBrowPoints[6].y);
			graphics.lineTo(event.facemodel.leftEyeBrowPoints[7].x, event.facemodel.leftEyeBrowPoints[7].y);
			graphics.lineTo(event.facemodel.leftEyeBrowPoints[8].x, event.facemodel.leftEyeBrowPoints[8].y);
			graphics.lineTo(event.facemodel.leftEyeBrowPoints[9].x, event.facemodel.leftEyeBrowPoints[9].y);
			graphics.lineTo(event.facemodel.leftEyeBrowPoints[0].x, event.facemodel.leftEyeBrowPoints[0].y);
			//right eyebrow
			graphics.moveTo(event.facemodel.rightEyeBrowPoints[0].x, event.facemodel.rightEyeBrowPoints[0].y);
			graphics.moveTo(event.facemodel.rightEyeBrowPoints[0].x, event.facemodel.rightEyeBrowPoints[0].y);
			graphics.lineTo(event.facemodel.rightEyeBrowPoints[1].x, event.facemodel.rightEyeBrowPoints[1].y);
			graphics.lineTo(event.facemodel.rightEyeBrowPoints[2].x, event.facemodel.rightEyeBrowPoints[2].y);
			graphics.lineTo(event.facemodel.rightEyeBrowPoints[3].x, event.facemodel.rightEyeBrowPoints[3].y);
			graphics.lineTo(event.facemodel.rightEyeBrowPoints[4].x, event.facemodel.rightEyeBrowPoints[4].y);
			graphics.lineTo(event.facemodel.rightEyeBrowPoints[5].x, event.facemodel.rightEyeBrowPoints[5].y);
			graphics.lineTo(event.facemodel.rightEyeBrowPoints[6].x, event.facemodel.rightEyeBrowPoints[6].y);
			graphics.lineTo(event.facemodel.rightEyeBrowPoints[7].x, event.facemodel.rightEyeBrowPoints[7].y);
			graphics.lineTo(event.facemodel.rightEyeBrowPoints[8].x, event.facemodel.rightEyeBrowPoints[8].y);
			graphics.lineTo(event.facemodel.rightEyeBrowPoints[9].x, event.facemodel.rightEyeBrowPoints[9].y);
			graphics.lineTo(event.facemodel.rightEyeBrowPoints[0].x, event.facemodel.rightEyeBrowPoints[0].y);
			//left eye
			graphics.moveTo(event.facemodel.leftEyePoints[0].x, event.facemodel.leftEyePoints[0].y);
			graphics.lineTo(event.facemodel.leftEyePoints[1].x, event.facemodel.leftEyePoints[1].y);
			graphics.lineTo(event.facemodel.leftEyePoints[2].x, event.facemodel.leftEyePoints[2].y);
			graphics.lineTo(event.facemodel.leftEyePoints[3].x, event.facemodel.leftEyePoints[3].y);
			graphics.lineTo(event.facemodel.leftEyePoints[4].x, event.facemodel.leftEyePoints[4].y);
			graphics.lineTo(event.facemodel.leftEyePoints[5].x, event.facemodel.leftEyePoints[5].y);
			graphics.lineTo(event.facemodel.leftEyePoints[6].x, event.facemodel.leftEyePoints[6].y);
			graphics.lineTo(event.facemodel.leftEyePoints[7].x, event.facemodel.leftEyePoints[7].y);
			graphics.lineTo(event.facemodel.leftEyePoints[0].x, event.facemodel.leftEyePoints[0].y);
			//right eye
			graphics.moveTo(event.facemodel.rightEyePoints[0].x, event.facemodel.rightEyePoints[0].y);
			graphics.lineTo(event.facemodel.rightEyePoints[1].x, event.facemodel.rightEyePoints[1].y);
			graphics.lineTo(event.facemodel.rightEyePoints[2].x, event.facemodel.rightEyePoints[2].y);
			graphics.lineTo(event.facemodel.rightEyePoints[3].x, event.facemodel.rightEyePoints[3].y);
			graphics.lineTo(event.facemodel.rightEyePoints[4].x, event.facemodel.rightEyePoints[4].y);
			graphics.lineTo(event.facemodel.rightEyePoints[5].x, event.facemodel.rightEyePoints[5].y);
			graphics.lineTo(event.facemodel.rightEyePoints[6].x, event.facemodel.rightEyePoints[6].y);
			graphics.lineTo(event.facemodel.rightEyePoints[7].x, event.facemodel.rightEyePoints[7].y);
			graphics.lineTo(event.facemodel.rightEyePoints[0].x, event.facemodel.rightEyePoints[0].y);
			//nose
			graphics.moveTo(event.facemodel.nosePoints[0].x, event.facemodel.nosePoints[0].y);
			graphics.lineTo(event.facemodel.nosePoints[1].x, event.facemodel.nosePoints[1].y);
			graphics.lineTo(event.facemodel.nosePoints[2].x, event.facemodel.nosePoints[2].y);
			graphics.lineTo(event.facemodel.nosePoints[3].x, event.facemodel.nosePoints[3].y);
			graphics.lineTo(event.facemodel.nosePoints[4].x, event.facemodel.nosePoints[4].y);
			graphics.lineTo(event.facemodel.nosePoints[5].x, event.facemodel.nosePoints[5].y);
			graphics.lineTo(event.facemodel.nosePoints[6].x, event.facemodel.nosePoints[6].y);
			graphics.lineTo(event.facemodel.nosePoints[7].x, event.facemodel.nosePoints[7].y);
			graphics.lineTo(event.facemodel.nosePoints[8].x, event.facemodel.nosePoints[8].y);
			graphics.lineTo(event.facemodel.nosePoints[9].x, event.facemodel.nosePoints[9].y);
			graphics.lineTo(event.facemodel.nosePoints[10].x, event.facemodel.nosePoints[10].y);
			graphics.lineTo(event.facemodel.nosePoints[11].x, event.facemodel.nosePoints[11].y);
			//outer lip
			graphics.moveTo(event.facemodel.outerLipPoints[0].x, event.facemodel.outerLipPoints[0].y);
			graphics.lineTo(event.facemodel.outerLipPoints[1].x, event.facemodel.outerLipPoints[1].y);
			graphics.lineTo(event.facemodel.outerLipPoints[2].x, event.facemodel.outerLipPoints[2].y);
			graphics.lineTo(event.facemodel.outerLipPoints[3].x, event.facemodel.outerLipPoints[3].y);
			graphics.lineTo(event.facemodel.outerLipPoints[4].x, event.facemodel.outerLipPoints[4].y);
			graphics.lineTo(event.facemodel.outerLipPoints[5].x, event.facemodel.outerLipPoints[5].y);
			graphics.lineTo(event.facemodel.outerLipPoints[6].x, event.facemodel.outerLipPoints[6].y);
			graphics.lineTo(event.facemodel.outerLipPoints[7].x, event.facemodel.outerLipPoints[7].y);
			graphics.lineTo(event.facemodel.outerLipPoints[8].x, event.facemodel.outerLipPoints[8].y);
			graphics.lineTo(event.facemodel.outerLipPoints[9].x, event.facemodel.outerLipPoints[9].y);
			graphics.lineTo(event.facemodel.outerLipPoints[10].x, event.facemodel.outerLipPoints[10].y);
			graphics.lineTo(event.facemodel.outerLipPoints[11].x, event.facemodel.outerLipPoints[11].y);
			graphics.lineTo(event.facemodel.outerLipPoints[0].x, event.facemodel.outerLipPoints[0].y);
			//inner lip
			graphics.moveTo(event.facemodel.innerLipPoints[0].x, event.facemodel.innerLipPoints[0].y);
			graphics.lineTo(event.facemodel.innerLipPoints[1].x, event.facemodel.innerLipPoints[1].y);
			graphics.lineTo(event.facemodel.innerLipPoints[2].x, event.facemodel.innerLipPoints[2].y);
			graphics.lineTo(event.facemodel.innerLipPoints[3].x, event.facemodel.innerLipPoints[3].y);
			graphics.lineTo(event.facemodel.innerLipPoints[4].x, event.facemodel.innerLipPoints[4].y);
			graphics.lineTo(event.facemodel.innerLipPoints[5].x, event.facemodel.innerLipPoints[5].y);
			graphics.lineTo(event.facemodel.innerLipPoints[6].x, event.facemodel.innerLipPoints[6].y);
			graphics.lineTo(event.facemodel.innerLipPoints[7].x, event.facemodel.innerLipPoints[7].y);
			graphics.lineTo(event.facemodel.innerLipPoints[0].x, event.facemodel.innerLipPoints[0].y);
			//Outer face
			graphics.moveTo(event.facemodel.outerFacePoints[0].x, event.facemodel.outerFacePoints[0].y);
			graphics.lineTo(event.facemodel.outerFacePoints[1].x, event.facemodel.outerFacePoints[1].y);
			graphics.lineTo(event.facemodel.outerFacePoints[2].x, event.facemodel.outerFacePoints[2].y);
			graphics.lineTo(event.facemodel.outerFacePoints[3].x, event.facemodel.outerFacePoints[3].y);
			graphics.lineTo(event.facemodel.outerFacePoints[4].x, event.facemodel.outerFacePoints[4].y);
			graphics.lineTo(event.facemodel.outerFacePoints[5].x, event.facemodel.outerFacePoints[5].y);
			graphics.lineTo(event.facemodel.outerFacePoints[6].x, event.facemodel.outerFacePoints[6].y);
			graphics.lineTo(event.facemodel.outerFacePoints[7].x, event.facemodel.outerFacePoints[7].y);
			graphics.lineTo(event.facemodel.outerFacePoints[8].x, event.facemodel.outerFacePoints[8].y);
			graphics.lineTo(event.facemodel.outerFacePoints[9].x, event.facemodel.outerFacePoints[9].y);
			graphics.lineTo(event.facemodel.outerFacePoints[10].x, event.facemodel.outerFacePoints[10].y);
			graphics.lineTo(event.facemodel.outerFacePoints[11].x, event.facemodel.outerFacePoints[11].y);
			graphics.lineTo(event.facemodel.outerFacePoints[12].x, event.facemodel.outerFacePoints[12].y);
			graphics.lineTo(event.facemodel.outerFacePoints[13].x, event.facemodel.outerFacePoints[13].y);
			graphics.lineTo(event.facemodel.outerFacePoints[14].x, event.facemodel.outerFacePoints[14].y);
			graphics.lineTo(event.facemodel.outerFacePoints[15].x, event.facemodel.outerFacePoints[15].y);
			graphics.lineTo(event.facemodel.outerFacePoints[16].x, event.facemodel.outerFacePoints[16].y);
			graphics.lineTo(event.facemodel.outerFacePoints[17].x, event.facemodel.outerFacePoints[17].y);
			graphics.lineTo(event.facemodel.outerFacePoints[18].x, event.facemodel.outerFacePoints[18].y);

			graphics.beginFill(0xFFFFFF);
			graphics.drawCircle(event.facemodel.centerOfRightEye.x, event.facemodel.centerOfRightEye.y, 2);
			graphics.endFill();

			graphics.beginFill(0xFFFFFF);
			graphics.drawCircle(event.facemodel.centerOfLeftEye.x, event.facemodel.centerOfLeftEye.y, 2);
			graphics.endFill();
		}

		/**
		 * Draw the skeleton every time there is an update
		 * @param $skeleton
		 *
		 */
		public function updateSkeleton($skeleton:MotionNexusSkeletonsUpdatedEvent):void
		{
			//Clear the skeleton lines and call to draw the skeleton
			_skeletons.graphics.clear();
			_skeletons.graphics.lineStyle(2, 0xFFFFFF, 1);
			drawSkeleton($skeleton.mostActiveSkeleton as MotionNexusSkeleton, _skeletons.graphics);

			var joint:MotionNexusSkeletonJoint;
			var circle:Sprite;

			//Draw out all skeleton joints, and if is seated the joint is null so hide the ciricle
			for (var i:int=0; i < MotionNexusSkeleton.JOINT_COUNT; i++)
			{
				joint=$skeleton.mostActiveSkeleton.joints[i];
				circle=_joints[i];
				circle.x=joint.rgb.x;
				circle.y=joint.rgb.y;
				circle.visible=true;
			}

		}

		/**
		 * Darw a skeleton from line to line and if seated draw only 10 points on top
		 * @param user
		 * @param target
		 *
		 */
		public function drawSkeleton(user:MotionNexusSkeleton, target:Graphics):void
		{
			if (user.seated == true)
			{
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
				moveTo(user.shoulderCenter, target);
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

		/**
		 * Utility function to move a line against a target graphic
		 * @param joint
		 * @param target
		 *
		 */
		private function moveTo(joint:IMotionNexusSkeletonJoint, target:Graphics):void
		{
			target.moveTo(joint.depth.x*2, joint.depth.y*2);
		}

		/**
		 * Utility function to draw a line to a new point
		 * @param joint
		 * @param target
		 *
		 */
		private function lineTo(joint:IMotionNexusSkeletonJoint, target:Graphics):void
		{
			target.lineTo(joint.depth.x*2, joint.depth.y*2);
		}

		/**
		 * When the user is ready and clicks go - we will launch the plugin
		 */
		protected function onStart(event:MouseEvent):void
		{
			this.removeChild(_startButton);
			_startButton=null;
			MotionNexus.launchPlugin(event);
		}
	}
}
