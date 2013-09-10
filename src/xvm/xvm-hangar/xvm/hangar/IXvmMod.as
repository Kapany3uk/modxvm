/**
 * XVM - login page
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.hangar
{
    import net.wg.infrastructure.events.LifeCycleEvent;

    public interface IXvmMod
    {
        function onBeforePopulate(e:LifeCycleEvent):void;
        function onAfterPopulate(e:LifeCycleEvent):void;
        function onBeforeDispose(e:LifeCycleEvent):void;
        function onAfterDispose(e:LifeCycleEvent):void;
    }
}
