package
{
import flash.display.MovieClip;
import flash.display.Loader;
import flash.events.*;
import flash.net.URLRequest;

import com.hexagonstar.util.debug.Debug;

public class RamboRunner extends MovieClip
{
    private var gameStarted = false;

    private var floor:Loader;
    private var speed = 5;
    private var acceleration = 0.1;

    public function RamboRunner()
    {
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);

        this.scaleX = 2;
        this.scaleY = 2;

        //Draw Background
        graphics.beginFill(0x000000);
        graphics.drawRect(0,0, 320, 160);
        graphics.endFill();

    }

    public function onAddedToStage(event:Event):void
    {
        var loader:Loader = new Loader();
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeAsset, false, 0 , true);
        loader.load(new URLRequest('assets/floor.jpg'));

        startGame();
    }

    public function completeAsset(event:Event):void
    {
        Debug.trace('terminamos de cargar asset');
        floor = event.target.loader as Loader;
        floor.cacheAsBitmap = true;
        floor.x = 0;
        floor.y = 160 - floor.height;
        addChild(floor);
    }

    private function startGame():void
    {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true); 
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
            }
            else
            {
                gameStarted = true;
                Debug.trace('lol');
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
}
}
