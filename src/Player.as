package
{
import flash.display.Sprite;
import flash.events.*;

import com.hexagonstar.util.debug.Debug;

public class Player extends Sprite
{
    private var state:String;
    private var yMagnitude;

    public function Player()
    {
        graphics.beginFill(0x0000EE);
        graphics.drawRect(0,0, 16, 32);
        graphics.endFill();

        x = 16;
        y = 160 - (height * 1.5);
    
        Debug.trace(height);
        setState('still');
    }

    public function setState(newState:String):void
    {
        if(newState == state) return;

        switch(newState)
        {
            case 'jump':
                jump();
            break;
            
            default:
            break;
        }
    }

    public function update(delta:uint):void
    {
        if(state == 'jump') jumpEvent(delta);
    }

    public function jump():void
    {
        if(state == 'jump') return;

        state = 'jump';
        yMagnitude = -1;
    }

    private function jumpEvent(delta:uint):void
    {
        y += 0.2 * delta * yMagnitude;

        if(y <= 16)
        {
            yMagnitude = 1;
        }

        if(y >= 160 - (height * 1.5))
        {
            y = 160 - (height * 1.5);
            state = 'run';
        }
    }
}
}
