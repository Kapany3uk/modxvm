package com.xvm.wg
{
    import com.xvm.wg.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.infrastructure.events.LoaderEvent;
    import net.wg.infrastructure.interfaces.IImageData;
    import net.wg.infrastructure.managers.IImageManager;
    import net.wg.infrastructure.managers.ILoaderManager;
    import org.idmedia.as3commons.util.StringUtils;

    public class ImageManagerWG extends EventDispatcher implements IImageManager
    {
        private static const MAX_CACHE_SIZE:int = 4096 * 1024;
        private static const MIN_CACHE_SIZE:int = 1024 * 1024;

        private var _cache:Dictionary = null;

        private var _queue:Vector.<ImageData> = null;

        private var _init:Boolean = false;

        private var _loaderMgr:ILoaderManager = null;

        private var _size:uint = 0;

        private var _maxCacheSize:int = 0;

        private var _minCacheSize:int = 0;

        public function ImageManagerWG()
        {
            super();
            this._cache = new Dictionary();
            this._queue = new Vector.<ImageData>();
            as_setImageCacheSettings(MAX_CACHE_SIZE, MIN_CACHE_SIZE);
        }

        public function as_loadImages(param1:Array) : void
        {
            var _loc3_:String = null;
            var _loc2_:ImageData = null;
            for each(_loc3_ in param1)
            {
                if(this._cache.hasOwnProperty(_loc3_))
                {
                    _loc2_ = ImageData(this._cache[_loc3_]);
                    if(!_loc2_.isLockData())
                    {
                        if(!_loc2_.lockData())
                        {
                            _loc2_.dispose();
                            _loc2_ = new ImageData(_loc3_);
                        }
                    }
                }
                else
                {
                    _loc2_ = new ImageData(_loc3_);
                }
                _loc2_.permanent = true;
                this._cache[_loc3_] = _loc2_;
            }
            param1.splice(0,param1.length);
        }

        public function as_setImageCacheSettings(param1:int, param2:int) : void
        {
            this._maxCacheSize = param1;
            this._minCacheSize = param2;
            this.initCache();
        }

        public function as_unloadImages(param1:Array) : void
        {
            var _loc3_:String = null;
            var _loc2_:ImageData = null;
            for each(_loc3_ in param1)
            {
                if(this._cache.hasOwnProperty(_loc3_))
                {
                    _loc2_ = this._cache[_loc3_];
                    _loc2_.permanent = false;
                    if(_loc2_.ready)
                    {
                        _loc2_.unlockData();
                    }
                    else
                    {
                        _loc2_.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
                        _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoaderIOErrorHandler);
                    }
                }
                else
                {
                    App.utils.asserter.assert(false,"Unload a non-existent data: " + _loc3_);
                }
            }
        }

        public function dispose() : void
        {
            var _loc1_:ImageData = null;
            if(this._init)
            {
                this._loaderMgr.removeEventListener(LoaderEvent.VIEW_LOADING,this.onLoaderMgrViewLoadingHandler);
                this._loaderMgr = null;
            }
            this._queue.splice(0,this._queue.length);
            this._queue = null;
            for each(_loc1_ in this._cache)
            {
                delete this._cache[_loc1_.source];
                _loc1_.dispose();
            }
            this._cache = null;
        }

        public function getImageData(param1:String) : IImageData
        {
            var _loc2_:ImageData = null;
            if(StringUtils.isEmpty(param1))
            {
                return null;
            }
            _loc2_ = this.getLoader(param1);
            if(!_loc2_.ready)
            {
                _loc2_.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
                _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoaderIOErrorHandler);
            }
            return _loc2_;
        }

        private function getLoader(param1:String) : ImageData
        {
            App.utils.asserter.assert(this._init,"ImageManager not been initialized");
            var _loc2_:ImageData = null;
            if(this._cache.hasOwnProperty(param1))
            {
                _loc2_ = ImageData(this._cache[param1]);
                if(!_loc2_.isLockData())
                {
                    if(_loc2_.lockData())
                    {
                        this.pushQueue(_loc2_);
                    }
                    else
                    {
                        _loc2_.dispose();
                        _loc2_ = this.createImageLoader(param1);
                    }
                }
            }
            else
            {
                _loc2_ = this.createImageLoader(param1);
            }
            return _loc2_;
        }

        private function createImageLoader(param1:String) : ImageData
        {
            var _loc2_:ImageData = new ImageData(param1);
            this._cache[param1] = _loc2_;
            return _loc2_;
        }

        private function pushQueue(param1:ImageData) : void
        {
            this._queue.push(param1);
            App.utils.asserter.assert(this._minCacheSize > param1.size,"Image size exceeds the buffer cache: " + param1.source);
            this._size = this._size + param1.size;
        }

        private function clearCache() : void
        {
            var _loc1_:ImageData = null;
            var _loc3_:String = null;
            var _loc2_:Vector.<String> = new Vector.<String>();
            while(this._size > this._minCacheSize)
            {
                _loc1_ = this._queue.shift();
                this._size = this._size - _loc1_.size;
                _loc1_.unlockData();
            }
            for each(_loc1_ in this._cache)
            {
                if(!_loc1_.valid)
                {
                    _loc2_.push(_loc1_.source);
                    _loc1_.dispose();
                }
            }
            for each(_loc3_ in _loc2_)
            {
                delete this._cache[_loc3_];
            }
        }

        private function initCache() : void
        {
            if(!this._init)
            {
                this._init = true;
                this._loaderMgr = App.instance.loaderMgr;
                this._loaderMgr.addEventListener(LoaderEvent.VIEW_LOADING,this.onLoaderMgrViewLoadingHandler);
            }
        }

        private function onLoaderCompleteHandler(param1:Event) : void
        {
            var _loc2_:ImageData = ImageData(param1.target);
            _loc2_.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
            _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoaderIOErrorHandler);
            if(!_loc2_.permanent)
            {
                this.pushQueue(_loc2_);
            }
        }

        private function onLoaderIOErrorHandler(param1:IOErrorEvent) : void
        {
            var _loc2_:ImageData = ImageData(param1.target);
            _loc2_.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
            _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoaderIOErrorHandler);
        }

        private function onLoaderMgrViewLoadingHandler(param1:LoaderEvent) : void
        {
            if(this._size > this._maxCacheSize)
            {
                this.clearCache();
            }
        }
    }
}

import net.wg.infrastructure.interfaces.entity.IDisposable;
import flash.utils.Dictionary;

class WeakRef extends Object implements IDisposable
{

    private var _dict:Dictionary = null;

    private var _target:* = null;

    private var _lock:Boolean = false;

    function WeakRef(param1:*, param2:Boolean = false)
    {
        super();
        this._dict = new Dictionary(true);
        this._dict[param1] = 1;
        if(param2)
        {
            this._lock = param2;
            this._target = param1;
        }
    }

    public function get target() : *
    {
        var _loc1_:* = undefined;
        if(this._lock)
        {
            return this._target;
        }
        for(_loc1_ in this._dict)
        {
            return _loc1_;
        }
        return null;
    }

    public function dispose() : void
    {
        var _loc1_:* = undefined;
        this.unlock();
        for(_loc1_ in this._dict)
        {
            delete this._dict[_loc1_];
        }
        this._dict = null;
    }

    public function get isLock() : Boolean
    {
        return this._lock;
    }

    public function lock() : Boolean
    {
        var _loc1_:* = undefined;
        if(!this._lock)
        {
            _loc1_ = this.target;
            if(_loc1_ != null)
            {
                this._target = _loc1_;
                this._lock = true;
            }
        }
        return this._lock;
    }

    public function unlock() : void
    {
        if(this._lock)
        {
            this._target = null;
            this._lock = false;
        }
    }
}

import flash.display.*;
import flash.events.*;
import flash.net.*;
import flash.system.*;
import net.wg.infrastructure.interfaces.IImage;
import net.wg.infrastructure.interfaces.IImageData;
import net.wg.infrastructure.interfaces.entity.IDisposable;

class ImageData extends EventDispatcher implements IDisposable, IImageData
{

    private static const BYTE_PER_PIXEL:int = 4;

    private static const CONTENT_TYPE_SWF:String = "application/x-shockwave-flash";

    private var _loader:Loader = null;

    private var _weakBitmapData:WeakRef = null;

    private var _ready:Boolean = false;

    private var _size:uint = 0;

    private var _permanent:Boolean = false;

    private var _source:String = "";

    function ImageData(param1:String)
    {
        super();
        this._source = param1;
        var _loc2_:URLRequest = new URLRequest(param1);
        var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
        this._loader = new Loader();
        this.addLoaderListeners();
        this._loader.load(_loc2_,_loc3_);
    }

    public function dispose() : void
    {
        if(this._ready)
        {
            this._weakBitmapData.dispose();
            this._weakBitmapData = null;
        }
        else
        {
            this.removeLoaderListeners();
            this._loader.close();
            this._loader = null;
        }
    }

    public function isLockData() : Boolean
    {
        if(this._ready)
        {
            return this._weakBitmapData.isLock;
        }
        return true;
    }

    public function lockData() : Boolean
    {
        return this._weakBitmapData.lock();
    }

    public function unlockData() : void
    {
        if(!this._permanent)
        {
            this._weakBitmapData.unlock();
        }
    }

    public function get source() : String
    {
        return this._source;
    }

    public function get size() : uint
    {
        return this._size;
    }

    public function get valid() : Boolean
    {
        if(this._ready)
        {
            return this._weakBitmapData.target != null;
        }
        return true;
    }

    public function get ready() : Boolean
    {
        return this._ready;
    }

    public function showTo(param1:IImage) : void
    {
        param1.bitmapData = this._weakBitmapData.target;
    }

    private function onLoaderCompleteHandler(param1:Event) : void
    {
        this.removeLoaderListeners();
        App.utils.asserter.assert(this._loader.contentLoaderInfo.contentType != CONTENT_TYPE_SWF,"Content loader is not image: " + this._source);
        var _loc2_:BitmapData = Bitmap(this._loader.content).bitmapData;
        this._weakBitmapData = new WeakRef(_loc2_,true);
        this._size = _loc2_.width * _loc2_.height * BYTE_PER_PIXEL;
        this._loader.unload();
        this._loader = null;
        this._ready = true;
        dispatchEvent(new Event(Event.COMPLETE));
    }

    private function onLoaderIOErrorHandler(param1:IOErrorEvent) : void
    {
        this.removeLoaderListeners();
        DebugUtils.LOG_ERROR(param1.toString());
        dispatchEvent(param1);
        this._weakBitmapData = new WeakRef(null);
        this._loader = null;
        this._ready = true;
    }

    private function addLoaderListeners() : void
    {
        this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
        this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoaderIOErrorHandler);
    }

    private function removeLoaderListeners() : void
    {
        this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
        this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoaderIOErrorHandler);
    }

    public function get permanent() : Boolean
    {
        return this._permanent;
    }

    public function set permanent(param1:Boolean) : void
    {
        this._permanent = param1;
    }
}
