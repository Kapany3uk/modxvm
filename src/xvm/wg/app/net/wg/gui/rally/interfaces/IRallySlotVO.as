package net.wg.gui.rally.interfaces
{
   import net.wg.gui.rally.vo.VehicleVO;


   public interface IRallySlotVO
   {
          
      function get rallyIdx() : Number;

      function get isCommanderState() : Boolean;

      function get isClosedVal() : Boolean;

      function get playerObj() : Object;

      function get selectedVehicle() : VehicleVO;

      function set selectedVehicle(param1:VehicleVO) : void;

      function get selectedVehicleLevel() : int;

      function set selectedVehicleLevel(param1:int) : void;

      function get playerStatus() : int;

      function set playerStatus(param1:int) : void;

      function get isCurrentUserInSlot() : Boolean;

      function get slotLabel() : String;

      function get canBeTaken() : Boolean;
   }

}