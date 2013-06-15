import com.xvm.Logger;
import wot.Minimap.Minimap;
import wot.Minimap.model.externalProxy.MapConfig;

/**
 * Handles minimap windows zoom and center positioning
 * by key pressing
 */
class wot.Minimap.Zoom
{
    /** This is the subject of resize reposition */
    private var minimap:Minimap;

    /** Temporary place to store last normal map size value before resize procedure by zoom */
    private var prevSizeIndex:Number;

    /** Stores state for switcher */
    var currentState:Boolean;

    public function Zoom(minimap:Minimap)
    {
        this.minimap = minimap;
        currentState = true;
    }

    public function onZoomKeyClick(event):Void
    {
        if (!userIsUsingChat)
        {
            /**
             * Zoom while key is on hold
             * or switch zoom when key is clicked
             */
            var isZoomKeyDown:Boolean = event.details.value == "keyDown";
            if (MapConfig.zoomHold)
            {
                holdBehaviour(isZoomKeyDown);
            }
            else if (isZoomKeyDown)
            {
                switchBehaviour();
            }
        }
    }

    // -- Private

    private function holdBehaviour(isZoomKeyDown:Boolean):Void
    {
        if (isZoomKeyDown)
        {
            zoomIn();
        }
        else
        {
            zoomOut();
        }
    }

    private function switchBehaviour():Void
    {
        if (currentState)
        {
            zoomIn();
            currentState = !currentState;
        }
        else
        {
            zoomOut();
            currentState = !currentState;
        }
    }

    private function zoomIn():Void
    {
        increaseSize();
        if (MapConfig.zoomCentered)
        {
            centerPosition();
        }
    }

    private function zoomOut():Void
    {
        bottomRightPosition();
        restoreSize();
    }

    private function centerPosition():Void
    {
        /** Position map bottom right corner at center */
        minimap.wrapper._x = Stage.width / 2;
        minimap.wrapper._y = Stage.height / 2;

        /** Offset position taking map center into account */
        minimap.wrapper._x += minimap.wrapper.width / 2;
        minimap.wrapper._y += minimap.wrapper.height / 2;
    }

    private function bottomRightPosition():Void
    {
        /** Position map bottom right corner at bottom right of Stage */
        minimap.wrapper._x = Stage.width;
        minimap.wrapper._y = Stage.height;
    }

    private function increaseSize():Void
    {
        var side:Number = Stage.height - MapConfig.zoomPixelsBack;
        minimap.wrapper.setSize(side, side);
    }

    private function restoreSize():Void
    {
        minimap.wrapper.setupSize(minimap.wrapper.m_sizeIndex, Stage.height);
    }
    
    private function get userIsUsingChat():Boolean
    {
        return _root.messenger.messageInput._focused;
    }
}
