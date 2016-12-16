/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public dynamic class BattleXvmComponentController implements IBattleComponentDataController, IDisposable
    {
        public function BattleXvmComponentController()
        {
            //Logger.add("BattleXvmComponentController");
            super();
        }

        public final function dispose():void
        {
            onDispose();
        }

        protected function onDispose():void
        {
            // empty
        }

        public function setVehiclesData(data:IDAAPIDataClass):void
        {
            BattleState.instance.setVehiclesData(data);
        }

        public function addVehiclesInfo(data:IDAAPIDataClass):void
        {
            BattleState.instance.addVehiclesInfo(data);
        }

        public function updateVehiclesData(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateVehiclesData(data);
        }

        public function updateVehicleStatus(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateVehicleStatus(data);
        }

        public function updatePersonalStatus(param1:uint, param2:uint):void
        {
            BattleState.instance.updatePersonalStatus(param1, param2);
        }

        public function setVehicleStats(data:IDAAPIDataClass):void
        {
            BattleState.instance.setVehicleStats(data);
        }

        public function updateVehiclesStat(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateVehiclesStat(data);
        }

        public function updatePlayerStatus(data:IDAAPIDataClass):void
        {
            BattleState.instance.updatePlayerStatus(data);
        }

        public function setArenaInfo(data:IDAAPIDataClass):void
        {
            BattleState.instance.setArenaInfo(data);
        }

        public function setUserTags(data:IDAAPIDataClass):void
        {
            BattleState.instance.setUserTags(data);
        }

        public function updateUserTags(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateUserTags(data);
        }

        public function setPersonalStatus(param1:uint):void
        {
            BattleState.instance.setPersonalStatus(param1);
        }

        public function updateInvitationsStatuses(data:IDAAPIDataClass) : void
        {
            BattleState.instance.updateInvitationsStatuses(data);
        }
    }
}
