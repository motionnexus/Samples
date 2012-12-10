package
{
	import com.bit101.components.PushButton;
	import com.motionnexus.plugin.MotionNexus;
	import com.motionnexus.plugin.data.settings.MotionNexusPluginSettings;
	import com.motionnexus.plugin.data.skeleton.MotionNexusSkeleton;
	import com.motionnexus.plugin.data.skeleton.MotionNexusSkeletonJoint;
	import com.motionnexus.plugin.events.MotionNexusFaceTrackingEvent;
	import com.motionnexus.plugin.events.MotionNexusPluginInstalledEvent;
	import com.motionnexus.plugin.events.MotionNexusSkeletonEvent;
	import com.motionnexus.plugin.events.MotionNexusSpeechRecognitionEvent;

	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.text.TextField;

	[SWF(frameRate="60", width="640", height="480", backgroundColor="#FFFFFF")]
	/**
	 * Speech recognition sample application
	 */
	public class Main extends Sprite
	{
		private var _startButton:PushButton;
		private var _loader:Loader;
		private var _turtle:Bitmap;
		private var _instructionText:TextField;

		/**
		 *
		 */
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			super();
		}

		/**
		 *
		 * @param event
		 */
		public function onAddedToStage(event:Event):void
		{
			//Use Motion Nexus application id
			MotionNexus.initializeWithApplicationId('a3877618-3759-4b60-beb0-86cb0632959e');

			//Check the status of the Plugin to see if it is installed or not
			MotionNexus.addEventListener(MotionNexusPluginInstalledEvent.PLUGIN_INSTALLED, onPluginStatus);

			//Load turtle image
			_loader=new Loader();
			_loader.load(new URLRequest("assets/turtle.png"));
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, turtleImageLoadComplete);
		}

		private function turtleImageLoadComplete(e:Event):void
		{
			_turtle=Bitmap(_loader.content);
			this.addChild(_turtle);
			_turtle.x=230;
			_turtle.y=150;
			_turtle.visible=false;
			_loader=null;
		}

		/**
		 * Once we know the plugin is or is not installed we can help identify to the user what is the next steps
		 */
		protected function onPluginStatus(event:MotionNexusPluginInstalledEvent):void
		{
			if (event.pluginInstalled == true)
			{
				//Create button to launch plugin
				_startButton=new PushButton(this, 0, 0, 'Lets GO!', onStart);
				this.addChild(_startButton);
				_startButton.x=(640 / 2) - (_startButton.width / 2);
				_startButton.y=(480 / 2) - (_startButton.height / 2);

				MotionNexus.launchPlugin(null);

				//Display speech commands
				_instructionText=new TextField();
				_instructionText.text='Say "Forward", "Back", "Turn Left", "Turn Right"  |  Take 3-4 seconds to startup';
				_instructionText.width=400;
				addChild(_instructionText);
				_instructionText.x=15;
				_instructionText.y=460;
				_instructionText.visible=false;

				//Retrieve information from plugin locally for a non collaborative environment  
				var settings:MotionNexusPluginSettings=new MotionNexusPluginSettings(MotionNexusPluginSettings.USER_LOCAL);
				settings.speechRecognitionEnabled=true;
				settings.speechRecognitionGrammarFile='https://s3.amazonaws.com/motionnexus.com/static/SpeechSampleGrammar.grxml';
				MotionNexus.pluginSettings=settings;

				//Used speech tag has been recognized
				MotionNexus.addEventListener(MotionNexusSpeechRecognitionEvent.SPEECH_RECOGNIZED, onSpeechRecognized);
			}
		}

		/**
		 * When the user is ready and clicks go - we will launch the plugin
		 */
		protected function onStart(event:MouseEvent):void
		{
			this.removeChild(_startButton);
			_startButton=null;
			_turtle.visible=_instructionText.visible=true;
			MotionNexus.launchPlugin(event);
		}


		/**
		 * Speech tag has been recognized
		 */
		protected function onSpeechRecognized(event:MotionNexusSpeechRecognitionEvent):void
		{
			switch (event.speechTag)
			{
				case 'FORWARD':
					moveDirection();
					break;
				case 'BACKWARD':
					moveDirection(false);
					break;
				case 'LEFT':
					rotateTurtle(-90);
					break;
				case 'RIGHT':
					rotateTurtle(90);
					break;

			}
		}

		/**
		 * Utility function to move specific direction based on current roation of the turtle
		 * @param forward
		 */
		protected function moveDirection(forward:Boolean=true):void
		{
			switch (Math.round(_turtle.rotation))
			{
				case 0:
					forward ? _turtle.y=_turtle.y - 20 : _turtle.y=_turtle.y + 20;
					break;
				case 90:
					forward ? _turtle.x=_turtle.x + 20 : _turtle.x=_turtle.x - 20;
					break;
				case -90:
					forward ? _turtle.x=_turtle.x - 20 : _turtle.x=_turtle.x + 20;
					break;
				case 180:
				case -180:
					forward ? _turtle.y=_turtle.y + 20 : _turtle.y=_turtle.y - 20;
					break;

			}
		}

		/**
		 * Rorate turtle around center of screen
		 * @param $degrees
		 */
		protected function rotateTurtle($degrees:Number):void
		{
			var point:Point=new Point(320, 240);

			var m:Matrix=_turtle.transform.matrix;
			m.tx-=point.x;
			m.ty-=point.y;
			m.rotate($degrees * (Math.PI / 180));
			m.tx+=point.x;
			m.ty+=point.y;
			_turtle.transform.matrix=m;
		}

	}
}
