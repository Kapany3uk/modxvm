package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.utils.IIME;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.events.Event;
    import scaleform.gfx.IMECandidateListStyle;
    import scaleform.gfx.IMEEx;
    import flash.display.LoaderInfo;
    
    public class IME extends Object implements IIME
    {
        
        public function IME()
        {
            super();
            this._container = new Sprite();
            this._container.visible = false;
        }
        
        private var _container:Sprite = null;
        
        private var langBar:MovieClip = null;
        
        private var statusWinContainer:MovieClip = null;
        
        private var _langBarLoader:Loader = null;
        
        private var _statusWindowLoader:Loader = null;
        
        private var BGColor:Number = 4145200;
        
        private var BGColorOnOver:Number = 6448204;
        
        private var TextColor:Number = 16774371;
        
        private var TextColorSelected:Number = 16777215;
        
        public function init(param1:Boolean) : void
        {
            var _loc2_:LoaderContext = null;
            var _loc3_:URLRequest = null;
            var _loc4_:URLRequest = null;
            if((this._container) && (param1))
            {
                _loc2_ = new LoaderContext(false,ApplicationDomain.currentDomain,null);
                _loc3_ = new URLRequest("LangBar.swf");
                this._langBarLoader = new Loader();
                this._langBarLoader.load(_loc3_,_loc2_);
                this._langBarLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.langBarLoaded);
                this._langBarLoader.name = "LangBar";
                this._container.addChild(this._langBarLoader);
                _loc4_ = new URLRequest("StatusWindow.swf");
                this._statusWindowLoader = new Loader();
                this._statusWindowLoader.name = "StatusWindow";
                this._statusWindowLoader.load(_loc4_,_loc2_);
                this._statusWindowLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.statusWindowLoaded);
                this._container.addChild(this._statusWindowLoader);
            }
            this.initStyle();
        }
        
        private function initStyle() : void
        {
            var _loc1_:IMECandidateListStyle = new IMECandidateListStyle();
            _loc1_.textColor = 0;
            _loc1_.selectedTextColor = 16777215;
            _loc1_.fontSize = 20;
            _loc1_.backgroundColor = 15725300;
            _loc1_.selectedBackgroundColor = 9755539;
            _loc1_.indexBackgroundColor = 12503505;
            _loc1_.selectedIndexBackgroundColor = 6994017;
            _loc1_.readingWindowTextColor = 0;
            _loc1_.readingWindowBackgroundColor = 15725300;
            _loc1_.readingWindowFontSize = 30;
            IMEEx.setIMECandidateListStyle(_loc1_);
        }
        
        private function langBarLoaded(param1:Event) : void
        {
            var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
            _loc2_.removeEventListener(Event.COMPLETE,this.langBarLoaded);
            this.langBar = param1.currentTarget.content;
            this.langBar.setOwner(this);
            this.updateStyle();
        }
        
        private function statusWindowLoaded(param1:Event) : void
        {
            var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
            _loc2_.removeEventListener(Event.COMPLETE,this.statusWindowLoaded);
            this.statusWinContainer = param1.currentTarget.content;
            this.updateStyle();
        }
        
        private function updateStyle() : void
        {
            if(!(this.langBar == null) && !(this.statusWinContainer == null))
            {
                this.langBar.SetBackgroundColor(14608366,5619932);
                this.langBar.SetTextColor(5592921,16777215);
                this.statusWinContainer.SetBackgroundColor(14608366,5619932);
                this.statusWinContainer.SetTextColor(5592921,16777215);
                this.langBar.x = 0;
                this.langBar.y = 0;
                this.statusWinContainer.x = this.langBar.x + this.langBar.width;
                this.statusWinContainer.y = 0;
                this.langBar.SetTextColor(this.TextColor,this.TextColorSelected);
                this.langBar.SetBackgroundColor(this.BGColor,this.BGColorOnOver);
                this.statusWinContainer.SetTextColor(this.TextColor,this.TextColorSelected);
                this.statusWinContainer.SetBackgroundColor(this.BGColor,this.BGColorOnOver);
            }
        }
        
        public function setVisible(param1:Boolean) : void
        {
            if(App.globalVarsMgr.isShowLangaugeBarS())
            {
                this._container.visible = param1;
            }
        }
        
        public function getContainer() : Sprite
        {
            return this._container;
        }
        
        public function dispose() : void
        {
            if(this._container)
            {
                if(this.langBar)
                {
                    this._container.removeChild(this.langBar);
                    this.langBar = null;
                }
                if(this.statusWinContainer)
                {
                    this._container.removeChild(this.statusWinContainer);
                    this.statusWinContainer = null;
                }
                this._container = null;
            }
            if(this._langBarLoader != null)
            {
                this._langBarLoader.unloadAndStop();
                this._langBarLoader = null;
            }
            if(this._statusWindowLoader != null)
            {
                this._statusWindowLoader.unloadAndStop();
                this._statusWindowLoader = null;
            }
        }
        
        public function onLangBarResize(param1:Number, param2:Number) : void
        {
            if(this.statusWinContainer != null)
            {
                this.statusWinContainer.x = param1;
                this.statusWinContainer.y = param2;
            }
        }
        
        public function onSwitchLanguage() : void
        {
        }
    }
}
