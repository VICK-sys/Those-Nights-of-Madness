package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class TheEndState extends FlxState {
    private var warningText:FlxText;
    private var instructionText:FlxText;
    private var instructionText2:FlxText;
    private var endingBG:FlxSprite;
    private var warningShadow:FlxText;
    private var instructionShadow:FlxText;
    private var instruction2Shadow:FlxText;
    var black:FlxSprite;
    var white:FlxSprite;

    override public function create():Void {
        super.create();

        DiscordClient.changePresence("Ending Screen", null);

        FlxG.sound.playMusic(PathsInGame.musicPath + "theEnd" + PathsInGame.ogg, 1, false);

		endingBG = new FlxSprite(0, 0); // Title BG
		endingBG.loadGraphic(PathsInGame.menuPaths + "firstDegreeMurder" + PathsInGame.png);	
        endingBG.screenCenter(XY);
		add(endingBG);

        white = new FlxSprite(0, 0).makeGraphic(1000, 450, FlxColor.WHITE);
		white.scrollFactor.set(0, 0);
        white.screenCenter(XY);
		white.updateHitbox();
        add(white);

        // Drop shadow for the warning text
        warningShadow = new FlxText(5, (FlxG.height / 4) + 5, FlxG.width, "Welp, that's all folks. \nThank you very much for playing our game!");
        warningShadow.setFormat("assets/fonts/superstar.ttf", 50, 0xFF000000, "center");
        warningShadow.alignment = "center";
        warningShadow.alpha = 0;
        warningShadow.y -= 10; // Offset for the shadow
        add(warningShadow);

        // Main warning text
        warningText = new FlxText(0, FlxG.height / 4, FlxG.width, "Welp, that's all folks. \nThank you very much for playing our game!");
        warningText.setFormat("assets/fonts/superstar.ttf", 50, 0xFF3061E3, "center");
        warningText.alignment = "center";
        warningText.alpha = 0;
        warningText.y -= 10;
        add(warningText);

        // Drop shadow for the instruction text
        instructionShadow = new FlxText(5, (FlxG.height * 3 / 4) + 5, FlxG.width, "You can check our socials in the credits.");
        instructionShadow.setFormat("assets/fonts/superstar.ttf", 50, 0xFF000000, "center");
        instructionShadow.alignment = "center";
        instructionShadow.alpha = 0;
        instructionShadow.y -= 190; // Offset for the shadow
        add(instructionShadow);

        // Main instruction text
        instructionText = new FlxText(0, FlxG.height * 3 / 4, FlxG.width, "You can check our socials in the credits.");
        instructionText.setFormat("assets/fonts/superstar.ttf", 50, 0xFF3061E3, "center");
        instructionText.alignment = "center";
        instructionText.alpha = 0;
        instructionText.y -= 190;
        add(instructionText);

        // Drop shadow for the instruction text 2
        instruction2Shadow = new FlxText(5, (FlxG.height * 3 / 4) + 5, FlxG.width, "Press Enter to return to the Titlescreen.");
        instruction2Shadow.setFormat("assets/fonts/superstar.ttf", 50, 0xFF000000, "center");
        instruction2Shadow.alignment = "center";
        instruction2Shadow.alpha = 0;
        instruction2Shadow.y -= 50; // Offset for the shadow
        add(instruction2Shadow);

        // Main instruction text 2
        instructionText2 = new FlxText(0, FlxG.height * 3 / 4, FlxG.width, "Press Enter to return to the Titlescreen.");
        instructionText2.setFormat("assets/fonts/superstar.ttf", 50, 0xFF3061E3, "center");
        instructionText2.alignment = "center";
        instructionText2.alpha = 0;
        instructionText2.y -= 50;
        add(instructionText2);

        black = new FlxSprite();
		black.loadGraphic(PathsInGame.menuPaths + PathsInGame.blackString + PathsInGame.png);
		black.screenCenter(XY);
		black.alpha = 1;
        FlxTween.tween(black, {alpha: 0}, 2, {ease: FlxEase.quadInOut});
		add(black);

        // Set a timer to show the warning text after 3 seconds
        var timer = new FlxTimer();
        timer.start(2, showWarningText);
    }

    private function showWarningText(timer:FlxTimer):Void {

        FlxTween.tween(warningShadow, {alpha: 0.3}, 1, {ease: FlxEase.quadInOut});
        FlxTween.tween(warningText, {alpha: 1}, 1, {ease: FlxEase.quadInOut});

        // Set another timer to show the instruction text after 3 seconds
        var instructionTimer = new FlxTimer();
        instructionTimer.start(3, showInstructionText);

        var instructionTimer2 = new FlxTimer();
        instructionTimer2.start(7, showInstructionText2);
    }

    private function showInstructionText(timer:FlxTimer):Void {
        FlxTween.tween(instructionShadow, {alpha: 0.3}, 1, {ease: FlxEase.quadInOut});
        FlxTween.tween(instructionText, {alpha: 1}, 1, {ease: FlxEase.quadInOut});
    }

    private function showInstructionText2(timer:FlxTimer):Void {
        FlxTween.tween(instruction2Shadow, {alpha: 0.3}, 1, {ease: FlxEase.quadInOut});
        FlxTween.tween(instructionText2, {alpha: 1}, 1, {ease: FlxEase.quadInOut});
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
    
        // Check for Enter key press
        if (FlxG.keys.justPressed.ENTER) {
            FlxTween.tween(black, {alpha: 1}, 3, {
                ease: FlxEase.quadInOut, 
                onComplete: function(twn:FlxTween):Void {
                    FlxG.sound.music.stop();	
                    FlxG.sound.playMusic(PathsInGame.musicPath + PathsInGame.menuMusicString + PathsInGame.ogg, 1, true);
                    FlxG.switchState(new TitleScreenState());
                }
            });
        }
    }    
}
