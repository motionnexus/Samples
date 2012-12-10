package skeleton
{


	import com.motionnexus.plugin.data.skeleton.MotionNexusSkeleton;
	import com.motionnexus.plugin.infastructure.IMotionNexusListener;
	import com.motionnexus.plugin.infastructure.IMotionNexusListenerSkeleton;

	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.primitives.Cylinder;
	import flare.utils.Pivot3DUtils;

	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	import mx.core.UIComponent;
	import mx.events.ResizeEvent;

	/**
	 * Manages the visual world of the skeleton with Flare 3D
	 *
	 */
	public class SkeletonWorld extends UIComponent implements IMotionNexusListenerSkeleton
	{

		private var _skeletons:Dictionary;
		private var _scene:Scene3D;
		private var _cameraTarget:Cylinder;
		private var _currentSkeleton3D:Skeleton3D;
		private var _cameraZDepth:Number=-1100;
		private var _seatedSkeleton:Boolean=false;


		////////////////////// 
		//
		// Constructor and initialization
		//
		/////////////////////

		public function SkeletonWorld():void
		{
			super();
			_skeletons=new Dictionary();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		public function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(ResizeEvent.RESIZE, onResizeHandler);

			_scene=new Viewer3D(this);
			_scene.clearColor.setTo(1, 1, 1);
			onResizeHandler();
		}


		////////////////////// 
		//
		// Screen size change handler
		//
		/////////////////////

		public function onResizeHandler(event:ResizeEvent=null):void
		{
			var location:Point=this.localToGlobal(new Point(0, 0));
			_scene.setViewport(location.x, location.y, this.width, this.height);
			_cameraZDepth=this.width + 400;
		}


		////////////////////// 
		//
		// Interface functions for skeleton data
		//
		/////////////////////

		public function addSkeleton($skeleton:MotionNexusSkeleton):void
		{
			if (_currentSkeleton3D == null)
			{
				_seatedSkeleton=$skeleton.seated;
				_currentSkeleton3D=new Skeleton3D($skeleton.seated);
				_scene.addChild(_currentSkeleton3D);
				_currentSkeleton3D.skeleton=$skeleton;
				_cameraTarget=new Cylinder("", 20);
				updateCameraTarget();
				setTargetPosition();
				_scene.addChild(_cameraTarget);
			}
		}

		public function updateSkeleton($skeleton:MotionNexusSkeleton):void
		{
			if (_currentSkeleton3D == null)
			{
				addSkeleton($skeleton);
				return;
			}
			if ($skeleton.trackingId == _currentSkeleton3D.skeleton.trackingId)
			{
				_currentSkeleton3D.skeleton=$skeleton;
				updateCameraTarget();
			}

		}

		public function removeSkeleton($skeleton:MotionNexusSkeleton):void
		{
			if (_currentSkeleton3D && $skeleton.trackingId == _currentSkeleton3D.skeleton.trackingId)
			{
				_scene.removeChild(_currentSkeleton3D);
				_currentSkeleton3D=null;
			}
		}

		////////////////////// 
		//
		// Camera management
		//
		/////////////////////

		public function setTargetPosition():void
		{
			Pivot3DUtils.setPositionWithReference(_scene.camera, 0, 0, _cameraZDepth, _cameraTarget, 1);
			Pivot3DUtils.lookAtWithReference(_scene.camera, 0, 80, 0, _cameraTarget);
		}

		public function updateCameraTarget():void
		{
			var VCenter:Number;
			if (_seatedSkeleton == true)
			{
				VCenter=_currentSkeleton3D.shoulderCenter3D.y - _currentSkeleton3D.head3D.y;
				_cameraTarget.setPosition(_currentSkeleton3D.shoulderCenter.x, _currentSkeleton3D.head3D.y + (VCenter / 2), _currentSkeleton3D.shoulderCenter.z);
			}
			else
			{
				VCenter=_currentSkeleton3D.leftAnkle3D.y - _currentSkeleton3D.head3D.y;
				_cameraTarget.setPosition(_currentSkeleton3D.spine.x, _currentSkeleton3D.head3D.y + (VCenter / 2), _currentSkeleton3D.spine.z);
			}
			_cameraTarget.hide();
		}

	}
}


