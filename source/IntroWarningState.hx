package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class IntroWarningState extends FlxState {
    private var warningText:FlxText;
    private var instructionText:FlxText;
    private var musicPath:String = "assets/music/";
    private var ogg:String = ".ogg";
    private var menuMusicString:String = "menu_music";

    override public function create():Void {
        super.create();

        // Warning text (hidden initially)
        warningText = new FlxText(0, FlxG.height / 4, FlxG.width, "Warning: This Game Contains Flashing Lights\nLoud Noises, and Jumpscares!");
        warningText.setFormat("assets/fonts/vcr.ttf", 32, 0xFFFFFFFF, "center", 0xFF000000);
        warningText.alignment = "center";
        warningText.alpha = 0;
        warningText.y += 100;
        add(warningText);

        // Instruction text (hidden initially)
        instructionText = new FlxText(0, FlxG.height * 3 / 4, FlxG.width, "Press Enter to Continue");
        instructionText.setFormat("assets/fonts/vcr.ttf", 32, 0xFFFFFFFF, "center", 0xFF000000);
        instructionText.alignment = "center";
        instructionText.alpha = 0;
        instructionText.y -= 100;
        add(instructionText);

        // Set a timer to show the warning text after 3 seconds
        var timer = new FlxTimer();
        timer.start(4, showWarningText);

        if(FlxG.save.data.seenWarning == true)
        {
            FlxG.sound.playMusic(musicPath + menuMusicString + ogg, 1, true);
            FlxG.switchState(new TitleScreenState());
        }
    }

    private function showWarningText(timer:FlxTimer):Void {

        FlxTween.tween(warningText, {alpha: 1}, 2, {ease: FlxEase.quadInOut});

        // Set another timer to show the instruction text after 3 seconds
        var instructionTimer = new FlxTimer();
        instructionTimer.start(2, showInstructionText);
    }

    private function showInstructionText(timer:FlxTimer):Void {
        FlxTween.tween(instructionText, {alpha: 1}, 2, {ease: FlxEase.quadInOut});
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
    
        // Check for Enter key press
        if (FlxG.keys.justPressed.ENTER) {
            if(FlxG.save.data.seenWarning == null) FlxG.save.data.seenWarning = true;
            FlxTween.tween(warningText, {alpha: 0}, 2, {ease: FlxEase.quadInOut});
            FlxTween.tween(instructionText, {alpha: 0}, 3, {
                ease: FlxEase.quadInOut, 
                onComplete: function(twn:FlxTween):Void {
                    FlxG.switchState(new TitleScreenState());
                }
            });
        }
    }    
}
