package
{
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;

import com.hexagonstar.util.debug.Debug;

public class GUI extends Sprite
{
    private var title:TextField;
    private var textFormat:TextFormat;
    private var distance:TextField;

    public function GUI()
    {
        textFormat = new TextFormat();
        textFormat.color = 0xFFFFFF;
        textFormat.size = 20;

        title = getTextField('Press Space!');
        title.x = (320 - title.width) / 2;
        title.y = (160 - title.height) / 2;

        var dist = getTextField('Distance: ', 15);
        dist.x = 5;
        dist.y = 5;
        addChild(dist);

        distance = getTextField('0', 15);
        distance.x = dist.x + 60;
        distance.y = dist.y;
        addChild(distance);
    }

    public function pressSpace():void
    {
        addChild(title);
    }
    
    public function startGame():void
    {
        removeChild(title); 
    }

    public function setDistance(dist):void
    {
        distance.text = dist + '';
    }

    private function getTextField(myText, anotherSize=20):TextField
    {
        var result:TextField = new TextField();
        result.text = myText;
        textFormat.size = anotherSize;
        result.setTextFormat(textFormat);

        return result;
    }
}
}
