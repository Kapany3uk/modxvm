package net.wg.gui.lobby.fortifications.data.battleRoom
{
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    
    public class LegionariesSortieVO extends SortieVO
    {
        
        public function LegionariesSortieVO(param1:Object)
        {
            super(param1);
        }
        
        override protected function initSlotsVO(param1:Object) : void
        {
            var _loc3_:Object = null;
            var _loc4_:LegionariesSlotsVO = null;
            slots = new Vector.<IRallySlotVO>();
            var _loc2_:Array = param1 as Array;
            for each(_loc3_ in _loc2_)
            {
                _loc4_ = new LegionariesSlotsVO(_loc3_);
                slots.push(_loc4_);
            }
        }
    }
}
