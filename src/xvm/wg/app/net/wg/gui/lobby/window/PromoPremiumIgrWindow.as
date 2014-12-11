package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.PromoPremiumIgrWindowMeta;
    import net.wg.infrastructure.base.meta.IPromoPremiumIgrWindowMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.events.ButtonEvent;
    import flash.display.InteractiveObject;
    
    public class PromoPremiumIgrWindow extends PromoPremiumIgrWindowMeta implements IPromoPremiumIgrWindowMeta
    {
        
        public function PromoPremiumIgrWindow()
        {
            super();
            isModal = true;
            isCentered = true;
            canDrag = false;
        }
        
        public var titleTF:TextField = null;
        
        public var descriptionTF:TextField = null;
        
        public var applyButton:SoundButtonEx = null;
        
        public function as_setTitle(param1:String) : void
        {
            this.titleTF.htmlText = param1;
        }
        
        public function as_setText(param1:String) : void
        {
            this.descriptionTF.htmlText = param1;
        }
        
        public function as_setWindowTitle(param1:String) : void
        {
            window.title = param1;
        }
        
        public function as_setApplyButtonLabel(param1:String) : void
        {
            this.applyButton.label = param1;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.applyButton.addEventListener(ButtonEvent.CLICK,this.onApplyButtonClick);
        }
        
        override protected function onDispose() : void
        {
            this.applyButton.removeEventListener(ButtonEvent.CLICK,this.onApplyButtonClick);
            this.applyButton.dispose();
            this.applyButton = null;
            this.titleTF = null;
            this.descriptionTF = null;
            super.onDispose();
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.useBottomBtns = true;
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.applyButton);
        }
        
        private function onApplyButtonClick(param1:ButtonEvent) : void
        {
            onWindowCloseS();
        }
    }
}
