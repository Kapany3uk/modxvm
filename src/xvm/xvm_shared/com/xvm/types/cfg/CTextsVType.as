/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CTextsVType implements ICloneable
    {
        public var LT:String;
        public var MT:String;
        public var HT:String;
        public var SPG:String;
        public var TD:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
