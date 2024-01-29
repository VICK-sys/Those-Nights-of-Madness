package;

import OldTVShader;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import openfl.filters.ShaderFilter;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import flixel.text.FlxText;

class TitleScreenState extends FlxState
{
	var shader:OldTVShader;
	var menuCamera:FlxCamera;

	var newGameHitbox:FlxSprite;
	var continueHitbox:FlxSprite;
	var optionsHitbox:FlxSprite;

	var newsPaper:FlxSprite;
	var cursor:FlxSprite;
	var button:FlxSprite;
	var black:FlxSprite;
	var titleMBG3:FlxSprite;
	var titleMBG:FlxSprite;

	var doneTweening:Bool = false;
	var clicked:Bool = false;

	var buttons:FlxTypedGroup<FlxSprite>;

	var newGameSound:FlxSound;
	var continueSound:FlxSound;
	var continueOptionsSound:FlxSound;

	var nightOneContinue:FlxSprite;
	var nightTwoContinue:FlxSprite;
	var nightThreeContinue:FlxSprite;
	var nightFourContinue:FlxSprite;
	var nightFiveContinue:FlxSprite;

	var flicker:Bool = false;
	var flickerTimer:Float = 0; // Timer that counts down to next flicker
	var flickerCooldown:Float = 1; // Cooldown in seconds between flickers

	var alphaDelta:Float = 0.1; // Adjust the rate of alpha change as needed

	//public static var cursorPath:String = "assets/images/menuStuff/cursor";

	var optionButtonsArray:Array<String> = [
		'NewGame',
		'Continue',
		'Options'
	];

	var sprite:FlxSprite;

	override public function create()
	{
		menuCamera = new FlxCamera();
		FlxG.cameras.add(menuCamera, false);
		menuCamera.bgColor.alpha = 0;

		DiscordClient.changePresence("At Title Screen", null);

		// cursor = new FlxSprite();
		// // cursor.loadGraphic(cursorPath + png);
		// cursor.scale.x = 0.4;
		// cursor.scale.y = 0.4;
		// cursor.cameras = [menuCamera];

		FlxG.mouse.visible = true;
		FlxG.mouse.enabled = true;

		FlxG.mouse.load();

		newGameSound = FlxG.sound.load(PathsInGame.soundPath + "new_game" + PathsInGame.ogg);

		continueSound = FlxG.sound.load(PathsInGame.soundPath + "continue_or_options" + PathsInGame.ogg);

		var black2:FlxSprite = new FlxSprite(0, 0);
		black2.loadGraphic(PathsInGame.menuPaths + PathsInGame.blackString + PathsInGame.png);
		black2.screenCenter(XY);
		black2.cameras = [menuCamera];
		add(black2);

		titleMBG = new FlxSprite(1500, 0); // Title BG
		titleMBG.loadGraphic(PathsInGame.menuPaths + "TitleBG" + PathsInGame.png);
		FlxTween.tween(titleMBG, {x: 0}, 2.6, {ease: FlxEase.expoOut});		
		titleMBG.cameras = [menuCamera];
		add(titleMBG);

		titleMBG3 = new FlxSprite(); // Title BG3 Layer
		titleMBG3.loadGraphic(PathsInGame.menuPaths + "TitleLogoThing" + PathsInGame.png);
		titleMBG3.cameras = [menuCamera];
		titleMBG3.scale.x = 0.65;
		titleMBG3.scale.y = 0.65;
		titleMBG3.x -= 185;
		titleMBG3.x += 100;
		titleMBG3.y -= 75;
		titleMBG3.y -= 15;
		add(titleMBG3);
		FlxTween.tween(titleMBG3, {y: titleMBG3.y + 5}, 2, {ease: FlxEase.quadInOut, type: PINGPONG});

		buttons = new FlxTypedGroup<FlxSprite>();
		add(buttons);

		for (i in 0...optionButtonsArray.length)
		{
			var offset:Float = 398 - (Math.max(optionButtonsArray.length, 4) - 4) * 80;
			button = new FlxSprite(15, (i * 130)  + offset).loadGraphic(PathsInGame.menuPaths + optionButtonsArray[i] + "Button" + PathsInGame.png);
			button.scale.x = 0.7;
			button.scale.y = 0.7;
			button.ID = i;
			button.y -= 40;
			FlxTween.tween(button, {y: button.y + 5}, 5, {ease: FlxEase.quadInOut, type: PINGPONG});
			buttons.add(button);
			button.scrollFactor.set(0, 0);
			button.updateHitbox();
			button.cameras = [menuCamera];
		}

		nightOneContinue = new FlxSprite(175, 505);
		nightOneContinue.loadGraphic(PathsInGame.menuPaths + "night1" + PathsInGame.png);
		nightOneContinue.scrollFactor.set(0, 0);
		nightOneContinue.updateHitbox();
		nightOneContinue.cameras = [menuCamera];
		nightOneContinue.visible = false;
		nightOneContinue.scale.x = 0.5;
		nightOneContinue.scale.y = 0.5;
		add(nightOneContinue);

		nightTwoContinue = new FlxSprite(175, 505).makeGraphic(290, 90, FlxColor.BLACK);
		nightTwoContinue.loadGraphic(PathsInGame.menuPaths + "night2" + PathsInGame.png);
		nightTwoContinue.scrollFactor.set(0, 0);
		nightTwoContinue.updateHitbox();
		nightTwoContinue.cameras = [menuCamera];
		nightTwoContinue.visible = false;
		nightTwoContinue.scale.x = 0.5;
		nightTwoContinue.scale.y = 0.5;
		add(nightTwoContinue);

		nightThreeContinue = new FlxSprite(175, 505).makeGraphic(290, 90, FlxColor.BLACK);
		nightThreeContinue.loadGraphic(PathsInGame.menuPaths + "night3" + PathsInGame.png);
		nightThreeContinue.scrollFactor.set(0, 0);
		nightThreeContinue.updateHitbox();
		nightThreeContinue.cameras = [menuCamera];
		nightThreeContinue.visible = false;
		nightThreeContinue.scale.x = 0.5;
		nightThreeContinue.scale.y = 0.5;
		add(nightThreeContinue);

		nightFourContinue = new FlxSprite(175, 505).makeGraphic(290, 90, FlxColor.BLACK);
		nightFourContinue.loadGraphic(PathsInGame.menuPaths + "night4" + PathsInGame.png);
		nightFourContinue.scrollFactor.set(0, 0);
		nightFourContinue.updateHitbox();
		nightFourContinue.cameras = [menuCamera];
		nightFourContinue.visible = false;
		nightFourContinue.scale.x = 0.5;
		nightFourContinue.scale.y = 0.5;
		add(nightFourContinue);

		nightFiveContinue = new FlxSprite(175, 505).makeGraphic(290, 90, FlxColor.BLACK);
		nightFiveContinue.loadGraphic(PathsInGame.menuPaths + "night5" + PathsInGame.png);
		nightFiveContinue.scrollFactor.set(0, 0);
		nightFiveContinue.updateHitbox();
		nightFiveContinue.cameras = [menuCamera];
		nightFiveContinue.visible = false;
		nightFiveContinue.scale.x = 0.5;
		nightFiveContinue.scale.y = 0.5;
		add(nightFiveContinue);

		newGameHitbox = new FlxSprite(10, 365).makeGraphic(290, 90, FlxColor.BLACK);
		newGameHitbox.scrollFactor.set(0, 0);
		newGameHitbox.updateHitbox();
		newGameHitbox.cameras = [menuCamera];

		continueHitbox = new FlxSprite(10, 495).makeGraphic(290, 90, FlxColor.BLACK);
		continueHitbox.scrollFactor.set(0, 0);
		continueHitbox.updateHitbox();
		continueHitbox.cameras = [menuCamera];

		optionsHitbox = new FlxSprite(10, 618).makeGraphic(260, 72, FlxColor.BLACK);
		optionsHitbox.scrollFactor.set(0, 0);
		optionsHitbox.updateHitbox();
		optionsHitbox.cameras = [menuCamera];

		newsPaper = new FlxSprite(); // Newspaper
		newsPaper.loadGraphic(PathsInGame.menuPaths + "newspaper" + PathsInGame.png);
		newsPaper.cameras = [menuCamera];
		newsPaper.alpha = 0;
		add(newsPaper);

		// add(cursor);

		black = new FlxSprite();
		black.loadGraphic(PathsInGame.menuPaths + PathsInGame.blackString + PathsInGame.png);
		black.screenCenter(XY);
		black.cameras = [menuCamera];
		add(black);
		FlxTween.tween(black, {alpha: 0}, 2.5, {ease: FlxEase.smoothStepInOut});

		shader = new OldTVShader();
		menuCamera.setFilters([new ShaderFilter(shader)]);

		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			FlxG.sound.playMusic(PathsInGame.musicPath + PathsInGame.menuMusicString + PathsInGame.ogg, 1, true);
		}

		super.create();
	}

	override public function update(elapsed:Float)
	{
		shader.update(elapsed);

		if (FlxG.keys.pressed.EIGHT) //For Debugging Purposes
		{
			FlxG.switchState(new TheEndState());
			FlxG.sound.music.stop();
		}

		if (FlxG.keys.pressed.NINE) //For Debugging Purposes
		{
			FlxG.switchState(new MinigameState());
			FlxG.sound.music.stop();
		}

		// cursor.x = FlxG.mouse.x - 90; // Use FlxG.mouse.x instead of screenX
		// cursor.y = FlxG.mouse.y - 90; // Use FlxG.mouse.y instead of screenY

		if(titleMBG.x == 0)
		{
			FlxTween.tween(titleMBG, {x: 5, y: 5}, 1.8, {type: FlxTweenType.PINGPONG,ease: FlxEase.smoothStepOut});
		}
		
		// Flicker effect logic with randomness for rapid changes
		if (flickerTimer <= 0)
		{
			if (flicker)
			{
				// Randomly choose a new alphaDelta for an irregular effect
				alphaDelta = Math.random() * 0.2; // Randomize for rapid flicker
				titleMBG3.alpha -= alphaDelta;
				if (titleMBG3.alpha <= 0.5)
				{
					flicker = false;
					flickerTimer = Math.random() * 0.2; // Short random cooldown
				}
			}
			else
			{
				alphaDelta = Math.random() * 0.2; // Randomize for rapid flicker
				titleMBG3.alpha += alphaDelta;
				if (titleMBG3.alpha >= 1)
				{
					flicker = true;
					flickerTimer = Math.random() * 5; // Short random cooldown
				}
			}
		}
		else
		{
			flickerTimer -= elapsed;
		}

		if (FlxG.mouse.overlaps(newGameHitbox))
		{
			if (FlxG.mouse.pressed && !clicked)
			{
				
				FlxG.save.data.nightOneNotCompleted = null;
				FlxG.save.data.nightOneCompleted = false;
				FlxG.save.data.nightTwoCompleted = false;
				FlxG.save.data.nightThreeCompleted = false;
				FlxG.save.data.nightFourCompleted = false;
				FlxG.save.data.nightFiveCompleted = false;

				clicked = true;
				newGameSound.play();
				FlxG.sound.music.stop();
				FlxTween.tween(black, {alpha: 1}, 7, {
					ease: FlxEase.quadInOut, 
					onComplete: function(twn:FlxTween) {
						// cursor.visible = false;
						FlxG.mouse.visible = false;
						menuCamera.setFilters([]);
						FlxG.sound.playMusic(PathsInGame.musicPath + "news_in" + PathsInGame.ogg, 1, false);
						newsPaper.alpha = 1;
						FlxTween.tween(menuCamera, {zoom: 1.5}, 50);
						FlxTween.tween(newsPaper, {angle: 15}, 50);
						FlxTween.tween(black, {alpha: 0}, 7, {
							ease: FlxEase.quadInOut, 
							onComplete: function(twn:FlxTween) {
								new FlxTimer().start(6, function(tmr:FlxTimer) {
									black.alpha = 1;
									FlxG.switchState(new LoadingState());
								});
							} // This closing brace was missing
						});
					}
				});				
			}
		}

		if(FlxG.mouse.overlaps(continueHitbox))
		{
			if (FlxG.mouse.pressed && !clicked)
				{
					clicked = true;
					FlxG.switchState(new LoadingState());
					FlxG.sound.music.stop();		
				}
		}

		if (FlxG.mouse.overlaps(continueHitbox) || FlxG.mouse.overlaps(optionsHitbox))
		{
			if (FlxG.mouse.pressed && !clicked)
			{
				continueSound.play();
			}
		}

		if(FlxG.mouse.overlaps(continueHitbox))
		{

			if(FlxG.save.data.nightOneNotCompleted == true)//On Night 1
			{
				nightOneContinue.visible = true;
			}

			if(FlxG.save.data.nightOneCompleted == true)//On Night 2
			{
				nightOneContinue.visible = false;
				nightTwoContinue.visible = true;
			}

			if(FlxG.save.data.nightTwoCompleted == true)//On Night 3
			{
				nightTwoContinue.visible = false;
				nightThreeContinue.visible = true;
			}

			if(FlxG.save.data.nightThreeCompleted == true)//On Night 4
			{
				nightThreeContinue.visible = false;
				nightFourContinue.visible = true;
			}

			if(FlxG.save.data.nightFourCompleted == true)//On Night 5
			{
				nightFourContinue.visible = false;
				nightFiveContinue.visible = true;
			}
		}
		else
		{
			nightOneContinue.visible = false;
			nightTwoContinue.visible = false;
			nightThreeContinue.visible = false;
			nightFourContinue.visible = false;
			nightFiveContinue.visible = false;
		}

		// var cursorOverButton:Bool = false;

		for (item in buttons.members) {
			if (FlxG.mouse.overlaps(item)) {
				item.alpha = 1;
				// cursorOverButton = true;
			} else {
				item.alpha = 0.5; // Default alpha when not hovering
			}
		}

		// if (cursorOverButton) {
		// 	cursor.loadGraphic(cursorPath + "Changed" + png);
		// } else {
		// 	cursor.loadGraphic(cursorPath + png);
		// }
	
		super.update(elapsed);
	}
}
