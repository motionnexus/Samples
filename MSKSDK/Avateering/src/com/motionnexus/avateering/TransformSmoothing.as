package com.motionnexus.avateering
{
	import flash.geom.Point;
	import flash.geom.Vector3D;

	/**
	 *
	 * @author Justin
	 */
	public class TransformSmoothing
	{
		private var _history:Vector.<Number>;
		private var _historyPoint:Vector.<Point>;
		private var _historyVector3D:Vector.<Vector3D>;


		/**
		 *
		 * @param historyLength
		 */
		public function TransformSmoothing(historyLength:Number)
		{
			clean(historyLength);
		}

		/**
		 *
		 * @param historyLength
		 *
		 */
		public function clean(historyLength:Number):void
		{
			_history=new Vector.<Number>(historyLength, true);
			_historyPoint=new Vector.<Point>(historyLength, true);
			_historyVector3D=new Vector.<Vector3D>(historyLength, true);
		}

		/**
		 *
		 * @param value
		 * @return
		 *
		 */
		public function smoothPoint(value:Point):Point
		{
			var smoothX:Number=0;
			var smoothY:Number=0;

			// shift array
			var i:int=_historyPoint.length - 1;
			for (i; i > 0; i--)
			{
				_historyPoint[i]=_historyPoint[i - 1];
			}

			_historyPoint[0]=value;

			// final point is average of array points.
			// sum up array points and return the average.
			var itemNum:Number=0;
			for (var j:int=0; j < _historyPoint.length; j++)
			{
				if (_historyPoint[j] != null)
				{
					smoothX+=_historyPoint[j].x;
					smoothY+=_historyPoint[j].y;
					itemNum=itemNum + 1;
				}
			}

			return new Point((smoothX / itemNum), (smoothY / itemNum));
		}

		/**
		 *
		 * @param value
		 * @return
		 *
		 */
		public function smoothVector3D(value:Vector3D):Vector3D
		{
			var smoothX:Number=0;
			var smoothY:Number=0;
			var smoothZ:Number=0;

			// shift array
			var i:int=_historyVector3D.length - 1;
			for (i; i > 0; i--)
			{
				_historyVector3D[i]=_historyVector3D[i - 1];
			}

			_historyVector3D[0]=value;

			// final point is average of array points.
			// sum up array points and return the average.
			var itemNum:Number=0;
			for (var j:int=0; j < _historyVector3D.length; j++)
			{
				if (_historyVector3D[j] != null)
				{
					smoothX+=_historyVector3D[j].x;
					smoothY+=_historyVector3D[j].y;
					smoothZ+=_historyVector3D[j].z;
					itemNum=itemNum + 1;
				}
			}

			return new Vector3D((smoothX / itemNum), (smoothY / itemNum), (smoothZ / itemNum));
		}

		/**
		 *
		 * @param value
		 * @return
		 */
		public function smoothValue(value:Number):Number
		{
			var smoothValue:Number=0;

			// shift array
			var i:int=_history.length - 1;
			for (i; i > 0; i--)
			{
				_history[i]=_history[i - 1];
			}

			_history[0]=value;

			// final point is average of array points.
			// sum up array points and return the average.
			var itemNum:Number=0;
			for (var j:int=0; j < _history.length; j++)
			{
				if (_history[j] != 0)
				{
					smoothValue+=_history[j];
					itemNum=itemNum + 1;
				}
			}
			return Number(int((smoothValue / itemNum) * 100) / 100);
		}
	}
}
