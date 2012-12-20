package
{
	import com.motionnexus.events.MotionNexusCameraEvent;
	import com.motionnexus.events.MotionNexusSkeletonsUpdatedEvent;
	import com.motionnexus.infastructure.IMotionNexusSkeletonJoint;
	import com.motionnexus.msksdk.MotionNexus;
	import com.motionnexus.msksdk.data.settings.MotionNexusSettings;
	import com.motionnexus.msksdk.data.skeleton.MotionNexusSkeleton;
	import com.motionnexus.msksdk.data.skeleton.MotionNexusSkeletonJoint;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Main extends Sprite
	{
		
		private var _depthImage:Bitmap;
		private var _skeletonPlayground:Shape;
		
		public function Main()
		{
			if(this.stage)
			{
				this.stage.align = StageAlign.TOP_LEFT;
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.addEventListener(Event.RESIZE, onResize); 
				stage.nativeWindow.addEventListener(Event.CLOSING, closeApplication, false, 0, true); 
			}
			
			var settings:MotionNexusSettings=new MotionNexusSettings();
			//settings.mirroringEnabled=true;
			settings.depthImageEnabled=true;
			
			//Used when depth image is updated
			MotionNexus.addListener(MotionNexusCameraEvent.IMAGE_UPDATED, onDepthImageUpdated);
			
			//Display skeleton container
			MotionNexus.addListener(MotionNexusSkeletonsUpdatedEvent.SKELETONS_UPDATED, onskeletonsUpdated);
			
			MotionNexus.start(settings);
			
			createView();
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */		
		public function closeApplication(e:Event):void
		{      
			MotionNexus.close();
		}
		
		/**
		 * When the depth image is updated set the bitmapData 
		 * @param event
		 * 
		 */		
		protected function onDepthImageUpdated(event:MotionNexusCameraEvent):void
		{
			_depthImage.bitmapData = event.image;
		}
		
		/**
		 * When skeletons are updated clear graphics and draw new skeletons 
		 * @param event
		 * 
		 */		
		protected function onskeletonsUpdated(event:MotionNexusSkeletonsUpdatedEvent):void{
			//Clear the skeleton lines and call to draw the skeleton
			_skeletonPlayground.graphics.clear();
			_skeletonPlayground.graphics.lineStyle(5, 0x00FF00);
			for each(var skeleton:MotionNexusSkeleton in event.skeletons){
				drawSkeleton(skeleton, _skeletonPlayground.graphics);
			}
		}
		
		/**
		 * Darw a skeleton from line to line and if seated draw only 10 points on top
		 * @param user
		 * @param target
		 *
		 */
		public function drawSkeleton(skeleton:MotionNexusSkeleton, target:Graphics):void
		{
			moveTo(skeleton.head, target);
			lineTo(skeleton.shoulderCenter, target);
			lineTo(skeleton.spine, target);
			lineTo(skeleton.hipCenter, target);
			
			moveTo(skeleton.shoulderCenter, target);
			lineTo(skeleton.leftShoulder, target);
			lineTo(skeleton.leftElbow, target);
			lineTo(skeleton.leftWrist, target);
			lineTo(skeleton.leftHand, target);
			
			moveTo(skeleton.shoulderCenter, target);
			lineTo(skeleton.rightShoulder, target);
			lineTo(skeleton.rightElbow, target);
			lineTo(skeleton.rightWrist, target);
			lineTo(skeleton.rightHand, target);
			
			moveTo(skeleton.hipCenter, target);
			lineTo(skeleton.leftHip, target);
			lineTo(skeleton.leftKnee, target);
			lineTo(skeleton.leftAnkle, target);
			lineTo(skeleton.leftFoot, target);
			
			moveTo(skeleton.hipCenter, target);
			lineTo(skeleton.rightHip, target);
			lineTo(skeleton.rightKnee, target);
			lineTo(skeleton.rightAnkle, target);
			lineTo(skeleton.rightFoot, target);
			
			var scale:Point;
			var joint:MotionNexusSkeletonJoint;
			for (var i:int=0; i < MotionNexusSkeleton.JOINT_COUNT; i++)
			{
				joint=skeleton.getJoint(i);
				scale = joint.scaleToScreen(stage.stageWidth,stage.stageHeight);
				target.beginFill(0x00FF00);
				target.drawCircle(scale.x, scale.y, 10);
				target.endFill();
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
			var scale:Point;
			scale = (joint as MotionNexusSkeletonJoint).scaleToScreen(stage.stageWidth,stage.stageHeight);
			target.moveTo(scale.x, scale.y);
		}
		
		/**
		 * Utility function to draw a line to a new point
		 * @param joint
		 * @param target
		 *
		 */
		private function lineTo(joint:IMotionNexusSkeletonJoint, target:Graphics):void
		{
			var scale:Point;
			scale = (joint as MotionNexusSkeletonJoint).scaleToScreen(stage.stageWidth,stage.stageHeight);
			target.lineTo(scale.x, scale.y);
		}
		
		/**
		 * Display launch button and create UI components 
		 * 
		 */		
		protected function createView():void{
			
			//Depth image to display depth image from camera
			_depthImage = new Bitmap(new BitmapData(320,240,true,0));
			_depthImage.width=320;
			_depthImage.height=240;
			_depthImage.x=0;
			_depthImage.y = stage.stageHeight-240;
			this.addChild(_depthImage);
			
			//Create view for skeletons to be drawn on
			_skeletonPlayground=new Shape();
			addChild(_skeletonPlayground);
		}
		
		/**
		 * Relocate the depth image when the application resizes
		 * @param event
		 * 
		 */		
		protected function onResize(event:Event):void{
			if(_depthImage){
				_depthImage.y = stage.stageHeight-240;
			}
		}
	}
}