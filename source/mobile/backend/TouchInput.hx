package mobile.backend;

import flixel.FlxG;

/**
 * ...
 * @author Idklool
 */
class TouchInput {
    public static function BACK():Bool
    {
        return #if android FlxG.android.justReleased.BACK #else false #end;
    }
    public static function justTouched():Bool {
        #if mobile
        return FlxG.touches.list.filter(touch -> touch.justPressed).length > 0;
        #end
        return false;
    }
    public static function justPressed(obj:flixel.FlxBasic):Bool {
        #if mobile
        return FlxG.touches.list.filter(touch -> touch.justPressed && touch.overlaps(obj)).length > 0;
        #end
        return false;
    }
    public static function justReleased(obj:flixel.FlxBasic):Bool {
        #if mobile
        return FlxG.touches.list.filter(touch -> touch.justReleased && touch.overlaps(obj)).length > 0;
        #end
        return false;
    }
    public static function pressed(obj:flixel.FlxBasic):Bool {
        #if mobile
        return FlxG.touches.list.filter(touch -> touch.pressed && touch.overlaps(obj)).length > 0;
        #end
        return false;
    }
    public static function released(obj:flixel.FlxBasic):Bool {
        #if mobile
        return FlxG.touches.list.filter(touch -> touch.released && touch.overlaps(obj)).length > 0;
        #end
        return false;
    }
    public static function idfkaName(x:Float, y:Float, width:Float, height:Float):Bool {
        #if mobile
        return FlxG.touches.list.filter(touch -> 
            touch.x >= x && touch.x <= x + width &&
            touch.y >= y && touch.y <= y + height
        ).length > 0;
        #end
        return false;
    }
    public static function isSwipe(direction:String):Bool {
        #if mobile
        for (swipe in FlxG.swipes) {
            if (swipe != null && swipe.duration > 0) {
                var deltaX = swipe.endPosition.x - swipe.startPosition.x;
                var deltaY = swipe.endPosition.y - swipe.startPosition.y;

                switch (direction.toLowerCase()) {
                    case 'down':
                        if (deltaY < -30 && Math.abs(deltaY) > Math.abs(deltaX)) return true;
                    case 'up':
                        if (deltaY > 30 && Math.abs(deltaY) > Math.abs(deltaX)) return true;
                    case 'right':
                        if (deltaX < -30 && Math.abs(deltaX) > Math.abs(deltaY)) return true;
                    case 'left':
                        if (deltaX > 30 && Math.abs(deltaX) > Math.abs(deltaY)) return true;
                    default:
                        return false;
                }
            }
        }
        #end
        return false;
    }
}
