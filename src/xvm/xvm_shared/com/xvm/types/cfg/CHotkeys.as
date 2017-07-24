/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHotkeys implements ICloneable
    {
        public var minimapZoom:CHotkeysParams;
        public var minimapAltMode:CHotkeysParams;
        public var playersPanelAltMode:CHotkeysParams;
        public var markersAltMode:CHotkeysParams;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
