/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.utils.*;
    import net.wg.data.*;
    import net.wg.gui.events.ViewStackEvent;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.window.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.profile.UI.*;

    public class ProfileXvmView extends XvmViewBase
    {
        public function ProfileXvmView(view:IView)
        {
            //Logger.add("ProfileXvmView");
            super(view);
        }

        public function get tabNavigator():ProfileTabNavigator
        {
            var profile:Profile = view as Profile;
            if (profile != null)
                return profile.tabNavigator;
            var profileWindow:ProfileWindow = view as ProfileWindow;
            if (profileWindow != null)
                return profileWindow.tabNavigator;
            return null;
        }

        override public function onBeforePopulate(e:LifeCycleEvent):void
        {
            tabNavigator.xfw_sectionsDataUtil.addEntity(Aliases.PROFILE_TECHNIQUE_PAGE, getQualifiedClassName(UI_ProfileTechniquePage));
            tabNavigator.xfw_sectionsDataUtil.addEntity(Aliases.PROFILE_TECHNIQUE_WINDOW, getQualifiedClassName(UI_ProfileTechniqueWindow));
        }
    }
}
