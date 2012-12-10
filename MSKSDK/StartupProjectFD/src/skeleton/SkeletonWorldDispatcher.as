package skeleton
{
	import com.motionnexus.plugin.managers.MotionNexusDispatcher;

	import flash.events.Event;

	/**
	 * Extends the SkeletonWorld class and registers it to be a part of the Motion Nexus dispatching cycle by adding it to the MotionNexusDispatcher. The SkeletonWorld is registered as an
	 * IMotionNexusListenerSkeleton defining it is interested skeleton data.
	 *
	 */
	public class SkeletonWorldDispatcher extends SkeletonWorld
	{
		override public function onAddedToStage(event:Event):void
		{
			super.onAddedToStage(event);
			MotionNexusDispatcher.addListener(this);
		}
	}
}
