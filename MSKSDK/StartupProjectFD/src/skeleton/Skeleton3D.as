package skeleton
{


	import com.motionnexus.plugin.data.skeleton.MotionNexusSkeleton;
	import com.motionnexus.plugin.data.skeleton.MotionNexusSkeletonJoint;

	import flare.core.Lines3D;
	import flare.core.Pivot3D;
	import flare.materials.Shader3D;
	import flare.materials.filters.ColorFilter;
	import flare.primitives.Sphere;

	import flash.geom.Vector3D;
	import flash.utils.ByteArray;

	/**
	 * Virtual 3D skeleton containing 16 joints. Hands and feet are not rendered because of accuracy and location / size of sphere in relationship to ankle and wrist joints.
	 *
	 */
	public class Skeleton3D extends Pivot3D
	{

		private var _skeleton:MotionNexusSkeleton;
		public var head3D:Sphere;
		public var shoulderCenter3D:Sphere;
		public var hipCenter3D:Sphere;
		public var leftShoulder3D:Sphere;
		public var leftElbow3D:Sphere;
		public var leftWrist3D:Sphere;
		public var rightShoulder3D:Sphere;
		public var rightElbow3D:Sphere;
		public var rightWrist3D:Sphere;
		public var leftHip3D:Sphere;
		public var leftKnee3D:Sphere;
		public var leftAnkle3D:Sphere;
		public var rightHip3D:Sphere;
		public var rightKnee3D:Sphere;
		public var rightAnkle3D:Sphere;
		public var head:Vector3D;
		public var shoulderCenter:Vector3D;
		public var spine:Vector3D;
		public var hipCenter:Vector3D;
		public var leftShoulder:Vector3D;
		public var leftElbow:Vector3D;
		public var leftWrist:Vector3D;
		public var rightShoulder:Vector3D;
		public var rightElbow:Vector3D;
		public var rightWrist:Vector3D;
		public var leftHip:Vector3D;
		public var leftKnee:Vector3D;
		public var leftAnkle:Vector3D;
		public var rightHip:Vector3D;
		public var rightKnee:Vector3D;
		public var rightAnkle:Vector3D;
		private var nullColor:Shader3D;
		private var _lineHistory:Vector.<Lines3D>;
		private var _seated:Boolean;


		public function Skeleton3D($seated:Boolean=false):void
		{
			super();
			_seated=$seated;
			build();
		}

		public function build():void
		{
			nullColor=new Shader3D("colormat", [new ColorFilter(0x00539f)]);
			_lineHistory=new Vector.<Lines3D>;

			//Init Joints
			head3D=getDefaultJoint(55);
			addChild(head3D);

			shoulderCenter3D=getDefaultJoint();
			addChild(shoulderCenter3D);

			leftShoulder3D=getDefaultJoint();
			addChild(leftShoulder3D);

			leftElbow3D=getDefaultJoint();
			addChild(leftElbow3D);

			leftWrist3D=getDefaultJoint();
			addChild(leftWrist3D);

			rightShoulder3D=getDefaultJoint();
			addChild(rightShoulder3D);

			rightElbow3D=getDefaultJoint();
			addChild(rightElbow3D);

			rightWrist3D=getDefaultJoint();
			addChild(rightWrist3D);

			if (_seated == false)
			{

				hipCenter3D=getDefaultJoint();
				addChild(hipCenter3D);

				leftHip3D=getDefaultJoint();
				addChild(leftHip3D);

				leftKnee3D=getDefaultJoint();
				addChild(leftKnee3D);

				leftAnkle3D=getDefaultJoint();
				addChild(leftAnkle3D);

				rightHip3D=getDefaultJoint();
				addChild(rightHip3D);

				rightKnee3D=getDefaultJoint();
				addChild(rightKnee3D);

				rightAnkle3D=getDefaultJoint();
				addChild(rightAnkle3D);
			}
		}

		public function set skeleton($skeleton:MotionNexusSkeleton):void
		{
			_skeleton=$skeleton;
			head=getPoint3DJoint(_skeleton.head);
			shoulderCenter=getPoint3DJoint(_skeleton.shoulderCenter);
			leftShoulder=getPoint3DJoint(_skeleton.leftShoulder);
			leftElbow=getPoint3DJoint(_skeleton.leftElbow);
			leftWrist=getPoint3DJoint(_skeleton.leftWrist);
			rightShoulder=getPoint3DJoint(_skeleton.rightShoulder);
			rightElbow=getPoint3DJoint(_skeleton.rightElbow);
			rightWrist=getPoint3DJoint(_skeleton.rightWrist);

			if (_seated == false)
			{
				spine=getPoint3DJoint(_skeleton.spine);
				hipCenter=getPoint3DJoint(_skeleton.hipCenter);
				leftHip=getPoint3DJoint(_skeleton.leftHip);
				leftKnee=getPoint3DJoint(_skeleton.leftKnee);
				leftAnkle=getPoint3DJoint(_skeleton.leftAnkle);
				rightHip=getPoint3DJoint(_skeleton.rightHip);
				rightKnee=getPoint3DJoint(_skeleton.rightKnee);
				rightAnkle=getPoint3DJoint(_skeleton.rightAnkle);
			}
			updateSkeleton();
		}

		public function get skeleton():MotionNexusSkeleton
		{
			return _skeleton;
		}

		public function getPoint3DJoint($joint:MotionNexusSkeletonJoint):Vector3D
		{
			var framejoint:Vector3D=new Vector3D();
			framejoint.x=($joint.x * 800);
			framejoint.y=$joint.y * 600;
			framejoint.z=($joint.z * 300);
			return framejoint;
		}

		public function getDefaultJoint($radius:Number=25):Sphere
		{
			var sphere:Sphere=new Sphere("", $radius, 24, nullColor);
			return sphere;
		}

		public function createNewLine():Lines3D
		{
			var line:Lines3D=new Lines3D();
			var lineWidth:Number=15;
			line.lineStyle(lineWidth, 0x00FF00);
			return line;
		}

		public function removeAllLines():void
		{
			for each (var line:Lines3D in _lineHistory)
			{
				removeChild(line);
			}
			_lineHistory=new Vector.<Lines3D>;
		}

		public function addLine(start:Vector3D, joint1:Vector3D, joint2:Vector3D=null, joint3:Vector3D=null, joint4:Vector3D=null):void
		{
			var line:Lines3D=createNewLine();
			addChild(line);
			line.moveTo(start.x, start.y, start.z);
			line.lineTo(joint1.x, joint1.y, joint1.z);
			if (joint2)
			{
				line.lineTo(joint2.x, joint2.y, joint2.z);
			}
			if (joint3)
			{
				line.lineTo(joint3.x, joint3.y, joint3.z);
			}
			if (joint4)
			{
				line.lineTo(joint4.x, joint4.y, joint4.z);
			}
			_lineHistory.push(line);
		}

		public function updateSkeleton():void
		{

			setPositionAndRotation(head3D, head);
			setPositionAndRotation(shoulderCenter3D, shoulderCenter);
			setPositionAndRotation(leftShoulder3D, leftShoulder);
			setPositionAndRotation(leftElbow3D, leftElbow);
			setPositionAndRotation(leftWrist3D, leftWrist);
			setPositionAndRotation(rightShoulder3D, rightShoulder);
			setPositionAndRotation(rightElbow3D, rightElbow);
			setPositionAndRotation(rightWrist3D, rightWrist);

			removeAllLines();
			addLine(shoulderCenter, leftShoulder, leftElbow, leftWrist);
			addLine(shoulderCenter, rightShoulder, rightElbow, rightWrist);

			if (_seated == false)
			{
				setPositionAndRotation(hipCenter3D, hipCenter);
				setPositionAndRotation(leftHip3D, leftHip);
				setPositionAndRotation(leftKnee3D, leftKnee);
				setPositionAndRotation(rightHip3D, rightHip);
				setPositionAndRotation(rightKnee3D, rightKnee);
				setPositionAndRotation(rightAnkle3D, rightAnkle);
				setPositionAndRotation(leftAnkle3D, leftAnkle);
				addLine(shoulderCenter, hipCenter);
				addLine(hipCenter, leftHip, leftKnee, leftAnkle3D.getPosition());
				addLine(hipCenter, rightHip, rightKnee, rightAnkle3D.getPosition());
			}
		}

		public function setPositionAndRotation(obj:Pivot3D, source:Vector3D):void
		{
			if (!obj)
				return;
			if (!source)
			{
				obj.visible=false;
				return;
			}
			obj.visible=true;
			obj.setPosition(source.x, source.y, source.z);
		}

	}
}
