package com.motionnexus.avateering
{
	import com.motionnexus.avateering.avatars.AlexisSkeleton;

	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	import flare.loaders.ColladaLoader;

	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;

	import mx.core.UIComponent;
	import mx.events.ResizeEvent;

	public class AvatarWorld extends UIComponent
	{
		private var scene:Scene3D;
		private var model:Pivot3D;
		private var userModel:AvatarRigged;
		private var _lastPos:Vector3D;
		private var _currentPoz:Vector3D;
		private var _smoother:Dictionary;

		public function AvatarWorld()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		/**
		 *
		 * @param event
		 */
		public function onAddedToStage(event:Event):void
		{
			addEventListener(ResizeEvent.RESIZE, onResizeHandler);

			_smoother=new Dictionary();


			// creates the scene.
			scene=new Viewer3D(this);
			scene.camera.setPosition(100, 100, -200);
			scene.camera.lookAt(0, 100, 0);
			scene.clearColor.setTo(1, 1, 1);
		}

		public function loadAvatar($avatar:*, $meshId:String, $avatarClass:Class):void
		{
			var collada:ColladaLoader=new ColladaLoader(XML($avatar));
			model=scene.addChild(collada);
			collada.load();
			userModel=new $avatarClass(model.getChildByName($meshId) as Mesh3D);
		}

		public function rotateModel(value:Number):void
		{
			model.rotateY(value);
		}

		public function moveModelVertical(value:Number):void
		{
			model.y=value;
		}

		public function moveModelHorizontal(value:Number):void
		{
			model.x=value;
		}

		public function setJointRotation(vector:Vector3D, joint:String):void
		{
			if (_smoother[joint] == null)
			{
				_smoother[joint]=new TransformSmoothing(5);
			}
			else
			{
				var history:TransformSmoothing=_smoother[joint];
				var smoothedVector:Vector3D=history.smoothVector3D(vector);
				userModel[joint].setRotation(smoothedVector.x, smoothedVector.y, smoothedVector.z);
			}
		}

		public function onResizeHandler(event:ResizeEvent=null):void
		{
			var location:Point=this.localToGlobal(new Point(this.x, this.y));
			scene.setViewport(location.x, location.y - 150, this.width, this.width);
		}
	}
}
