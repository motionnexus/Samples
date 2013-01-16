package com.motionnexus.samples.gestures.data
{

	
	import com.motionnexus.data.cursor.MotionNexusCursor;
	import com.motionnexus.infastructure.IMotionNexusSkeleton;
	
	import flash.utils.getTimer;

	/**
	 *
	 * @author Justin
	 */
	public class GestureHistory
	{
		private var _trackingID:Number;
		private var _skeletonHistory:Vector.<GestureTimeSkeleton>=new Vector.<GestureTimeSkeleton>(5, true);
		private var _cursorLeftHistory:Vector.<GestureTimeCursor>=new Vector.<GestureTimeCursor>(5, true);
		private var _cursorRightHistory:Vector.<GestureTimeCursor>=new Vector.<GestureTimeCursor>(5, true);


		/**
		 *
		 * @param skeleton
		 */
		public function GestureHistory(skeleton:IMotionNexusSkeleton=null, cursor:MotionNexusCursor=null):void
		{
			if (skeleton)
			{
				updatedSkeleton(skeleton);
			}
			if (cursor)
			{
				updatedCursor(cursor);
			}
		}

		/**
		 *
		 * @param skeleton
		 */
		public function updatedCursor(cursor:MotionNexusCursor):void
		{
			_trackingID=cursor.trackingId;
			var i:int;
			if (cursor.type == MotionNexusCursor.LEFT_HAND)
			{
				i=_cursorLeftHistory.length - 1;
				for (i; i > 0; i--)
				{
					_cursorLeftHistory[i]=_cursorLeftHistory[i - 1];
				}
				_cursorLeftHistory[0]=new GestureTimeCursor(cursor, getTimer());
			}
			else
			{
				i=_cursorRightHistory.length - 1;
				for (i; i > 0; i--)
				{
					_cursorRightHistory[i]=_cursorRightHistory[i - 1];
				}
				_cursorRightHistory[0]=new GestureTimeCursor(cursor, getTimer());

			}
		}

		/**
		 *
		 * @param skeleton
		 */
		public function updatedSkeleton(skeleton:IMotionNexusSkeleton):void
		{
			_trackingID=skeleton.trackingId;
			var i:int=_skeletonHistory.length - 1;
			for (i; i > 0; i--)
			{
				_skeletonHistory[i]=_skeletonHistory[i - 1];
			}

			_skeletonHistory[0]=new GestureTimeSkeleton(skeleton, getTimer());
		}


		/**
		 *
		 * @return
		 *
		 */
		public function currentSkeletonEntry():GestureTimeSkeleton
		{
			return _skeletonHistory[0];
		}

		/**
		 *
		 * @return
		 *
		 */
		public function currentCursorEntry(type:String):GestureTimeCursor
		{
			if (type == MotionNexusCursor.LEFT_HAND)
			{
				return _cursorLeftHistory[0];
			}
			return _cursorRightHistory[0];
		}

		/**
		 *
		 * @return
		 *
		 */
		public function previousSkeletonEntry():GestureTimeSkeleton
		{
			return _skeletonHistory[1];
		}

		/**
		 *
		 * @return
		 *
		 */
		public function previousCursorEntry(type:String):GestureTimeCursor
		{
			if (type == MotionNexusCursor.LEFT_HAND)
			{
				return _cursorLeftHistory[1];
			}
			return _cursorRightHistory[1];
		}

		/**
		 *
		 * @return
		 *
		 */
		public function skeletonHistory():Vector.<GestureTimeSkeleton>
		{
			return _skeletonHistory;
		}

		/**
		 *
		 * @param type
		 * @return
		 *
		 */
		public function cursorHistory(type:String):Vector.<GestureTimeCursor>
		{
			if (type == MotionNexusCursor.LEFT_HAND)
			{
				return _cursorLeftHistory;
			}
			return _cursorRightHistory;
		}

		/**
		 *
		 */
		public function deleteSkeletonHistory():void
		{
			var i:int=_skeletonHistory.length - 1;
			for (i; i > 0; i--)
			{
				_skeletonHistory[i]=null;
			}
		}

		/**
		 *
		 */
		public function deleteCursorHistory(type:String):void
		{
			var i:int=_cursorLeftHistory.length - 1;
			for (i; i > 0; i--)
			{
				if (type == MotionNexusCursor.LEFT_HAND)
				{
					_cursorLeftHistory[i]=null;
				}
				else
				{
					_cursorRightHistory[i]=null;
				}
			}
		}


	}
}
