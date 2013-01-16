package  com.motionnexus.samples.gestures.processors
{

	import com.motionnexus.data.cursor.MotionNexusCursor;
	import com.motionnexus.infastructure.IMotionNexus;
	import com.motionnexus.infastructure.IMotionNexusListenerCursor;
	import com.motionnexus.infastructure.IMotionNexusListenerSkeleton;
	import com.motionnexus.infastructure.IMotionNexusSkeleton;
	import com.motionnexus.infastructure.IMotionNexusSkeletonJoint;
	import com.motionnexus.managers.MotionNexusDispatcher;
	import com.motionnexus.samples.gestures.data.GestureHistory;
	import com.motionnexus.samples.gestures.data.GestureSkeletonAngles;
	import com.motionnexus.samples.gestures.data.GestureTimeCursor;
	import com.motionnexus.samples.gestures.data.GestureTimeSkeleton;
	import com.motionnexus.utilities.MotionNexusConversions;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	/**
	 *
	 * @author Justin
	 */
	public class GestureProcessor extends EventDispatcher implements IMotionNexusListenerCursor, IMotionNexusListenerSkeleton
	{

		private var _gestureHistory:Dictionary;
		private var _paused:Boolean;
		private var _skeletonAngles:GestureSkeletonAngles = new GestureSkeletonAngles();


		//////////////////////
		//
		// Functions
		//
		/////////////////////

		/**
		 * Call on constructor to set up class
		 */
		public function GestureProcessor():void
		{
			super();
			onConstructor();
		}

		/**
		 * 
		 * @param $source
		 * 
		 */		
		public function start($source:IMotionNexus):void
		{
			MotionNexusDispatcher.addListener(this);
			MotionNexusDispatcher.startDispatching($source);
		}

		/**
		 * 
		 * 
		 */		
		public function stop():void
		{
			MotionNexusDispatcher.removeListener(this);
		}

		/**
		 *
		 *
		 */
		protected function onConstructor():void
		{
			_gestureHistory=new Dictionary();
		}

		/**
		 *
		 * @param kinectSkeleton
		 */
		public function addSkeleton($skeleton:IMotionNexusSkeleton):void
		{
			if (_gestureHistory[$skeleton.trackingId] == null)
			{
				_gestureHistory[$skeleton.trackingId]=new GestureHistory($skeleton);
			}
			else
			{
				var gestureEntry:GestureHistory=_gestureHistory[$skeleton.trackingId];
				gestureEntry.updatedSkeleton($skeleton);

			}
		}

		/**
		 * Called if a new cursor was tracked.
		 */
		public function addCursor($cursor:MotionNexusCursor):void
		{
			if (_gestureHistory[$cursor.trackingId] == null)
			{
				_gestureHistory[$cursor.trackingId]=new GestureHistory(null, $cursor);
			}
			else
			{
				var gestureEntry:GestureHistory=_gestureHistory[$cursor.trackingId];
				gestureEntry.updatedCursor($cursor);

			}

		}

		/**
		 *
		 * @param kinectSkeleton
		 */
		public function updateSkeleton($skeleton:IMotionNexusSkeleton):void
		{
			if (_gestureHistory[$skeleton.trackingId] != null)
			{
				var gestureEntry:GestureHistory=_gestureHistory[$skeleton.trackingId];
				gestureEntry.updatedSkeleton($skeleton);
			}
			else
			{
				addSkeleton($skeleton)
			}
			_skeletonAngles.update($skeleton);
			testGesture($skeleton);
		}

		/**
		 * Called if a tracked cursor was updated.
		 */
		public function updateCursor($cursor:MotionNexusCursor):void
		{
			
			if (_gestureHistory[$cursor.trackingId] != null)
			{
				var gestureEntry:GestureHistory=_gestureHistory[$cursor.trackingId];
				gestureEntry.updatedCursor($cursor);
			}
			else
			{
				addCursor($cursor);
			}

		}

		/**
		 *
		 * @param trackingID
		 * @return
		 */
		public function getPreviousSkeleton(trackingID:Number):GestureTimeSkeleton
		{
			var entry:GestureHistory=_gestureHistory[trackingID];
			if (entry == null)
			{
				return null;
			}
			return entry.previousSkeletonEntry();
		}

		/**
		 *
		 * @param trackingID
		 * @return
		 */
		public function getPreviousCursor(trackingID:Number, type:String):GestureTimeCursor
		{
			var entry:GestureHistory=_gestureHistory[trackingID];
			if (entry == null)
			{
				return null;
			}
			return entry.previousCursorEntry(type);
		}



		/**
		 *
		 * @param trackingID
		 * @return
		 */
		public function getSkeletonHisotry(trackingID:Number):Vector.<GestureTimeSkeleton>
		{
			var entry:GestureHistory=_gestureHistory[trackingID];
			if (entry == null)
			{
				return new Vector.<GestureTimeSkeleton>;
			}
			return entry.skeletonHistory();
		}

		/**
		 *
		 * @param trackingID
		 * @return
		 */
		public function getCursorHistory(trackingID:Number, type:String):Vector.<GestureTimeCursor>
		{
			var entry:GestureHistory=_gestureHistory[trackingID];
			if (entry == null)
			{
				return new Vector.<GestureTimeCursor>;
			}
			return entry.cursorHistory(type);
		}

		/**
		 *
		 * @param trackingID
		 * @return
		 */
		public function getCurrentSkeleton(trackingID:Number):GestureTimeSkeleton
		{
			var entry:GestureHistory=_gestureHistory[trackingID];
			if (entry == null)
			{
				return null;
			}
			return entry.currentSkeletonEntry();
		}

		/**
		 *
		 * @param trackingID
		 * @param type
		 *
		 */
		public function deleteCursorHistory(trackingID:Number, type:String):void
		{
			var entry:GestureHistory=_gestureHistory[trackingID];
			if (entry != null)
			{
				return entry.deleteCursorHistory(type);
			}
		}

		/**
		 *
		 * @param trackingID
		 * @return
		 */
		public function getCurrentCursor(trackingID:Number, type:String):GestureTimeCursor
		{
			var entry:GestureHistory=_gestureHistory[trackingID];
			if (entry == null)
			{
				return null;
			}
			return entry.currentCursorEntry(type);
		}

		/**
		 *
		 * @param kinectSkeleton
		 */
		public function removeSkeleton($skeleton:IMotionNexusSkeleton):void
		{
			if (_gestureHistory[$skeleton.trackingId] != null)
			{
				var gestureEntry:GestureHistory=_gestureHistory[$skeleton.trackingId];
				gestureEntry.deleteSkeletonHistory();
			}
		}

		/**
		 * Called if a tracked cursor was removed.
		 */
		public function removeCursor($cursor:MotionNexusCursor):void
		{
			if (_gestureHistory[$cursor.trackingId] != null)
			{
				var gestureEntry:GestureHistory=_gestureHistory[$cursor.trackingId];
				gestureEntry.deleteCursorHistory($cursor.type);
			}

		}
		
		public function testGesture(skeleton:IMotionNexusSkeleton):void
		{
			_skeletonAngles.update(skeleton);
		}
		
		public function get skeletonAngles():GestureSkeletonAngles
		{
			return _skeletonAngles;
		}
		
		public function set skeletonAngles(value:GestureSkeletonAngles):void
		{
			_skeletonAngles = value;
		}

		public function get paused():Boolean
		{
			return _paused;
		}

		public function set paused(value:Boolean):void
		{
			_paused=value;
		}

	}
}
