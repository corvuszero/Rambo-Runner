package
{
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.*;
import flash.net.URLRequest;
import flash.system.System;

import com.hexagonstar.util.debug.Debug;

public class RamboRunner extends MovieClip
{
    private var gameStarted = false;

    private var gui:GUI;

    private var floorData:BitmapData;
    private var floor:Bitmap;
    private var floor2:Bitmap;
    private var initialVelocity:uint = 2;
    private var acceleration:Number = 0.2;
    private var accelerator:Number = 0.5;
    private var distance:uint = 0;
    private var distanceModifier = 100;
    private var levelBarrier:uint = 300;

    private var logicContainer:Sprite;
    private var stageBitmap:Bitmap;
    private var myFrames:uint = 0;
    private var frameSkip = 3;

    public function RamboRunner()
    {
        Debug.monitor(stage);

        logicContainer = new Sprite();
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);

        //Draw Background
        logicContainer.graphics.beginFill(0x000000);
        logicContainer.graphics.drawRect(0,0, 320, 160);
        logicContainer.graphics.endFill();
    }

    public function onAddedToStage(event:Event):void
    {
        var loader:Loader = new Loader();
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeAsset, false, 0 , true);
        loader.load(new URLRequest('assets/floor.jpg'));

        gui = new GUI();
        logicContainer.addChild(gui);

        startGame();

        stageBitmap = new Bitmap(new BitmapData(320, 160, true)); 
        this.addEventListener(Event.ENTER_FRAME, drawStage);
        addChild(stageBitmap);
    }

    public function completeAsset(event:Event):void
    {
        floorData = event.target.content.bitmapData;
        
        floor = new Bitmap(floorData);
        floor.x = 0;
        floor.y = 160 - floor.height;

        floor2 = new Bitmap(floorData);
        floor2.x = 320;
        floor2.y = floor.y;

        logicContainer.addChild(floor);
        logicContainer.addChild(floor2);
    }

    private function startGame():void
    {
        if(!gameStarted)
        {
            gui.pressSpace();
        }

        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true); 
    }

    private function updateGame(event:Event):void
    {
        var velocity = initialVelocity + (acceleration * distance / distanceModifier);
        //Debug.trace(velocity);
        floor.x -= velocity;
        floor2.x -= velocity;

        if(floor.x <= -320) floor.x = floor2.x + 321;
        if(floor2.x <= -320) floor2.x = floor.x + 321;
        
        distance = (distance + 1) % levelBarrier;
        if(distance == 0)
        {
            Debug.trace('Speed Up! ' + velocity + ' > ' + initialVelocity + '?');

            if(Math.floor(velocity) > initialVelocity)
            {
                Debug.trace('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                initialVelocity++;
                accelerator /= 2;
                distanceModifier *= 10;
            }
            acceleration += accelerator;
        }

        gui.setDistance(distance);
    }

    private function onKeyDown(event:KeyboardEvent):void
    {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp, false, 0, true); 

        //Space Key
        if(event.charCode == 32)
        {
            //Start Moving everything
            if(gameStarted)
            {
                //TODO: Jump and shoot
            }
            else
            {
                gui.startGame();
                gameStarted = true;
                logicContainer.addEventListener(Event.ENTER_FRAME, updateGame, false, 0, true);
            }

        }
    }

    private function onKeyUp(event:KeyboardEvent):void
    {
        stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);

        //Space Key
        if(event.charCode == 32)
        {
        
        }
    }

    private function drawStage(event:Event):void
    {
        stageBitmap.bitmapData.draw(logicContainer);

        if(++myFrames % 900 == 0) System.gc();
    }
}
}
