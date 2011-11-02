package
{
import flash.display.Sprite;
import flash.events.*;

import com.hexagonstar.util.debug.Debug;

public class Player extends Sprite
{
    private var state:String;
    
    private var velocity:Number = -13;
    private var gravity:Number = 0.5;
    private var currentVelocity:Number;

    public function Player()
    {
        graphics.beginFill(0x0000EE);
        graphics.drawRect(0,0, 16, 32);
        graphics.endFill();

        x = 16;
        y = 160 - (height * 1.5);
    
        cacheAsBitmap = true;
        state = 'run';
    }

    public function init():void
    {
        this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
        this.addEventListener(KeyboardEvent.KEY_UP, onKeyUp, false, 0, true);
    }

    public function update(delta:uint):void
    {
        if(state == 'jump' || state == 'fall') jumpEvent(delta);
    }

    private function jumpEvent(delta:uint):void
    {
        y += currentVelocity;
        currentVelocity += gravity;

        if(currentVelocity == 0) state = 'fall';

        if(y >= 160 - (height * 1.5))
        {
            y = 160 - (height * 1.5);
            state = 'run';
        }
    }

    private function onKeyDown(event:KeyboardEvent):void
    {
        if(state == 'run')
        {
            state = 'jump';
            currentVelocity = velocity;
        }

        if(state == 'fall')
        {
            Debug.trace('Shoot!');
        }
    }

    private function onKeyUp(event:KeyboardEvent):void
    {
        if(state == 'jump')
        {
            currentVelocity = 0;
            state = 'fall'; 
        }
    }
}
}
