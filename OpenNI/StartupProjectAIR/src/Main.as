package
{
	import com.motionnexus.openni.MotionNexus;
	import com.motionnexus.openni.data.settings.MotionNexusSettings;
	import com.motionnexus.openni.data.skeleton.MotionNexusSkeleton;
	import com.motionnexus.openni.data.skeleton.MotionNexusSkeletonJoint;
	import com.motionnexus.openni.events.MotionNexusCameraEvent;
	import com.motionnexus.openni.events.MotionNexusPluginStatusEvent;
	import com.motionnexus.openni.events.MotionNexusSkeletonsUpdatedEvent;
	import com.motionnexus.openni.plugin.MotionNexusPlugin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	public class Main extends Sprite
	{
		private var _depthImage:Bitmap;
		private var _launchButton:Sprite;
		private var _launchButtonLabel:TextField;
		private var _skeletonPlayground:Shape;
		
		/**
		 * First thing we want to do is make sure the plugin is installed / suported 
		 * 
		 */		
		public function Main()
		{
			if(this.stage)
			{
				this.stage.align = StageAlign.TOP_LEFT;
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			stage.addEventListener(Event.RESIZE, onResize);
			
			//Make sure the plugin is intsalled before anything else
			MotionNexus.addEventListener(MotionNexusPluginStatusEvent.PLUGIN_INSTALLED, onPluginInstalled);
		}
		
		/**
		 * If the plugin is installed we want to create the view and set the settings. If the plugin is not installed you can requres to download it.
		 * @param event
		 * 
		 */		
		protected function onPluginInstalled(event:MotionNexusPluginStatusEvent):void
		{
			if (event.description == 'true')
			{
				createView();
				
				var settings:MotionNexusSettings=new MotionNexusSettings();
				settings.skeletonTrackingEnabled=true;
				settings.depthImageEnabled=true;
				settings.playerMaskEnabled=true;
				settings.mirroringEnabled=true;
				MotionNexus.pluginSettings=settings;
				
				//Used when depth image is updated
				MotionNexus.addEventListener(MotionNexusCameraEvent.IMAGE_UPDATED, onDepthImageUpdated);
				
				//Display skeleton container
				MotionNexus.addEventListener(MotionNexusSkeletonsUpdatedEvent.SKELETONS_UPDATED, onskeletonsUpdated);
				
				MotionNexusPlugin.launch();
			}
			else
			{
				MotionNexus.downloadPlugin();
			}
		}
		
		/**
		 * Launch the plugin - with web it is a required user interaction 
		 * @param event
		 * 
		 */		
		protected function launchPlugin(event:MouseEvent):void
		{
			MotionNexus.launchPlugin(event);
			_launchButton.visible =false;
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
			_skeletonPlayground.graphics.lineStyle(2, 0x00FF00);
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
			moveTo(skeleton.neck, target);
			lineTo(skeleton.leftShoulder, target);
			lineTo(skeleton.leftElbow, target);
			lineTo(skeleton.leftHand, target);
			
			moveTo(skeleton.neck, target);
			lineTo(skeleton.rightShoulder, target);
			lineTo(skeleton.rightElbow, target);
			lineTo(skeleton.rightHand, target);
			
			moveTo(skeleton.head, target);
			lineTo(skeleton.neck, target);
			lineTo(skeleton.torso, target);
			lineTo(skeleton.leftHip, target);
			lineTo(skeleton.leftKnee, target);
			lineTo(skeleton.leftFoot, target);
			
			moveTo(skeleton.torso, target);
			lineTo(skeleton.rightHip, target);
			lineTo(skeleton.rightKnee, target);
			lineTo(skeleton.rightFoot, target);
			
			var scale:Point;
			var joint:MotionNexusSkeletonJoint;
			for (var i:int=0; i < MotionNexusSkeleton.JOINT_COUNT; i++)
			{
				joint=skeleton.getJoint(i);
				scale = joint.scaleToScreen(stage.stageWidth,stage.stageHeight);
				target.beginFill(0x00FF00);
				target.drawCircle(scale.x, scale.y, 5);
				target.endFill();
			}
		}
		
		/**
		 * Utility function to move a line against a target graphic
		 * @param joint
		 * @param target
		 *
		 */
		private function moveTo(joint:MotionNexusSkeletonJoint, target:Graphics):void
		{
			var scale:Point;
			scale = joint.scaleToScreen(stage.stageWidth,stage.stageHeight);
			target.moveTo(scale.x, scale.y);
		}
		
		/**
		 * Utility function to draw a line to a new point
		 * @param joint
		 * @param target
		 *
		 */
		private function lineTo(joint:MotionNexusSkeletonJoint, target:Graphics):void
		{
			var scale:Point;
			scale = joint.scaleToScreen(stage.stageWidth,stage.stageHeight);
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