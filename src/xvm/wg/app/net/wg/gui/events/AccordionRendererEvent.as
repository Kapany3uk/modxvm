package net.wg.gui.events
{
    import flash.events.Event;
    
    public class AccordionRendererEvent extends Event
    {
        
        public function AccordionRendererEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }
        
        public static var ACCORDION_RENDERER_ROLL_OVER:String = "AccordionRendererRollOver";
        
        public static var ACCORDION_RENDERER_ROLL_OUT:String = "AccordionRendererRollOut";
        
        override public function clone() : Event
        {
            return new AccordionRendererEvent(type);
        }
    }
}
