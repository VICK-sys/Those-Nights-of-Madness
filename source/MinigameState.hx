package;

import flixel.FlxState;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;

class MinigameState extends FlxState 
{

    var staticAnimated:FlxSprite;

    var redStaticSound:FlxSound;

    override public function create() 
    {
        redStaticSound = FlxG.sound.load(PathsInGame.soundPath + "transitionminigame" + PathsInGame.ogg);

        staticAnimated = new FlxSprite(0, 0, "assets/images/minigames/redStatic.png");
        staticAnimated.frames = FlxAtlasFrames.fromSparrow("assets/images/minigames/redStatic.png", "assets/images/minigames/redStatic.xml");
        staticAnimated.animation.addByPrefix("redAnimating", "redStatic redStaticAnimating0", 24, false);
        staticAnimated.antialiasing = false;
        staticAnimated.visible = true;
        staticAnimated.screenCenter();
        add(staticAnimated);    

        super.create();
    }

    override public function update(elapsed:Float):Void 
    {
        staticAnimated.animation.play("redAnimating", false);

        redStaticSound.play();

        super.update(elapsed);
    }
}
