package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.Timer;
import flixel.system.FlxSound;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;
import flixel.util.FlxSave;
import Animatronic;
import Animatronic2;
import Animatronic3;
import ConfettiEmitter;
import ConfettiParticle;
import LoadingState;
import openfl.display.Bitmap;
import openfl.media.Sound;


class PlayState extends FlxState
{
	var currentAddition = "";
	var currentAddition2 = "";
	var toAdd = "12 A.M.";
	var toAdd2 = "NIGHT 1";
	var toAdd3 = "NIGHT 2";
	var toAdd4 = "NIGHT 3";
	var toAdd5 = "NIGHT 4";
	var toAdd6 = "NIGHT 5";

	var updated12AM:Bool = false;
	var updated1AM:Bool = false;
	var updated2AM:Bool = false;
	var updated3AM:Bool = false;
	var updated4AM:Bool = false;
	var updated5AM:Bool = false;

	var timeTxt:FlxText;
	var timeTxt2:FlxText;
	var batteryPowerTxt:FlxText;
	var batteryPowerSprite:FlxSprite;
	var camFlip:FlxSprite;
	var turning:FlxSprite;
	var camStatic:FlxSprite;
	var map:FlxSprite;
	var index = 0;
	var index2 = 0;
	var black:FlxSprite;
	var black3:FlxSprite;
	var black2:FlxSprite;
	var black5:FlxSprite;
	var cam1:FlxSprite;

	var cam1AnimatronicRed:FlxSprite;
	var cam2AnimatronicRed:FlxSprite;
	var cam3AnimatronicRed:FlxSprite;
	var cam4AnimatronicRed:FlxSprite;
	var cam5AnimatronicRed:FlxSprite;

	var cam1AnimatronicBlue:FlxSprite;
	var cam2AnimatronicBlue:FlxSprite;
	var cam3AnimatronicBlue:FlxSprite;
	var cam4AnimatronicBlue:FlxSprite;
	var cam5AnimatronicBlue:FlxSprite;

	var cam1AnimatronicRedBlue:FlxSprite;
	var cam2AnimatronicRedBlue:FlxSprite;
	var cam3AnimatronicRedBlue:FlxSprite;
	var cam4AnimatronicRedBlue:FlxSprite;
	var cam5AnimatronicRedBlue:FlxSprite;

	var cam2:FlxSprite;
	var cam3:FlxSprite;
	var cam4:FlxSprite;
	var cam5:FlxSprite;
	var typeSound:FlxSound;
	var camSound:FlxSound;
	var camSound2:FlxSound;
	var phoneCall:FlxSound;
	var garbleSound:FlxSound;
	var flashlightSound:FlxSound;
	var jumpscareSound:FlxSound;
	var dedStaticSound:FlxSound;
	var sonicDiesSound:FlxSound;
	var changeCam:FlxSound;
	var endCall:FlxSound;
	var doorSound:FlxSound;
	var secondSound:FlxSound;
	var kefkaLaugh:FlxSound;
	var babyGrunt:FlxSound;
	var honkSound:FlxSound;
	var office_ambience:FlxSound;
	
	var dead:Bool = false;
	var isFlip:Bool = true;
	public var canFlip:Bool = true; // Flag to control the cooldown
	var canLook:Bool = true; // Flag to control the cooldown
	var secondSoundTimer:Timer;
	var flashLightDimTimer:Timer;
	var panningRight:Bool = true;
	var tweenActive:Bool = false;
	var tweenActive2:Bool = false;

	var flashLightHeld:Bool = false;
	var flashLightRelease:Bool = true;

	var canPressEnter:Bool = false;

	public var confetti:ConfettiEmitter;

	var cambutton:FlxSprite;

	private var notTurned:Bool = true;

	private var musicPlayed:Bool = false;

	public var doorFlippedUp:Bool = false;

	public var doorFlippedUp2:Bool = false;

	private var timerSet:Bool = false;

	private var isLookingRight:Bool = false; // This keeps track of the direction of the look

	private var gameHasFocus:Bool = true;

	private var lastActiveCamera:String = "cam1"; // Default to cam1 or any other default camera

	var camButtonHitbox:FlxSprite;

	var honkHitbox:FlxSprite;

	var cam1ButtonHitbox:FlxSprite;
	var cam2ButtonHitbox:FlxSprite;
	var cam3ButtonHitbox:FlxSprite;
	var cam4ButtonHitbox:FlxSprite;
	var cam5ButtonHitbox:FlxSprite;

	public var confettiThrown:Bool = false;

	public var won:Bool = false;

	var gitGud:FlxSprite;
	var gitGud2:FlxSprite;
	var gitGud3:FlxSprite;

	var mutePhoneHitbox:FlxSprite;

	var doorHallway:FlxSprite;
	public static var doorHallway2:FlxSprite;
	var doorHallwayBlurry:FlxSprite;

	var dedStatic:FlxSprite;

	var office:FlxSprite;
	var office2:FlxSprite;

	var flashLight:FlxSprite;

	public static var flashTriggered:Bool = false;

	private var dimming:Bool = false;
	private var dimRate:Float = 0.75; // Adjust this rate as needed

	private var flickering:Bool = false;
	private var flickerRate:Float = 1.75; // Time between flickers in seconds

	public static var animatronicInRoomRed:Bool = false;
	public static var animatronicInRoomRed2:Bool = false;
	public static var animatronicInRoomRed3:Bool = false;
	public static var animatronicInRoomRed4:Bool = false;
	public static var animatronicInRoomRed5:Bool = false;

	public static var animatronicInRoomBlue:Bool = false;
	public static var animatronicInRoomBlue2:Bool = false;
	public static var animatronicInRoomBlue3:Bool = false;
	public static var animatronicInRoomBlue4:Bool = false;
	public static var animatronicInRoomBlue5:Bool = false;

	var goodJobSound:FlxSound;

	final INITIALNUMBER:Int = 0;

	var muteButton:FlxSprite;

	var officeBlurry:FlxSprite;

	var mutted:Bool = false;

	public static var sonicIsNearOffice:Bool = false;
	
	var glitchString:String = "glitch";

	var timeHasPassed:Bool = false;

	var timeTxtNumber:String = "";

	var jumpscareAnimation:FlxSprite;
	var jumpscareAnimation2:FlxSprite;
	var jumpscareAnimation3:FlxSprite;

	public static var sonicGotFlashed:Bool = false;

	var	numbaTwelve:Bool = false;

	var	numbaOne:Bool = false;

	var	numbaTwo:Bool = false;

	var	numbaThree:Bool = false;

	var	numbaFour:Bool = false;

	var	numbaFive:Bool = false;

	var door:FlxSprite;

	var inGameHourPassed:Bool = false;

	var door2:FlxSprite;

	var timeSpriteTxt:FlxSprite;

	var monitorString:String = "monitor";

	var reverseString:String = "Reverse";

	public var pressedHonk:Bool = false;

	var endingSubText:FlxText;
	var endingSubText2:FlxText;

	var powerOutSound:FlxSound;

	var endTime:Float = 6; // End time (6 AM)
	var timer:FlxTimer = new FlxTimer();

	// var cursor:FlxSprite;

	public var subtitleText:FlxText;

	public var deathText:FlxText;

    var escapePressedTime:Float = 0;
    var isEscapePressed:Bool = false;
    var exitingText:FlxText;

	var winning:FlxSprite;

	var cinematicBars:FlxSprite;
	var cinematicBars2:FlxSprite;

	// Class member variables
	var targetX:Float = 50; // Start moving towards the right boundary
	var lerpSpeed:Float = 10; // How quickly we interpolate, between 0 and 1

	private static inline var FLIP_COOLDOWN:Float = 0.5;

	var animatronic:Animatronic;
	var animatronic2:Animatronic2;
	var animatronic3:Animatronic3;

	var discord:DiscordClient;

	public var batteryPower:Int = 100;
	var accumulatedTime:Float = 0;
    var decrementInterval:Float; // 10 second

	var toolCounter:Int;

	public var totalTime:Float = 540 * 1000;
	public var totalTimeGoingDown:Float;

	private var toolCounterIncremented:Bool = false;
	private var toolCounterIncremented2:Bool = false;
	private var toolCounterIncremented3:Bool = false;
	private var toolCounterIncremented4:Bool = false;

	private var toolCounterReverseIncremented:Bool = false;
	private var toolCounterReverseIncremented2:Bool = false;
	private var toolCounterReverseIncremented3:Bool = false;
	private var toolCounterReverseIncremented4:Bool = false;

	var red:FlxSprite;

	var flicker:Bool = false;
	var flickerTimer:Float = 0; // Timer that counts down to next flicker
	var flickerCooldown:Float = 1; // Cooldown in seconds between flickers

	var alphaDelta:Float = 0.5; // Adjust the rate of alpha change as needed

	var randomLineIndex:Int = Math.floor(Math.random() * 7) + 1;
	var randomLineIndex2:Int = Math.floor(Math.random() * 4) + 1;

	private var pauseTime:Int = 0; // Time when the game was paused
	private var accumulatedElapsedTime:Int = 0; // Total elapsed time before the last pause

	var startTime:Float = Date.now().getTime() / 1000; // Current epoch time in seconds
	var duration:Float = 540; // Duration of the track in seconds
	
	override public function create():Void
	{
		FlxG.mouse.visible = true;

		Animatronic.youAreDead = false;
		Animatronic2.youAreDead = false;
		Animatronic3.youAreDead = false;

		var image:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "muteButton" + PathsInGame.png);
		var image2:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "gameOverBG" + PathsInGame.png);
		var image3:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "gameOver" + PathsInGame.png);
		var image4:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "gameOverLight" + PathsInGame.png);
		var image5:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "Office" + PathsInGame.png);
		var image6:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "Office2" + PathsInGame.png);
		var image7:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "door" + PathsInGame.png);
		var image8:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "OfficeBlurry" + PathsInGame.png);
		var image9:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "doorHallway" + PathsInGame.png);
		var image10:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "sonicAtDoor" + PathsInGame.png);
		var image11:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "doorHallwayBlurry" + PathsInGame.png);
		var image12:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "jumpscares/blue_baby_jumpscare" + PathsInGame.png);
		var image13:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "jumpscares/SONIC" + PathsInGame.png);
		var image14:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "jumpscares/goldenFreddyJumpscare" + PathsInGame.png);
		var image15:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "deadjumpscare" + PathsInGame.png);
		var image16:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "turning" + PathsInGame.png);
		var image17:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "win" + PathsInGame.png);
		var image18:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "numbers" + PathsInGame.png);
		var image19:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene1" + PathsInGame.png);
		var image20:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene1Animatronic" + PathsInGame.png);
		var image21:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene2Animatronic" + PathsInGame.png);
		var image22:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene3Animatronic" + PathsInGame.png);
		var image23:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene4Animatronic" + PathsInGame.png);
		var image24:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene5Animatronic" + PathsInGame.png);
		var image25:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene1AnimatronicBlue" + PathsInGame.png);
		var image26:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene2AnimatronicBlue" + PathsInGame.png);
		var image27:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene3AnimatronicBlue" + PathsInGame.png);
		var image28:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene4AnimatronicBlue" + PathsInGame.png);
		var image29:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene5AnimatronicBlue" + PathsInGame.png);
		var image30:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene1Animatronic2" + PathsInGame.png);
		var image31:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene2Animatronic2" + PathsInGame.png);
		var image32:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene3Animatronic2" + PathsInGame.png);
		var image33:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene4Animatronic2" + PathsInGame.png);
		var image34:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene5Animatronic2" + PathsInGame.png);
		var image35:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene2" + PathsInGame.png);
		var image36:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene3" + PathsInGame.png);
		var image37:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene4" + PathsInGame.png);
		var image38:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "camScene5" + PathsInGame.png);
		var image39:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + "map" + PathsInGame.png);
		var image40:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.menuPaths + PathsInGame.blackString + PathsInGame.png);
		var image41:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "Flashlight" + PathsInGame.png);
		var image42:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "battery" + PathsInGame.png);
		var image43:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.inGamePath + "cambutton" + PathsInGame.png);
		var image44:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.camFlipPath);
		var image45:Bitmap = AssetLoader.loadedBitmaps.get(PathsInGame.cameraPath + PathsInGame.staticString + PathsInGame.png);

		typeSound = FlxG.sound.load(PathsInGame.soundPath + "letter_sound" + PathsInGame.ogg);

		camSound = FlxG.sound.load(PathsInGame.soundPath + "camleave" + PathsInGame.ogg);

		camSound2 = FlxG.sound.load(PathsInGame.soundPath + "camenter" + PathsInGame.ogg);

		secondSound = FlxG.sound.load(PathsInGame.soundPath + "camloop" + PathsInGame.ogg);

		flashlightSound = FlxG.sound.load(PathsInGame.soundPath + "flashlight" + PathsInGame.ogg);

		phoneCall = FlxG.sound.load(PathsInGame.soundPath + "phonecall" + PathsInGame.ogg);

		changeCam = FlxG.sound.load(PathsInGame.soundPath + "changeCam" + PathsInGame.ogg);

		garbleSound = FlxG.sound.load(PathsInGame.soundPath + "garble" + PathsInGame.ogg);

		jumpscareSound = FlxG.sound.load(PathsInGame.soundPath + "boo" + PathsInGame.ogg);

		dedStaticSound = FlxG.sound.load(PathsInGame.soundPath + "dedstaticSound" + PathsInGame.ogg);

		endCall = FlxG.sound.load(PathsInGame.soundPath + "endCall" + PathsInGame.ogg);

		doorSound = FlxG.sound.load(PathsInGame.soundPath + "doorSound" + PathsInGame.ogg);

		sonicDiesSound = FlxG.sound.load(PathsInGame.soundPath + "sonicDies" + PathsInGame.ogg);

		powerOutSound = FlxG.sound.load(PathsInGame.soundPath + "powerdown" + PathsInGame.ogg);

		goodJobSound = FlxG.sound.load(PathsInGame.soundPath + "winning" + PathsInGame.ogg);

		kefkaLaugh = FlxG.sound.load(PathsInGame.soundPath + "deathLine" + randomLineIndex + PathsInGame.ogg);

		babyGrunt = FlxG.sound.load(PathsInGame.soundPath + "hurt_grunt_" + randomLineIndex2 + PathsInGame.ogg);

		honkSound = FlxG.sound.load(PathsInGame.soundPath + "honk" + PathsInGame.ogg);

		office_ambience = FlxG.sound.load(PathsInGame.musicPath + "office_ambience" + PathsInGame.ogg);

		animatronic = new Animatronic([0, 1, 2, 3, 4, 5, 6], "BlueBaby", 0);

		animatronic2 = new Animatronic2([0, 1, 2, 3, 4, 5, 6], "Sonic", 20);

		animatronic3 = new Animatronic3([0, 1, 2, 3, 4, 5, 6], "Golden Freddy", 0);

		muteButton = new FlxSprite();
		muteButton.loadGraphic(image.bitmapData);
		muteButton.visible = false;
		muteButton.x += 25;
		muteButton.y += 25;

		gitGud = new FlxSprite(0, 0);
		gitGud.loadGraphic(image2.bitmapData);
		gitGud.screenCenter(XY);
		gitGud.visible = false;
		gitGud.angle = -25;

		gitGud2 = new FlxSprite();
		gitGud2.loadGraphic(image3.bitmapData);
		gitGud2.screenCenter(XY);
		gitGud2.visible = false;
		gitGud2.angle = -25;
		FlxTween.tween(gitGud2, {y: gitGud2.y + 25}, 2.6, {ease: FlxEase.quadInOut, type: PINGPONG});

		gitGud3 = new FlxSprite();
		gitGud3.loadGraphic(image4.bitmapData);
		gitGud3.screenCenter(XY);
		gitGud3.visible = false;
		gitGud3.angle = -25;

		cinematicBars = new FlxSprite(0, 900).makeGraphic(3000, 100, FlxColor.BLACK);
		cinematicBars.scrollFactor.set(0, 0);
		cinematicBars.screenCenter(X);
		cinematicBars.updateHitbox();
		cinematicBars.visible = false;

		cinematicBars2 = new FlxSprite(0, -900).makeGraphic(3000, 100, FlxColor.BLACK);
		cinematicBars2.scrollFactor.set(0, 0);
		cinematicBars2.screenCenter(X);
		cinematicBars2.updateHitbox();
		cinematicBars2.visible = false;

		mutePhoneHitbox = new FlxSprite(muteButton.x, muteButton.y).makeGraphic(150, 125, FlxColor.BLACK);
		mutePhoneHitbox.scrollFactor.set(0, 0);
		mutePhoneHitbox.updateHitbox();
		mutePhoneHitbox.visible = false;

		cam1ButtonHitbox = new FlxSprite(1015, 375).makeGraphic(30, 25, FlxColor.RED);
		cam1ButtonHitbox.scrollFactor.set(0, 0);
		cam1ButtonHitbox.updateHitbox();
		cam1ButtonHitbox.visible = false;

		cam2ButtonHitbox = new FlxSprite(1000, 435).makeGraphic(30, 25, FlxColor.RED);
		cam2ButtonHitbox.scrollFactor.set(0, 0);
		cam2ButtonHitbox.updateHitbox();
		cam2ButtonHitbox.visible = false;

		cam3ButtonHitbox = new FlxSprite(900, 465).makeGraphic(30, 25, FlxColor.RED);
		cam3ButtonHitbox.scrollFactor.set(0, 0);
		cam3ButtonHitbox.updateHitbox();
		cam3ButtonHitbox.visible = false;

		cam4ButtonHitbox = new FlxSprite(955, 515).makeGraphic(30, 25, FlxColor.RED);
		cam4ButtonHitbox.scrollFactor.set(0, 0);
		cam4ButtonHitbox.updateHitbox();
		cam4ButtonHitbox.visible = false;

		cam5ButtonHitbox = new FlxSprite(940, 608).makeGraphic(30, 25, FlxColor.RED);
		cam5ButtonHitbox.scrollFactor.set(0, 0);
		cam5ButtonHitbox.updateHitbox();
		cam5ButtonHitbox.visible = false;

		office = new FlxSprite();
		office.loadGraphic(image5.bitmapData);
		office.screenCenter(XY);
		office.scrollFactor.set(1, 1);
		office.scale.x = 1.1;
		office.scale.y = 1.1;

		office2 = new FlxSprite();
		office2.loadGraphic(image6.bitmapData);
		office2.screenCenter(XY);
		office2.y += 225;
		office2.scrollFactor.set(0.4, 0.4);
		office2.scale.x = 1;
		office2.scale.y = 1;

		door = new FlxSprite();
		door.loadGraphic(image7.bitmapData);
		door.screenCenter(XY);
		door.scrollFactor.set(1, 1);
		door.scale.y = 1.1;
		door.scale.x = 1.05;
		door.y -= 47;

		subtitleText = new FlxText(0, 0, 2450, "", 28);
		subtitleText.setFormat(PathsInGame.fontPath3, 28, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		subtitleText.scrollFactor.set(0,0);
		subtitleText.borderSize = 1.25;
		subtitleText.screenCenter(XY);
		subtitleText.y += 335;

		deathText = new FlxText(0, 0, 2450, "", 50);
		deathText.setFormat(PathsInGame.fontPath4, 50, FlxColor.RED, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		deathText.scrollFactor.set(0,0);
		deathText.borderSize = 1.25;
		deathText.screenCenter(XY);
		deathText.visible = false;
		deathText.y += 225;

		door2 = new FlxSprite();
		door2.loadGraphic(image7.bitmapData);
		door2.screenCenter(XY);
		door2.scrollFactor.set(1, 1);
		door2.scale.y = 1.1;
		door2.scale.x = 1.05;
		door2.y -= 47;

		officeBlurry = new FlxSprite();
		officeBlurry.loadGraphic(image8.bitmapData);
		officeBlurry.screenCenter(XY);
		officeBlurry.visible = false;

		doorHallway = new FlxSprite();
		doorHallway.loadGraphic(image9.bitmapData);
		doorHallway.screenCenter(XY);
		doorHallway.visible = false;

		doorHallway2 = new FlxSprite();
		doorHallway2.loadGraphic(image10.bitmapData);
		doorHallway2.screenCenter(XY);
		doorHallway2.y += 175;
		doorHallway2.visible = false;

		doorHallwayBlurry = new FlxSprite();
		doorHallwayBlurry.loadGraphic(image11.bitmapData);
		doorHallwayBlurry.screenCenter(XY);
		doorHallwayBlurry.x += 2000;

		jumpscareAnimation = new FlxSprite(0, 0, image12.bitmapData);
		jumpscareAnimation.frames = FlxAtlasFrames.fromSparrow(image12.bitmapData, PathsInGame.inGamePath + "jumpscares/blue_baby_jumpscare" + PathsInGame.xml);
		jumpscareAnimation.animation.addByPrefix("foxScare", "2spooky4me0", 24, false);
		jumpscareAnimation.visible = false;
		jumpscareAnimation.screenCenter(XY);

		jumpscareAnimation2 = new FlxSprite(0, 0, image13.bitmapData);
		jumpscareAnimation2.frames = FlxAtlasFrames.fromSparrow(image13.bitmapData, PathsInGame.inGamePath + "jumpscares/SONIC" + PathsInGame.xml);
		jumpscareAnimation2.animation.addByPrefix("bonScare", "JUMP AAAH", 24, false);
		jumpscareAnimation2.visible = false;
		jumpscareAnimation2.screenCenter(XY);

		jumpscareAnimation3 = new FlxSprite(0, 0, image14.bitmapData);
		jumpscareAnimation3.frames = FlxAtlasFrames.fromSparrow(image14.bitmapData, PathsInGame.inGamePath + "jumpscares/goldenFreddyJumpscare" + PathsInGame.xml);
		jumpscareAnimation3.animation.addByPrefix("goldScare", "goldenFreddyJumpscare goldenJump0", 24, false);
		jumpscareAnimation3.visible = false;
		jumpscareAnimation3.screenCenter(XY);

		dedStatic = new FlxSprite(0, 0, image15.bitmapData);
		dedStatic.frames = FlxAtlasFrames.fromSparrow(image15.bitmapData, PathsInGame.inGamePath + "deadjumpscare" + PathsInGame.xml);
		dedStatic.animation.addByPrefix("ds", "deadjumpscare dedstatic0", 24, true);
		dedStatic.visible = false;
		dedStatic.screenCenter(XY);

		turning = new FlxSprite(office.x, office.y, image16.bitmapData);
		turning.frames = FlxAtlasFrames.fromSparrow(image16.bitmapData, PathsInGame.inGamePath + "turning" + PathsInGame.xml);
		turning.animation.addByPrefix("turning", "turning Turns0", 24, false);
		turning.animation.addByPrefix("back", "turning back0", 24, false);
		turning.visible = false;
		turning.scale.x = 1.1;
		turning.scale.y = 1.1;
		turning.x += 35;
		turning.y += 45;

		winning = new FlxSprite(0, 0, image17.bitmapData);
		winning.frames = FlxAtlasFrames.fromSparrow(image17.bitmapData, PathsInGame.inGamePath + "win" + PathsInGame.xml);
		winning.animation.addByPrefix("win", "win!", 12, false);
		winning.screenCenter(XY);
		winning.scale.x = 0.2;
		winning.scale.y = 0.2;
		winning.alpha = 0;

		timeSpriteTxt = new FlxSprite(0, 0, image18.bitmapData);
		timeSpriteTxt.frames = FlxAtlasFrames.fromSparrow(image18.bitmapData, PathsInGame.inGamePath + "numbers" + PathsInGame.xml);
		timeSpriteTxt.animation.addByPrefix("twelve", 	"numbaers0000", 24, false);
		timeSpriteTxt.animation.addByPrefix("one", 		"numbaers0001", 24, false);
		timeSpriteTxt.animation.addByPrefix("two", 		"numbaers0002", 24, false);
		timeSpriteTxt.animation.addByPrefix("three",	"numbaers0003", 24, false);
		timeSpriteTxt.animation.addByPrefix("four", 	"numbaers0004", 24, false);
		timeSpriteTxt.animation.addByPrefix("five", 	"numbaers0005", 24, false);
		timeSpriteTxt.animation.addByPrefix("six", 		"numbaers0006", 24, false);
		timeSpriteTxt.screenCenter(XY);
		timeSpriteTxt.scale.x = 0.35;
		timeSpriteTxt.scale.y = 0.35;
		timeSpriteTxt.y += 90;

		camFlip = new FlxSprite(-150, -100, image44.bitmapData);
		camFlip.frames = FlxAtlasFrames.fromSparrow(image44.bitmapData, PathsInGame.inGamePath + "camera" + PathsInGame.flipString + PathsInGame.xml);
		camFlip.animation.addByPrefix(PathsInGame.flipString, monitorString + PathsInGame.flipString + "0", 24, false);
		camFlip.animation.addByPrefix(PathsInGame.flipString + reverseString, monitorString + PathsInGame.flipString + reverseString + "0", 24, false);
		camFlip.visible = false;

		camStatic = new FlxSprite(0, 0);
		camStatic.frames = FlxAtlasFrames.fromSparrow(image45.bitmapData, PathsInGame.cameraPath + PathsInGame.staticString + PathsInGame.xml);
		camStatic.animation.addByPrefix(glitchString, "glitchy", 24, false); // Assuming 'glitchy' is the correct prefix in the XML
		camStatic.animation.addByPrefix(PathsInGame.staticString, "statik", 24, false);
		camStatic.visible = false;		

		cam1 = new FlxSprite();
		cam1.loadGraphic(image19.bitmapData);
		cam1.screenCenter(XY);
		cam1.visible = false;

		cam1AnimatronicRed = new FlxSprite();
		cam1AnimatronicRed.loadGraphic(image20.bitmapData);
		cam1AnimatronicRed.screenCenter(XY);
		cam1AnimatronicRed.visible = false;

		cam2AnimatronicRed = new FlxSprite();
		cam2AnimatronicRed.loadGraphic(image21.bitmapData);
		cam2AnimatronicRed.screenCenter(XY);
		cam2AnimatronicRed.visible = false;

		cam3AnimatronicRed = new FlxSprite();
		cam3AnimatronicRed.loadGraphic(image22.bitmapData);
		cam3AnimatronicRed.screenCenter(XY);
		cam3AnimatronicRed.visible = false;

		cam4AnimatronicRed = new FlxSprite();
		cam4AnimatronicRed.loadGraphic(image23.bitmapData);
		cam4AnimatronicRed.screenCenter(XY);
		cam4AnimatronicRed.visible = false;

		cam5AnimatronicRed = new FlxSprite();
		cam5AnimatronicRed.loadGraphic(image24.bitmapData);
		cam5AnimatronicRed.screenCenter(XY);
		cam5AnimatronicRed.visible = false;

		cam1AnimatronicBlue = new FlxSprite();
		cam1AnimatronicBlue.loadGraphic(image25.bitmapData);
		cam1AnimatronicBlue.screenCenter(XY);
		cam1AnimatronicBlue.visible = false;

		cam2AnimatronicBlue = new FlxSprite();
		cam2AnimatronicBlue.loadGraphic(image26.bitmapData);
		cam2AnimatronicBlue.screenCenter(XY);
		cam2AnimatronicBlue.visible = false;

		cam3AnimatronicBlue = new FlxSprite();
		cam3AnimatronicBlue.loadGraphic(image27.bitmapData);
		cam3AnimatronicBlue.screenCenter(XY);
		cam3AnimatronicBlue.visible = false;

		cam4AnimatronicBlue = new FlxSprite();
		cam4AnimatronicBlue.loadGraphic(image28.bitmapData);
		cam4AnimatronicBlue.screenCenter(XY);
		cam4AnimatronicBlue.visible = false;

		cam5AnimatronicBlue = new FlxSprite();
		cam5AnimatronicBlue.loadGraphic(image29.bitmapData);
		cam5AnimatronicBlue.screenCenter(XY);
		cam5AnimatronicBlue.visible = false;

		cam1AnimatronicRedBlue = new FlxSprite();
		cam1AnimatronicRedBlue.loadGraphic(image30.bitmapData);
		cam1AnimatronicRedBlue.screenCenter(XY);
		cam1AnimatronicRedBlue.visible = false;

		cam2AnimatronicRedBlue = new FlxSprite();
		cam2AnimatronicRedBlue.loadGraphic(image31.bitmapData);
		cam2AnimatronicRedBlue.screenCenter(XY);
		cam2AnimatronicRedBlue.visible = false;

		cam3AnimatronicRedBlue = new FlxSprite();
		cam3AnimatronicRedBlue.loadGraphic(image32.bitmapData);
		cam3AnimatronicRedBlue.screenCenter(XY);
		cam3AnimatronicRedBlue.visible = false;

		cam4AnimatronicRedBlue = new FlxSprite();
		cam4AnimatronicRedBlue.loadGraphic(image33.bitmapData);
		cam4AnimatronicRedBlue.screenCenter(XY);
		cam4AnimatronicRedBlue.visible = false;

		cam5AnimatronicRedBlue = new FlxSprite();
		cam5AnimatronicRedBlue.loadGraphic(image34.bitmapData);
		cam5AnimatronicRedBlue.screenCenter(XY);
		cam5AnimatronicRedBlue.visible = false;

		cam2 = new FlxSprite(-150);
		cam2.loadGraphic(image35.bitmapData);
		cam2.screenCenter(XY);
		cam2.visible = false;
		cam2.scale.x = 1.25;
		cam2.scale.y = 1.25;
		cam2.y += 75;

		cam3 = new FlxSprite(-150);
		cam3.loadGraphic(image36.bitmapData);
		cam3.screenCenter(Y);
		cam3.scale.x = 1.25;
		cam3.scale.y = 1.25;
		cam3.visible = false;
		cam3.y += 75;

		cam4 = new FlxSprite();
		cam4.loadGraphic(image37.bitmapData);
		cam4.screenCenter(XY);
		cam4.visible = false;

		cam5 = new FlxSprite();
		cam5.loadGraphic(image38.bitmapData);
		cam5.screenCenter(XY);
		cam5.scale.x = 1.25;
		cam5.scale.y = 1.25;
		cam5.visible = false;
		cam5.x -= 150;

		map = new FlxSprite(895, 350, image39.bitmapData);
		map.frames = FlxAtlasFrames.fromSparrow(image39.bitmapData, PathsInGame.cameraPath + "map" + PathsInGame.xml);
		map.animation.addByPrefix("dining", "diningroom0", 24, false);
		map.animation.addByPrefix("stage", "stage0", 24, false);
		map.animation.addByPrefix("cove", "foxycove0", 24, false);
		map.animation.addByPrefix("backroom", "backroom0", 24, false);
		map.animation.addByPrefix("closet", "closet0", 24, false);
		map.visible = false;

		black = new FlxSprite();
		black.loadGraphic(image40.bitmapData);
		black.screenCenter(XY);

		black3 = new FlxSprite();
		black3.loadGraphic(image40.bitmapData);
		black3.screenCenter(XY);
		black3.alpha = 0;

		black2 = new FlxSprite();
		black2.loadGraphic("assets/images/inGame/Background" + PathsInGame.png);
		black2.screenCenter(XY);
		black2.visible = false;

		black5 = new FlxSprite();
		black5.loadGraphic(image40.bitmapData);
		black5.screenCenter(XY);
		black5.visible = false;

		flashLight = new FlxSprite();
		flashLight.loadGraphic(image41.bitmapData);
		flashLight.screenCenter(XY);
		flashLight.visible = false;

		timeTxt = new FlxText(0, 0, 800, "", 64);
		timeTxt.setFormat(PathsInGame.fontPath, 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		timeTxt.scrollFactor.set(0,0);
		timeTxt.borderSize = 1.25;
		timeTxt.screenCenter(XY);
		timeTxt.y -= 50;

		endingSubText = new FlxText(0, 0, 850, "Welp, you did a great job out there.", 50);
		endingSubText.setFormat(PathsInGame.fontPath3, 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		endingSubText.scrollFactor.set(0,0);
		endingSubText.borderSize = 1.25;
		endingSubText.screenCenter(XY);
		endingSubText.y += 225;
		endingSubText.visible = false;

		endingSubText2 = new FlxText(0, 0, 850, "See you tomorrow!", 50);
		endingSubText2.setFormat(PathsInGame.fontPath3, 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		endingSubText2.scrollFactor.set(0,0);
		endingSubText2.borderSize = 1.25;
		endingSubText2.screenCenter(XY);
		endingSubText2.y += 225;
		endingSubText2.visible = false;


		timeTxt2 = new FlxText(0, timeTxt.y + 75, 800, "", 64);
		timeTxt2.setFormat(PathsInGame.fontPath, 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		timeTxt2.scrollFactor.set(0,0);
		timeTxt2.borderSize = 1.25;
		timeTxt2.screenCenter(X);

		batteryPowerSprite = new FlxSprite(0, 0, image42.bitmapData);
		batteryPowerSprite.frames = FlxAtlasFrames.fromSparrow(image42.bitmapData, PathsInGame.inGamePath + "battery" + PathsInGame.xml);
		batteryPowerSprite.animation.addByPrefix("full", "chargeFull0", 24, false);
		batteryPowerSprite.animation.addByPrefix("almostFull", "chargeAlmostFull0", 24, false);
		batteryPowerSprite.animation.addByPrefix("half", "chargeHalf0", 24, false);
		batteryPowerSprite.animation.addByPrefix("almostEmpty", "chargeAlmostEmpty0", 24, false);
		batteryPowerSprite.animation.addByPrefix("empty", "chargeEmpty0", 24, false);
		batteryPowerSprite.screenCenter(XY);
		batteryPowerSprite.scale.x = 0.7;
		batteryPowerSprite.scale.y = 0.7;
		batteryPowerSprite.y += 155;

		batteryPowerTxt = new FlxText(0, 0, 800, batteryPower + "%", 26);
		batteryPowerTxt.setFormat(PathsInGame.fontPath2, 26, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		batteryPowerTxt.scrollFactor.set(0,0);
		batteryPowerTxt.screenCenter(XY);
		batteryPowerTxt.borderSize = 1.25;
		batteryPowerTxt.y += 155;
		batteryPowerTxt.alpha = 0.86;

		// Initialize the 'exiting' FlxText
		exitingText = new FlxText(0, 0, FlxG.width, "Exiting...");
		exitingText.setFormat(null, 8, FlxColor.WHITE, LEFT, FlxTextBorderStyle.SHADOW, FlxColor.BLACK);
		exitingText.alpha = 0;
		//exitingText.screenPosition.set(FlxG.width - exitingText.width - 10, 10); // Position in the top-right corner

		camButtonHitbox = new FlxSprite(0, 600).makeGraphic(575, 65, FlxColor.BLACK);
		camButtonHitbox.scrollFactor.set(0, 0);
		camButtonHitbox.updateHitbox();
		camButtonHitbox.screenCenter(X);
		camButtonHitbox.visible = false;

		honkHitbox = new FlxSprite(0, 390).makeGraphic(25, 25, FlxColor.BLACK);
		honkHitbox.scrollFactor.set(0, 0);
		honkHitbox.updateHitbox();
		honkHitbox.screenCenter(X);
		honkHitbox.visible = false;

		red = new FlxSprite(0, 0).makeGraphic(1280, 720, FlxColor.RED);
		red.scrollFactor.set(0, 0);
		red.updateHitbox();
		red.screenCenter(X);
		red.alpha = 0;

		cambutton = new FlxSprite();
		cambutton.loadGraphic(image43.bitmapData);
		cambutton.screenCenter(XY);

		cambutton.y += 275;

		timeTxtNumber = "12";

		// cursor = new FlxSprite();
		// cursor.loadGraphic(TitleScreenState.cursorPath + TitleScreenState.png);
		// cursor.scale.x = 0.4;
		// cursor.scale.y = 0.4;

		FlxG.mouse.visible = true;
		FlxG.mouse.enabled = true;

		FlxTween.tween(door, {y: door.y - 275}, 0.2, {ease: FlxEase.linear});
			
		FlxTween.tween(door2, {y: door2.y - 275}, 0.2, {ease: FlxEase.linear});

		if(FlxG.save.data.nightOneNotCompleted == null) FlxG.save.data.nightOneNotCompleted = true;

		add(door);

		add(door2);

		add(office);
		add(office2);

		add(honkHitbox);

		add(turning);

		add(officeBlurry);

		add(doorHallway2);

		add(doorHallway);

		add(timeSpriteTxt);

		add(batteryPowerSprite);

		add(batteryPowerTxt);

		add(flashLight);
		
		add(doorHallwayBlurry);

		//add(black2);

		add(black5);

		add(jumpscareAnimation);
		add(jumpscareAnimation2);
		add(jumpscareAnimation3);

		add(camFlip);

		add(cam1);

		add(cam1AnimatronicRed);

		add(cam1AnimatronicBlue);

		add(cam1AnimatronicRedBlue);

		add(cam2);

		add(cam2AnimatronicRed);

		add(cam2AnimatronicBlue);

		add(cam2AnimatronicRedBlue);

		add(cam3);

		add(cam3AnimatronicRed);

		add(cam3AnimatronicBlue);

		add(cam3AnimatronicRedBlue);

		add(cam4);

		add(cam4AnimatronicRed);

		add(cam4AnimatronicBlue);

		add(cam4AnimatronicRedBlue);

		add(cam5);

		add(cam5AnimatronicRed);

		add(cam5AnimatronicBlue);

		add(cam5AnimatronicRedBlue);

		add(camStatic);

		add(cam1ButtonHitbox);
		add(cam2ButtonHitbox);
		add(cam3ButtonHitbox);
		add(cam4ButtonHitbox);
		add(cam5ButtonHitbox);

		add(cambutton);

		add(map);

		new FlxTimer().start(25, function(tmr:FlxTimer)
		{
			queuePhoneCall();

			animatronic.activate();
			animatronic2.activate();
			animatronic3.activate();
		});


		phoneCallDialogueNightOne();

		new FlxTimer().start(87, function(tmr:FlxTimer)
		{
			timeHasPassed = true;
		});


		add(black);

		add(winning);

		add(subtitleText);

		add(endingSubText);
		add(endingSubText2);

		add(timeTxt);

		add(timeTxt2);

		confetti = new ConfettiEmitter(30, 10);
		insert(50, confetti.confettiColorPools);

		add(muteButton);

		add(mutePhoneHitbox);

		typeTitle();

		add(gitGud);

		add(gitGud2);

		add(gitGud3);

		add(cinematicBars);

		add(cinematicBars2);

		add(red);

		add(deathText);

		add(black3);

		add(dedStatic);

		add(exitingText);

		super.create();
	}	

	private function onGameFocusLost():Void {
		gameHasFocus = false;
		trace("The Game is Paused");
	}
	
	private function onGameFocusGained():Void {
		gameHasFocus = true;
		trace("The Game is not Paused");
	}	

	public function typeTitle(): Void {
		if (index < toAdd.length) {
			currentAddition += toAdd.charAt(index);
			timeTxt.text = currentAddition;
			index++;
			typeSound.play(); // Play the typing sound for each character
	
			// Check if we just finished "12 A.M."
			if (index == toAdd.length) {
				// Set a longer delay to create a pause between "12 A.M." and "NIGHT 1"
				Timer.delay(typeNight, 1000); // 1000ms or 1 second delay before starting "NIGHT 1"
			}
			else if (currentAddition == "12 ") {
				// Set a longer delay to create a pause between "12" and "A.M."
				Timer.delay(typeTitle, 1000); // 1000ms or 1 second delay
			}  else {
				// Continue with the regular pace of typing
				Timer.delay(typeTitle, 220); // Regular pace for other characters
			}
		}
	}
	
	public function typeNight(): Void {

		var nightText:String = "";

		if(FlxG.save.data.nightOneNotCompleted)
		{
			nightText = toAdd2;
		}

		if(FlxG.save.data.nightOneCompleted)
		{
			nightText = toAdd3;
		}

		if(FlxG.save.data.nightTwoCompleted)
		{
			nightText = toAdd4;
		}

		if(FlxG.save.data.nightThreeCompleted)
		{
			nightText = toAdd5;
		}

		if(FlxG.save.data.nightFourCompleted)
		{
			nightText = toAdd6;
		}

		if (index2 < nightText.length) {
			currentAddition2 += nightText.charAt(index2);
			timeTxt2.text = currentAddition2;
			index2++;
			typeSound.play(); // Play the typing sound for "NIGHT 1"
	
			if (index2 == nightText.length) {
				Timer.delay(fadeOut, 1000); // 1000ms or 1 second delay before starting "NIGHT 1"
			}
			if (currentAddition2 == "NIGHT ") {
				// Set a longer delay to create a pause between "Night" and "1"
				Timer.delay(typeNight, 1000); // 1000ms or 1 second delay
			} else {
				// Otherwise, continue with the regular pace of typing
				Timer.delay(typeNight, 220); // Regular pace for other characters
			}
		}
	}

	public function phoneCallDialogueNightOne():Void {
		var timerData:Array<TimerData> = [
			new TimerData(31.3, "Hello?"),
			new TimerData(32.9, "Hey there!"),
			new TimerData(33.7, "You're finally up!"),
			new TimerData(35.15, "Well- technically not but"),
			new TimerData(37.2, "You're here..."),
			new TimerData(38.53, "You are in a place called"),
			new TimerData(40, "Soy's Dreams Diner"),
			new TimerData(41.7, "and theres a bit of a plot twist right here-"),
			new TimerData(44.45, "So...there's these weird creatures or entities"),
			new TimerData(48, "whatever you want to call them"),
			new TimerData(49.42, "that are your fears..."),
			new TimerData(51.01, "right?"),
			new TimerData(51.57, "so they should be s...cary looking, I guess?"),
			new TimerData(54.99, "Thats on you."),
			new TimerData(55.7, ""),
			new TimerData(56.715, "anyways"),
			new TimerData(57.4, "I'm your inner voice"),
			new TimerData(58.55, "and im trying to guide you"),
			new TimerData(60.08, "to guide you to survive this crazy ass dream"),
			new TimerData(62.3, ""),
			new TimerData(63.593, "there are 2 doors infront of you and one behind you"),
			new TimerData(67.3, "make sure to look behind really often because..."),
			new TimerData(70.73, "creatures might get inside from there..."),
			new TimerData(72.58, "so yeah!"),
			new TimerData(73.16, ""),
			new TimerData(74, "you have to survive from 12 AM to 6 AM"),
			new TimerData(77.1, ""),
			new TimerData(78.05, "and..."),
			new TimerData(79.22, "that's pretty much all i can say for now...."),
			new TimerData(81.45, "good luck and just try to not die!"),
			new TimerData(84.47, "Okay?"),
			new TimerData(85.51, "Alright"),
			new TimerData(86.11, "see ya!"),
			new TimerData(86.7, "")
		];
	
		for (data in timerData) {
			var timer = new FlxTimer();
			timer.start(data.time, function(tmr:FlxTimer) {
				subtitleText.text = data.text;
			}, 1);
		}
	}	

	public function fadeOut():Void{
		FlxTween.tween(timeTxt, {alpha: 0}, 4, {ease: FlxEase.quadInOut});
		FlxTween.tween(timeTxt2, {alpha: 0}, 4, {
			ease: FlxEase.quadInOut, 
			onComplete: function(twn:FlxTween) {
				FlxTween.tween(black, {alpha: 0}, 4, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween) {
						office_ambience.play();
						//FlxG.sound.music.fadeIn(4, 0, 0.7);
					}
				});
			}
		});
	}

	// Add a method in PlayState to reset visibility flags
	public static function resetAnimatronicsVisibility():Void {
		animatronicInRoomRed = animatronicInRoomBlue = animatronicInRoomRed2 = animatronicInRoomBlue2 = animatronicInRoomRed3 = animatronicInRoomBlue3 = animatronicInRoomRed4 = animatronicInRoomBlue4 = animatronicInRoomRed5 = animatronicInRoomBlue5 = false;
	}

	public function queuePhoneCall():Void{
		if(mutted == false && !won && black5.visible != true && black.alpha == 0)
		{
			phoneCall.play();
			muteButton.visible = true;
		}
	}

	public function jumpscare():Void {
		if (!dead && map.visible == false && notTurned) {
			jumpscareSound.play();
			canLook = false;
			dead = true;
	
			// Determine which animatronic caused the jumpscare
			var animatronicJumpscare:AnimatronicType = getAnimatronicJumpscare();
	
			if (animatronicJumpscare != null) {
				performJumpscare(animatronicJumpscare);
			}
		}
	}
	
	private function getAnimatronicJumpscare():AnimatronicType {
		if (Animatronic.babyGotYou) return AnimatronicType.BlueBaby;
		if (Animatronic2.sonicGotYou) return AnimatronicType.Sonic;
		if (Animatronic3.goldenFreddyGotYou) return AnimatronicType.GoldenFreddy;
		return null;
	}
	
	private function performJumpscare(animatronicJumpscare:AnimatronicType):Void {
		var jumpscareAnim:FlxSprite = getJumpscareAnimation(animatronicJumpscare);
		jumpscareAnim.visible = true;
		jumpscareAnim.animation.play(getAnimatronicJumpscareAnimation(animatronicJumpscare), false);
	
		jumpscareAnim.animation.finishCallback = function(_:String):Void {
			commonJumpscareEnd();
		};
	}
	
	private function getJumpscareAnimation(animatronicJumpscare:AnimatronicType):FlxSprite {
		switch(animatronicJumpscare) {
			case AnimatronicType.BlueBaby: return jumpscareAnimation;
			case AnimatronicType.Sonic: return jumpscareAnimation2;
			case AnimatronicType.GoldenFreddy: return jumpscareAnimation3;
		}
	}
	
	private function getAnimatronicJumpscareAnimation(animatronicJumpscare:AnimatronicType):String {
		switch(animatronicJumpscare) {
			case AnimatronicType.BlueBaby: return "foxScare";
			case AnimatronicType.Sonic: return "bonScare";
			case AnimatronicType.GoldenFreddy: return "goldScare";
		}
	}
	
	private function commonJumpscareEnd():Void {
		if (!won) {
			red.alpha = 1;
			FlxTween.tween(red, {alpha: 0}, 1);
			FlxG.sound.music.stop();
			jumpscareSound.stop();
			animatronic2.deactivate();
			// dedStaticSound.play();
			// dedStatic.visible = true;
			// dedStatic.animation.play("ds", true);
			black.alpha = 1;
			mutted = true;
			phoneCall.stop();

			FlxG.sound.playMusic(PathsInGame.musicPath + "death" + PathsInGame.ogg, 1, false);
	
			// dedStaticSound.stop();
			cinematicBars.visible = true;
			cinematicBars2.visible = true;
			// FlxTween.tween(dedStatic, {alpha: 0}, 1, {ease: FlxEase.quadInOut});
			gitGud.visible = true;
			gitGud2.visible = true;
			gitGud3.visible = true;

			FlxTween.tween(gitGud, {angle: 0}, 5, {ease: FlxEase.expoOut});
			FlxTween.tween(gitGud2, {angle: 0}, 5, {ease: FlxEase.expoOut});
			FlxTween.tween(gitGud3, {angle: 0}, 5, {ease: FlxEase.expoOut});

			FlxG.camera.zoom = 2.5;
			FlxTween.tween(FlxG.camera, {zoom: 1}, 5, {ease: FlxEase.expoOut});

			FlxTween.tween(cinematicBars2, {y: cinematicBars2.y + 900}, 4, {ease: FlxEase.expoInOut});
			FlxTween.tween(cinematicBars, {y: cinematicBars.y - 275}, 4, {ease: FlxEase.expoInOut});

			new FlxTimer().start(2, function(tmr:FlxTimer) {
				canPressEnter = true;
			});

			new FlxTimer().start(3, function(tmr:FlxTimer) {
				if (!powerOutSoundPlayed3) {
					if(Animatronic2.sonicGotYou)
					{
						DiscordClient.changePresence("GAME OVER - Sonic.EXE Killed You!", null);
						kefkaLaugh.play();
						powerOutSoundPlayed3 = true;
						switch(randomLineIndex)
						{
							case 1:
								deathText.text = "Ha Ha Ha Ha Ha Ha Ha Ha Ha Ha";
								deathText.visible = true;
								new FlxTimer().start(3.5, function(tmr:FlxTimer) {
									deathText.visible = false;
								});
							case 2:
								deathText.text = "So many souls to play with";
								deathText.visible = true;
								new FlxTimer().start(3.495, function(tmr:FlxTimer) {
									deathText.text = "So little time";
								});
								new FlxTimer().start(6.355, function(tmr:FlxTimer) {
									deathText.text = "Wouldn't you agree?";
								});
								new FlxTimer().start(8.9, function(tmr:FlxTimer) {
									deathText.visible = false;
								});
							case 3:
								deathText.text = "Wanna try again?";
								deathText.visible = true;
								new FlxTimer().start(3, function(tmr:FlxTimer) {
									deathText.visible = false;
								});
							case 4:
								deathText.text = "Game Over";
								deathText.visible = true;
								new FlxTimer().start(2.2, function(tmr:FlxTimer) {
									deathText.visible = false;
								});
							case 5:
								deathText.text = "You're in My World Now";
								deathText.visible = true;
								new FlxTimer().start(3.75, function(tmr:FlxTimer) {
									deathText.visible = false;
								});
							case 6:
								deathText.text = "You're too slow!";
								deathText.visible = true;
								new FlxTimer().start(2.8, function(tmr:FlxTimer) {
									deathText.visible = false;
								});
							case 7:
								deathText.text = "I";
								deathText.visible = true;
								new FlxTimer().start(1.9, function(tmr:FlxTimer) {
									deathText.text = "AM";
								});
								new FlxTimer().start(2.5, function(tmr:FlxTimer) {
									deathText.text = "GOD";
								});
								new FlxTimer().start(4.5, function(tmr:FlxTimer) {
									deathText.visible = false;
								});
						}
					}
					if(Animatronic.babyGotYou)
					{
						DiscordClient.changePresence("GAME OVER - ??? Killed You!", null);
						babyGrunt.play();
						powerOutSoundPlayed3 = true;
						switch(randomLineIndex2)
						{
							case 1:
								deathText.text = "Ah!";
								deathText.visible = true;
								deathText.setFormat(PathsInGame.fontPath5, 50, FlxColor.BLUE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
								new FlxTimer().start(0.3, function(tmr:FlxTimer) {
									deathText.visible = false;
								});
							case 2:
								deathText.text = "Eh!";
								deathText.visible = true;
								deathText.setFormat(PathsInGame.fontPath5, 50, FlxColor.BLUE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
								new FlxTimer().start(0.25, function(tmr:FlxTimer) {
									deathText.visible = false;
								});
							case 3:
								deathText.text = "Agh!";
								deathText.visible = true;
								deathText.setFormat(PathsInGame.fontPath5, 50, FlxColor.BLUE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
								new FlxTimer().start(0.36, function(tmr:FlxTimer) {
									deathText.visible = false;
								});
							case 4:
								deathText.setFormat(PathsInGame.fontPath5, 50, FlxColor.BLUE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
								new FlxTimer().start(0.1, function(tmr:FlxTimer) {
									deathText.text = "aooooo";
									deathText.visible = true;
								});
								deathText.visible = true;
								new FlxTimer().start(1.1, function(tmr:FlxTimer) {
									deathText.text = "ooogggggggggg";
								});
								new FlxTimer().start(3.5, function(tmr:FlxTimer) {
									deathText.text = "aaaaaaaaa";
								});
								new FlxTimer().start(8.5, function(tmr:FlxTimer) {
									deathText.visible = false;
								});
						}
					}
				}
			});
		}
	}

	private function makeCam1Visible(name:String):Void {
		map.visible = true;
		Animatronic2.sonicMoved = false;
		// Check for only Red animatronic in room
		if(animatronicInRoomRed && !animatronicInRoomBlue) {
			trace("Red animatronic present, Blue animatronic not present. -Cam1");
			cam1AnimatronicRed.visible = true;
			cam1AnimatronicBlue.visible = false;
			cam1AnimatronicRedBlue.visible = false;
			cam1.visible = false;
		}

		// Check for only Blue animatronic in room
		if(animatronicInRoomBlue && !animatronicInRoomRed) {
			trace("Blue animatronic present, Red animatronic not present. -Cam1");
			cam1AnimatronicRed.visible = false;
			cam1AnimatronicBlue.visible = true;
			cam1AnimatronicRedBlue.visible = false;
			cam1.visible = false;
		}

		// Check for both Red and Blue animatronics in room
		if(animatronicInRoomRed && animatronicInRoomBlue) {
			trace("Both Red and Blue animatronics present. -Cam1");
			cam1AnimatronicRed.visible = false;
			cam1AnimatronicBlue.visible = false;
			cam1AnimatronicRedBlue.visible = true;
			cam1.visible = false;
		}

		// Check for no animatronics in room
		if(!animatronicInRoomRed && !animatronicInRoomBlue) {
			trace("No animatronics present. -Cam1");
			cam1AnimatronicRed.visible = false;
			cam1AnimatronicBlue.visible = false;
			cam1AnimatronicRedBlue.visible = false;
			cam1.visible = true;
		}

		camStatic.visible = true;
		camStatic.alpha = 1; // Reset alpha to 1 before playing the animation
	
		// Start playing the "glitch" animation if it exists.
		if (camStatic.animation.exists(glitchString)) {
			camStatic.animation.play(glitchString, false);
			
			// Set a finish callback to reduce alpha after "glitch" animation finishes.
			camStatic.animation.finishCallback = function(_:String):Void {
				camStatic.alpha = 0.25; // Set the alpha to 0.5 once the "glitch" animation completes
				// Continue playing the "static" animation if it exists.
				if (camStatic.animation.exists(PathsInGame.staticString)) {
					camStatic.animation.play(PathsInGame.staticString, true); // Loop the "static" animation.
					startCameraPan();
				}
			};
		}
	}	

	private function makeCam2Visible(name:String):Void 
	{ 
		map.visible = true;
		Animatronic2.sonicMoved2 = false;
		if(animatronicInRoomRed2 && !animatronicInRoomBlue2)
		{
			trace("Red animatronic present, Blue animatronic not present. -Cam2");
			cam2AnimatronicRed.visible = true;
			cam2AnimatronicBlue.visible = false;
			cam2AnimatronicRedBlue.visible = false;
			cam2.visible = false;
		}
		
		if(animatronicInRoomBlue2 && !animatronicInRoomRed2)
		{
			trace("Blue animatronic present, Red animatronic not present. -Cam2");
			cam2AnimatronicRed.visible = false;
			cam2AnimatronicBlue.visible = true;
			cam2AnimatronicRedBlue.visible = false;
			cam2.visible = false;
		}
		
		if(animatronicInRoomRed2 && animatronicInRoomBlue2)
		{
			trace("Both Red and Blue animatronics present. -Cam2");
			cam2AnimatronicRed.visible = false;
			cam2AnimatronicBlue.visible = false;
			cam2AnimatronicRedBlue.visible = true;
			cam2.visible = false;
		}

		if(!animatronicInRoomRed2 && !animatronicInRoomBlue2)
		{
			trace("No animatronics present. -Cam2");
			cam2AnimatronicRed.visible = false;
			cam2AnimatronicBlue.visible = false;
			cam2AnimatronicRedBlue.visible = false;
			cam2.visible = true;
		}
		
		camStatic.visible = true;
		camStatic.alpha = 1; // Reset alpha to 1 before playing the animation
	
		// Start playing the "glitch" animation if it exists.
		if (camStatic.animation.exists(glitchString)) {
			camStatic.animation.play(glitchString, false);
			
			// Set a finish callback to reduce alpha after "glitch" animation finishes.
			camStatic.animation.finishCallback = function(_:String):Void {
				camStatic.alpha = 0.25; // Set the alpha to 0.5 once the "glitch" animation completes
				// Continue playing the "static" animation if it exists.
				if (camStatic.animation.exists(PathsInGame.staticString)) {
					camStatic.animation.play(PathsInGame.staticString, true); // Loop the "static" animation.
					startCameraPan();
				}
			};
		}
	}

	private function makeCam3Visible(name:String):Void 
	{ 
		map.visible = true;
		Animatronic2.sonicMoved3 = false;
		if(animatronicInRoomRed3 && !animatronicInRoomBlue3)
		{
			trace("Red animatronic present, Blue animatronic not present. -Cam3");
			cam3AnimatronicRed.visible = true;
			cam3AnimatronicBlue.visible = false;
			cam3AnimatronicRedBlue.visible = false;
			cam3.visible = false;
		}
		
		if(animatronicInRoomBlue3 && !animatronicInRoomRed3)
		{
			trace("Blue animatronic present, Red animatrontimeSpriteTxtic not present. -Cam3");
			cam3AnimatronicRed.visible = false;
			cam3AnimatronicBlue.visible = true;
			cam3AnimatronicRedBlue.visible = false;
			cam3.visible = false;
		}
		
		if(animatronicInRoomRed3 && animatronicInRoomBlue3)
		{
			trace("Both Red and Blue animatronics present. -Cam3");
			cam3AnimatronicRed.visible = false;
			cam3AnimatronicBlue.visible = false;
			cam3AnimatronicRedBlue.visible = true;
			cam3.visible = false;
		}

		if(!animatronicInRoomRed3 && !animatronicInRoomBlue3)
		{
			trace("No animatronics present. -Cam3");
			cam3AnimatronicRed.visible = false;
			cam3AnimatronicBlue.visible = false;
			cam3AnimatronicRedBlue.visible = false;
			cam3.visible = true;
		}
		camStatic.visible = true;
		camStatic.alpha = 1; // Reset alpha to 1 before playing the animation
	
		// Start playing the "glitch" animation if it exists.
		if (camStatic.animation.exists(glitchString)) {
			camStatic.animation.play(glitchString, false);
			
			// Set a finish callback to reduce alpha after "glitch" animation finishes.
			camStatic.animation.finishCallback = function(_:String):Void {
				camStatic.alpha = 0.25; // Set the alpha to 0.5 once the "glitch" animation completes
				// Continue playing the "static" animation if it exists.
				if (camStatic.animation.exists(PathsInGame.staticString)) {
					camStatic.animation.play(PathsInGame.staticString, true); // Loop the "static" animation.
					startCameraPan();
				}
			};
		}
	}

	private function makeCam4Visible(name:String):Void 
	{ 
		map.visible = true;
		Animatronic2.sonicMoved4 = false;
		if(animatronicInRoomRed4 && !animatronicInRoomBlue4)
		{
			trace("Red animatronic present, Blue animatronic not present. -Cam4");
			cam4AnimatronicRed.visible = true;
			cam4AnimatronicBlue.visible = false;
			cam4AnimatronicRedBlue.visible = false;
			cam4.visible = false;
		}
		
		if(animatronicInRoomBlue4 && !animatronicInRoomRed4)
		{
			trace("Blue animatronic present, Red animatronic not present. -Cam4");
			cam4AnimatronicRed.visible = false;
			cam4AnimatronicBlue.visible = true;
			cam4AnimatronicRedBlue.visible = false;
			cam4.visible = false;
		}
		
		if(animatronicInRoomRed4 && animatronicInRoomBlue4)
		{
			trace("Both Red and Blue animatronics present. -Cam4");
			cam4AnimatronicRed.visible = false;
			cam4AnimatronicBlue.visible = false;
			cam4AnimatronicRedBlue.visible = true;
			cam4.visible = false;
		}

		if(!animatronicInRoomRed4 && !animatronicInRoomBlue4)
		{
			trace("No animatronics present. -Cam4");
			cam4AnimatronicRed.visible = false;
			cam4AnimatronicBlue.visible = false;
			cam4AnimatronicRedBlue.visible = false;
			cam4.visible = true;
		}
		camStatic.visible = true;
		camStatic.alpha = 1; // Reset alpha to 1 before playing the animation
	
		// Start playing the "glitch" animation if it exists.
		if (camStatic.animation.exists(glitchString)) {
			camStatic.animation.play(glitchString, false);
			
			// Set a finish callback to reduce alpha after "glitch" animation finishes.
			camStatic.animation.finishCallback = function(_:String):Void {
				camStatic.alpha = 0.25; // Set the alpha to 0.5 once the "glitch" animation completes
				// Continue playing the "static" animation if it exists.
				if (camStatic.animation.exists(PathsInGame.staticString)) {
					camStatic.animation.play(PathsInGame.staticString, true); // Loop the "static" animation.
					startCameraPan();
				}
			};
		}
	}

	private function makeCam5Visible(name:String):Void 
	{ 
		map.visible = true;
		Animatronic2.sonicMoved5 = false;
		if(animatronicInRoomRed5 && !animatronicInRoomBlue5)
		{
			trace("Red animatronic present, Blue animatronic not present. -Cam5");
			cam5AnimatronicRed.visible = true;
			cam5AnimatronicBlue.visible = false;
			cam5AnimatronicRedBlue.visible = false;
			cam5.visible = false;
		}
		
		if(animatronicInRoomBlue5 && !animatronicInRoomRed5)
		{
			trace("Blue animatronic present, Red animatronic not present. -Cam5");
			cam5AnimatronicRed.visible = false;
			cam5AnimatronicBlue.visible = true;
			cam5AnimatronicRedBlue.visible = false;
			cam5.visible = false;
		}
		
		if(animatronicInRoomRed5 && animatronicInRoomBlue5)
		{
			trace("Both Red and Blue animatronics present. -Cam5");
			cam5AnimatronicRed.visible = false;
			cam5AnimatronicBlue.visible = false;
			cam5AnimatronicRedBlue.visible = true;
			cam5.visible = false;
		}

		if(!animatronicInRoomRed5 && !animatronicInRoomBlue5)
		{
			trace("No animatronics present. -Cam5");
			cam5AnimatronicRed.visible = false;
			cam5AnimatronicBlue.visible = false;
			cam5AnimatronicRedBlue.visible = false;
			cam5.visible = true;
		}
		camStatic.visible = true;
		camStatic.alpha = 1; // Reset alpha to 1 before playing the animation
	
		// Start playing the "glitch" animation if it exists.
		if (camStatic.animation.exists(glitchString)) {
			camStatic.animation.play(glitchString, false);
			
			// Set a finish callback to reduce alpha after "glitch" animation finishes.
			camStatic.animation.finishCallback = function(_:String):Void {
				camStatic.alpha = 0.25; // Set the alpha to 0.5 once the "glitch" animation completes
				// Continue playing the "static" animation if it exists.
				if (camStatic.animation.exists(PathsInGame.staticString)) {
					camStatic.animation.play(PathsInGame.staticString, true); // Loop the "static" animation.
					startCameraPan();
				}
			};
		}
	}

	private function makeCam1Invisible():Void {
		cam1.visible = false;
		cam1AnimatronicRed.visible = false;
		cam1AnimatronicBlue.visible = false;
		cam1AnimatronicRedBlue.visible = false;

		if (cam1.x != 0) {
			cam1.x = 0; // Reset the x position to the original
		}
	}

	private function makeCam2Invisible():Void {
		cam2.visible = false;
		cam2AnimatronicRed.visible = false;
		cam2AnimatronicBlue.visible = false;
		cam2AnimatronicRedBlue.visible = false;

		if (cam2.x != -150) {
			cam2.x = -150; // Reset the x position to the original
		}
	}

	private function makeCam3Invisible():Void {
		cam3.visible = false;
		cam3AnimatronicRed.visible = false;
		cam3AnimatronicBlue.visible = false;
		cam3AnimatronicRedBlue.visible = false;

		if (cam3.x != -150) {
			cam3.x = -150; // Reset the x position to the original
		}
	}

	private function makeCam4Invisible():Void {
		cam4.visible = false;
		cam4AnimatronicRed.visible = false;
		cam4AnimatronicBlue.visible = false;
		cam4AnimatronicRedBlue.visible = false;

		if (cam4.x != 0) {
			cam4.x = 0; // Reset the x position to the original
		}
	}

	private function makeCam5Invisible():Void {
		cam5.visible = false;
		cam5AnimatronicRed.visible = false;
		cam5AnimatronicBlue.visible = false;
		cam5AnimatronicRedBlue.visible = false;

		if (cam5.x != -150) {
			cam5.x = -150; // Reset the x position to the original
		}
	}

	private function makeCamFlipInvisible(name:String):Void {
		camFlip.visible = false;
	}

	function playSecondSound():Void {
		secondSound.play(); // Resume the sound.
	}	

	private var completedTweens:Int = 0;

	private function startCameraPan():Void {
		if (!tweenActive) {
			var targetX = panningRight ? 50 : -50;
	
			var onTweenComplete = function(twn:FlxTween):Void {
				completedTweens++;
				if (completedTweens >= 5) { // Assuming 5 cameras
					panningRight = !panningRight;
					completedTweens = 0;
					tweenActive = false;
				}
			};
	
			var startTween = function(camera:Dynamic, targetX:Float):Void {
				if ((panningRight && camera.x < 50) || (!panningRight && camera.x > -50)) {
					tweenActive = true;
					FlxTween.tween(camera, {x: targetX}, 2.6, {ease: FlxEase.linear, startDelay: 4, onComplete: onTweenComplete});
				}
			}
	
			startTween(cam1, targetX);
			startTween(cam1AnimatronicRed, targetX);
			startTween(cam1AnimatronicBlue, targetX);
			startTween(cam1AnimatronicRedBlue, targetX);
			startTween(cam2, targetX);
			startTween(cam2AnimatronicRed, targetX);
			startTween(cam2AnimatronicBlue, targetX);
			startTween(cam2AnimatronicRedBlue, targetX);
			startTween(cam3, targetX);
			startTween(cam3AnimatronicRed, targetX);
			startTween(cam3AnimatronicBlue, targetX);
			startTween(cam3AnimatronicRedBlue, targetX);
			startTween(cam4, targetX);
			startTween(cam4AnimatronicRed, targetX);
			startTween(cam4AnimatronicBlue, targetX);
			startTween(cam4AnimatronicRedBlue, targetX);
			startTween(cam5, targetX);
			startTween(cam5AnimatronicRed, targetX);
			startTween(cam5AnimatronicBlue, targetX);
			startTween(cam5AnimatronicRedBlue, targetX);
		}
	}	

	private var continueUpdatingTime:Bool = true; // Flag to control time updates
	
	private function changeNumber():Void {
		if (!continueUpdatingTime) return; // Stop updating if flag is false
	
		var currentNumber:Int = Std.parseInt(timeTxtNumber); // Convert the text to a number

		trace("Time Changed, Time is Now " + currentNumber);

		switch(currentNumber)
		{
			case 12:
				numbaTwelve = false;
				numbaOne = true;
				numbaTwo = false;
				numbaThree = false;
				numbaFour = false;
				numbaFive = false;
			case 1:
				numbaTwelve = false;
				numbaOne = false;
				numbaTwo = true;
				numbaThree = false;
				numbaFour = false;
				numbaFive = false;
			case 2:
				numbaTwelve = false;
				numbaOne = false;
				numbaTwo = false;
				numbaThree = true;
				numbaFour = false;
				numbaFive = false;
			case 3:
				numbaTwelve = false;
				numbaOne = false;
				numbaTwo = false;
				numbaThree = false;
				numbaFour = true;
				numbaFive = false;
			case 4:
				numbaTwelve = false;
				numbaOne = false;
				numbaTwo = false;
				numbaThree = false;
				numbaFour = false;
				numbaFive = true;
		}
	
		if (currentNumber == 12) {
			currentNumber = 1; // Reset to 1 after 12
		} else {
			currentNumber++; // Increment the number
		}

		if(currentNumber == 3)
		{
			inGameHourPassed = true;
		}
	
		if (currentNumber == 5) {
			onSixAM(); // Call the function when the time is 6
		}
	
		if(currentNumber != 5)
		{
			timeTxtNumber = Std.string(currentNumber); // Update the text display
			//nightName2.text = timeTxtNumber + " AM";
		}
	
		timerSet = false; // Reset the timer flag
	}
	

	private var powerOutSoundPlayed2:Bool = false;

	private var powerOutSoundPlayed3:Bool = false;
	
	private function onSixAM():Void {
		if (!continueUpdatingTime) return;

		// Assuming FlxG.save.data is of a custom type with these properties
		var data = FlxG.save.data;

		if (!data.nightOneCompleted && data.nightOneNotCompleted) {
			data.nightOneCompleted = true;
			DiscordClient.changePresence("Night 1 - Shift Complete!", null);
		} else if (!data.nightTwoCompleted && data.nightOneCompleted) {
			data.nightTwoCompleted = true;
			DiscordClient.changePresence("Night 2 - Shift Complete!", null);
		} else if (!data.nightThreeCompleted && data.nightTwoCompleted) {
			data.nightThreeCompleted = true;
			DiscordClient.changePresence("Night 3 - Shift Complete!", null);
		} else if (!data.nightFourCompleted && data.nightThreeCompleted) {
			data.nightFourCompleted = true;
			DiscordClient.changePresence("Night 4 - Shift Complete!", null);
		} else if (!data.nightFiveCompleted && data.nightFourCompleted) {
			data.nightFiveCompleted = true;
			DiscordClient.changePresence("Night 5 - Work Week Complete!", null);
		}

	
		setGameToFinishedState();
		playEndMusic();
		animateWinning();
		setupFinalSceneTransition();
	}
	
	private function setGameToFinishedState():Void {
		continueUpdatingTime = false;
		FlxG.mouse.visible = false;
		FlxG.mouse.enabled = false;
		phoneCall.stop();
		jumpscareSound.stop();
		animatronic2.deactivate();
		muteButton.visible = false;
		won = true;
		subtitleText.visible = false;
		fadeInElements([winning, black]);
	}
	
	private function playEndMusic():Void {
		if (!musicPlayed) {
			FlxG.sound.music.stop();
			FlxG.sound.playMusic(PathsInGame.musicPath + "6AM" + PathsInGame.ogg, 1, false);
			musicPlayed = true;
		}
	}
	
	private function animateWinning():Void {
		winning.animation.play("win", false);
		var scaleTimings:Array<Float> = [1.13, 2.25, 3.37, 5.25, 6.37, 7.5, 8.63];
		for (i in 0...scaleTimings.length) {
			new FlxTimer().start(scaleTimings[i], function(tmr:FlxTimer) {
				var scale = 0.3 + (0.1 * i);
				winning.scale.set(scale, scale);
			}, 1);
		}
	}
	
	private function setupFinalSceneTransition():Void {
		if(FlxG.save.data.nightFiveCompleted)
		{
			new FlxTimer().start(16, function(tmr:FlxTimer) {
				transitionToEnding();
			});
		}
		else
		{
			new FlxTimer().start(14, function(tmr:FlxTimer) {
				playGoodJobSoundOnce();
				endingSubText.visible = true;
			});
		
			new FlxTimer().start(15.73, function(tmr:FlxTimer) {
				endingSubText.visible = false;
				endingSubText2.visible = true;
			});

			new FlxTimer().start(16, function(tmr:FlxTimer) {
				transitionToEnding();
			});
		}
	}
	
	private function fadeInElements(elements:Array<FlxSprite>):Void {
		for (element in elements) {
			FlxTween.tween(element, {alpha: 1}, 1, {ease: FlxEase.quadInOut});
		}
	}
	
	private function playGoodJobSoundOnce():Void {
		if (!powerOutSoundPlayed2) {
			goodJobSound.play();
			powerOutSoundPlayed2 = true;
		}
	}
	
	private function transitionToEnding():Void {
		FlxTween.tween(black3, {alpha: 1}, 3, {ease: FlxEase.quadInOut, onComplete: switchToTitleState});
	}
	
	private function switchToTitleState(_:FlxTween):Void {
		if(FlxG.save.data.nightFiveCompleted)
		{
			FlxG.switchState(new TheEndState());
		}
		else
		{
			FlxG.switchState(new LoadingState());
		}
		FlxG.sound.music.stop();
	}
	
	
	private function getRandomBool():Bool {
		return Math.random() >= 0.5;
	}

    private var powerOutSoundPlayed:Bool = false;

    public function blackOut():Void {
        if (!powerOutSoundPlayed) {
            powerOutSound.play();
            powerOutSoundPlayed = true;
        }
        black5.visible = true;
        batteryPower = 0;
        FlxG.sound.music.stop();
        canFlip = false;
        cambutton.visible = false;

        phoneCall.stop();
        muteButton.visible = false;
    }

	private function updateCameraView(animatronicMoved:Bool, animatronicCamera:String, currentCamera:String):Void {
		if(animatronicMoved && currentCamera == animatronicCamera) {
			switch(animatronicCamera) {
				case "cam1":
					makeCam1Visible("Bruh");
				case "cam2":
					makeCam2Visible("Bruh");
				case "cam3":
					makeCam3Visible("Bruh");
				case "cam4":
					makeCam4Visible("Bruh");
				case "cam5":
					makeCam5Visible("Bruh");
			}
		}
	}

	function updateDiscordPresence(data) {

		var data = FlxG.save.data;

		if (!data.nightOneCompleted && data.nightOneNotCompleted) {
			if (!updated12AM) {
				DiscordClient.changePresence("Night 1 - 12 AM", null);
				updated12AM = true;
			}
	
			if(numbaOne && !updated2AM) {
				DiscordClient.changePresence("Night 1 - 1 AM", null);
				updated2AM = true;
			}
	
			if(numbaTwo && !updated3AM) {
				DiscordClient.changePresence("Night 1 - 2 AM", null);
				updated3AM = true;
			}
	
			if(numbaThree && !updated4AM) {
				DiscordClient.changePresence("Night 1 - 3 AM", null);
				updated4AM = true;
			}
	
			if(numbaFour && !updated5AM) {
				DiscordClient.changePresence("Night 1 - 4 AM", null);
				updated5AM = true;
			}

			if(numbaFive && !updated1AM) {
				DiscordClient.changePresence("Night 1 - 5 AM", null);
				updated1AM = true;
			}
		}
		else if (!data.nightTwoCompleted && data.nightOneCompleted) {
			if (!updated12AM) {
				DiscordClient.changePresence("Night 2 - 12 AM", null);
				updated12AM = true;
			}
	
			if(numbaOne && !updated2AM) {
				DiscordClient.changePresence("Night 2 - 1 AM", null);
				updated2AM = true;
			}
	
			if(numbaTwo && !updated3AM) {
				DiscordClient.changePresence("Night 2 - 2 AM", null);
				updated3AM = true;
			}
	
			if(numbaThree && !updated4AM) {
				DiscordClient.changePresence("Night 2 - 3 AM", null);
				updated4AM = true;
			}
	
			if(numbaFour && !updated5AM) {
				DiscordClient.changePresence("Night 2 - 4 AM", null);
				updated5AM = true;
			}

			if(numbaFive && !updated1AM) {
				DiscordClient.changePresence("Night 2 - 5 AM", null);
				updated1AM = true;
			}
		} else if (!data.nightThreeCompleted && data.nightTwoCompleted) {
			if (!updated12AM) {
				DiscordClient.changePresence("Night 3 - 12 AM", null);
				updated12AM = true;
			}
	
			if(numbaOne && !updated2AM) {
				DiscordClient.changePresence("Night 3 - 1 AM", null);
				updated2AM = true;
			}
	
			if(numbaTwo && !updated3AM) {
				DiscordClient.changePresence("Night 3 - 2 AM", null);
				updated3AM = true;
			}
	
			if(numbaThree && !updated4AM) {
				DiscordClient.changePresence("Night 3 - 3 AM", null);
				updated4AM = true;
			}
	
			if(numbaFour && !updated5AM) {
				DiscordClient.changePresence("Night 3 - 4 AM", null);
				updated5AM = true;
			}

			if(numbaFive && !updated1AM) {
				DiscordClient.changePresence("Night 3 - 5 AM", null);
				updated1AM = true;
			}
		} else if (!data.nightFourCompleted && data.nightThreeCompleted) {
			if (!updated12AM) {
				DiscordClient.changePresence("Night 4 - 12 AM", null);
				updated12AM = true;
			}
	
			if(numbaOne && !updated2AM) {
				DiscordClient.changePresence("Night 4 - 1 AM", null);
				updated2AM = true;
			}
	
			if(numbaTwo && !updated3AM) {
				DiscordClient.changePresence("Night 4 - 2 AM", null);
				updated3AM = true;
			}
	
			if(numbaThree && !updated4AM) {
				DiscordClient.changePresence("Night 4 - 3 AM", null);
				updated4AM = true;
			}
	
			if(numbaFour && !updated5AM) {
				DiscordClient.changePresence("Night 4 - 4 AM", null);
				updated5AM = true;
			}

			if(numbaFive && !updated1AM) {
				DiscordClient.changePresence("Night 4 - 5 AM", null);
				updated1AM = true;
			}
		} else if (!data.nightFiveCompleted && data.nightFourCompleted) {
			if (!updated12AM) {
				DiscordClient.changePresence("Night 5 - 12 AM", null);
				updated12AM = true;
			}
	
			if(numbaOne && !updated2AM) {
				DiscordClient.changePresence("Night 5 - 1 AM", null);
				updated2AM = true;
			}
	
			if(numbaTwo && !updated3AM) {
				DiscordClient.changePresence("Night 5 - 2 AM", null);
				updated3AM = true;
			}
	
			if(numbaThree && !updated4AM) {
				DiscordClient.changePresence("Night 5 - 3 AM", null);
				updated4AM = true;
			}
	
			if(numbaFour && !updated5AM) {
				DiscordClient.changePresence("Night 5 - 4 AM", null);
				updated5AM = true;
			}

			if(numbaFive && !updated1AM) {
				DiscordClient.changePresence("Night 5 - 5 AM", null);
				updated1AM = true;
			}
		}
	}

	private function resetUpdateFlags() {
		updated12AM = updated1AM = updated2AM = updated3AM = updated4AM = updated5AM = false;
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.signals.focusLost.add(onGameFocusLost);
		FlxG.signals.focusGained.add(onGameFocusGained);

		var data = FlxG.save.data;

		updateDiscordPresence(data);

		gitGud.x -= 1;

		if(gitGud.x <= -1280)
		{
			gitGud.x = 0;
		}

		if (inGameHourPassed) {
			if(animatronic2.aiLevel > 20)
			{
				animatronic2.updateAILevel(animatronic2.aiLevel + 1);
			}
			trace("Sonic's AI is " + animatronic2.aiLevel);
			inGameHourPassed = false;
		}

		// Flicker effect logic with randomness for rapid changes
		if (flickerTimer <= 0)
		{
			if (flicker)
			{
				// Randomly choose a new alphaDelta for an irregular effect
				alphaDelta = Math.random() * 0.2; // Randomize for rapid flicker
				gitGud3.alpha -= alphaDelta;
				if (gitGud3.alpha <= 0.5)
				{
					flicker = false;
					flickerTimer = Math.random() * 0.2; // Short random cooldown
				}
			}
			else
			{
				alphaDelta = Math.random() * 0.2; // Randomize for rapid flicker
				gitGud3.alpha += alphaDelta;
				if (gitGud3.alpha >= 1)
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

		if(won)
		{
			if(!confettiThrown)
			{
				new FlxTimer().start(8, function(tmr:FlxTimer)
				{
					confetti.throwConfetti(-200, 1900, 700, 800, 1, 1);
					confettiThrown = true;
				});
			}
		}
		
		// Usage example in your animatronicMoving function:
		if(black5.visible == false && map.visible == true && won == false)
		{
			updateCameraView(Animatronic2.sonicMoved, "cam1", lastActiveCamera);
			updateCameraView(Animatronic2.sonicMoved2, "cam2", lastActiveCamera);
			updateCameraView(Animatronic2.sonicMoved3, "cam3", lastActiveCamera);
			updateCameraView(Animatronic2.sonicMoved4, "cam4", lastActiveCamera);
			updateCameraView(Animatronic2.sonicMoved5, "cam5", lastActiveCamera);
		}
		
		// If SPACE is pressed, reset the flashlight to full brightness
		if (FlxG.keys.pressed.SPACE && doorHallway.visible == true) {
			flashLight.visible = true;
			dimming = true;
			flickering = false; // Ensure flickering is off when SPACE is pressed
		}

		// Dimming logic
		if (dimming && flashLight.alpha >= 0.75) {
			flashLight.alpha -= dimRate * elapsed;

			// Start flickering when the flashlight dims to a certain level
			if (flashLight.alpha <= 0.75 && !flickering) {
				flickering = true;
			}

			if (flashLight.alpha <= 0) {
				dimming = false;
				flashLight.visible = false;
			}
		}

		// Flickering logic
		if (flickering) {
			flickerTimer -= elapsed;
			if (flickerTimer <= 0.75) {
				flickerTimer = flickerRate;
				flashLight.alpha += (Math.random() * 0.1) + 0.05;
				flashLight.alpha = Math.max(0, Math.min(1, flashLight.alpha));
			}
		}


		if(sonicIsNearOffice)
		{
			doorHallway2.visible = flashLight.visible;
		}
		else
		{
			doorHallway2.visible = false;
		}

		if(numbaTwelve) timeSpriteTxt.animation.play("twelve", false);

		if(numbaOne) timeSpriteTxt.animation.play("one", false);

		if(numbaTwo) timeSpriteTxt.animation.play("two", false);

		if(numbaThree) timeSpriteTxt.animation.play("three", false);

		if(numbaFour) timeSpriteTxt.animation.play("four", false);

		if(numbaFive) timeSpriteTxt.animation.play("five", false);

        accumulatedTime += elapsed;

		if (batteryPower == 100) {
			batteryPowerSprite.animation.play("full", false);
		}

		if (batteryPower < 100) { // Below 100
			batteryPowerSprite.animation.play("full", false);
		}

		if (batteryPower < 75) { // Below 75
			batteryPowerSprite.animation.play("almostFull", false);
		}

		if (batteryPower < 50) { // Below 50
			batteryPowerSprite.animation.play("half", false);
		}

		if (batteryPower < 25) { // Below 25
			batteryPowerSprite.animation.play("almostEmpty", false);
		}

		if (batteryPower < 5) { // Below 5
			batteryPowerSprite.animation.play("empty", false);
		}

        // Check if the interval has been reached
		if(black.alpha == 0)
		{
			switch(toolCounter)
			{
				case 0:
					decrementInterval = 10.0;
				case 1:
					decrementInterval = 8.0;
				case 2:
					decrementInterval = 6.0;
				case 3:
					decrementInterval = 4.0;
				case 4:
					decrementInterval = 2.0;
			}
			if (accumulatedTime >= decrementInterval) {
				if (batteryPower > 0) {
					batteryPower--;
					trace(batteryPower + '%');
				}
				// Reset the accumulated time
				accumulatedTime = 0;
			}
		}

		batteryPowerTxt.text = batteryPower + '%';

		if(canPressEnter && FlxG.keys.justPressed.ENTER)
		{
			FlxTween.tween(black3, {alpha: 1}, 2, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween):Void {
				FlxG.sound.music.stop();
				FlxG.switchState(new LoadingState());
				//FlxG.switchState(new TitleScreenState());
				//FlxG.sound.music.stop();
				//FlxG.sound.playMusic(TitleScreenState.musicPath + TitleScreenState.menuMusicString + TitleScreenState.ogg, 1, true);
			}});
		}

		if(batteryPower == 0 || FlxG.keys.justPressed.I)
		{
			blackOut();
		}

		if(FlxG.keys.justPressed.P)
		{
			onSixAM();
		}

		if(FlxG.keys.justPressed.R)
		{
			Animatronic2.sonicGotYou = true;
			Animatronic.babyGotYou = false;
			jumpscare();
		}

		if(FlxG.keys.justPressed.B)
		{
			Animatronic2.sonicGotYou = false;
			Animatronic.babyGotYou = true;
			jumpscare();
		}

		if(Animatronic.youAreDead || Animatronic2.youAreDead || Animatronic3.youAreDead)
		{
			jumpscare();
		}

		if(black.alpha <= 0.5)
		{
			if (FlxG.mouse.overlaps(honkHitbox) && isFlip && notTurned && !dead) {
				if (FlxG.mouse.pressed && !pressedHonk)
				{
					honkSound.stop();
					honkSound.play();
					pressedHonk = true;
	
					new FlxTimer().start(0.426, function(tmr:FlxTimer)
					{
						pressedHonk = false;
					});
				}
			}
		}

		if(!timeHasPassed)
		{
			if(FlxG.mouse.overlaps(mutePhoneHitbox) && black.alpha == 0 && muteButton.visible == true)
			{
				if (FlxG.mouse.pressed && !mutted)
				{
					mutted = true;
					phoneCall.stop();
					muteButton.visible = false;
					subtitleText.visible = false;
					endCall.play();
				}
			}
		}
		else
		{
			muteButton.visible = false;
		}

		if (black.alpha == 0 && !timerSet) {
			Timer.delay(changeNumber, 90000);
			timerSet = true;
		}

		// Assuming flashLightDimTimer is a FlxTimer declared in your class
		if (FlxG.keys.pressed.SPACE && doorHallway.visible == true) {
			flashLight.visible = true;
			dimming = true;

			flickering = true; // Start flickering when the flashlight is on

			if (!flashLightHeld) {
				if(!toolCounterIncremented4)
				{
					toolCounter++;
					toolCounterIncremented4 = true;
					toolCounterReverseIncremented4 = false;
				}
				flashlightSound.stop();
				flashlightSound.play();
				flashLightHeld = true;
				flashLightRelease = false;
			}
		} else {
			dimming = false;
			flickering = false;
			if (flashLightHeld) {
				flashlightSound.stop();
				flashlightSound.play();
				flashLightHeld = false;
				flashLightRelease = true;

				if(!toolCounterReverseIncremented4)
				{
					toolCounter--;
					toolCounterIncremented4 = false;
					toolCounterReverseIncremented4 = true;
				}
			}

			flashLight.alpha = 1;
			flashLight.visible = false;
		}


		if(!canLook)
		{
			if(FlxG.mouse.overlaps(cam1ButtonHitbox))
			{
				if(FlxG.mouse.pressed)
				{
					makeCam1Visible("Bruh"); 
					makeCam2Invisible(); 
					makeCam3Invisible(); 
					makeCam4Invisible(); 
					makeCam5Invisible(); 

					// animatronicWillAppear();

					map.animation.play("stage", false);

					lastActiveCamera = "cam1";

					changeCam.play();

					if (cam1.x != 0) {
						cam1.x = 0; // Reset the x position to the original
					}
				}
			}
			else if(FlxG.mouse.overlaps(cam2ButtonHitbox))
			{
				if(FlxG.mouse.pressed)
				{
					makeCam2Visible("Bruh"); 
					makeCam1Invisible(); 
					makeCam3Invisible(); 
					makeCam4Invisible(); 
					makeCam5Invisible();

					lastActiveCamera = "cam2";

					map.animation.play("dining", false);

					changeCam.play();

					if (cam2.x != -150) {
						cam2.x = -150; // Reset the x position to the original
					}
				}
			}
			else if(FlxG.mouse.overlaps(cam3ButtonHitbox))
			{
				if(FlxG.mouse.pressed)
				{
					makeCam3Visible("Bruh"); 
					makeCam2Invisible(); 
					makeCam1Invisible(); 
					makeCam4Invisible();
					makeCam5Invisible(); 

					lastActiveCamera = "cam3";

					map.animation.play("backroom", false);

					changeCam.play();

					if (cam3.x != -150) {
						cam3.x = -150; // Reset the x position to the original
					}
				}
			}
			else if(FlxG.mouse.overlaps(cam4ButtonHitbox))
			{
				if(FlxG.mouse.pressed)
				{
					makeCam4Visible("Bruh");
					makeCam2Invisible();
					makeCam3Invisible(); 
					makeCam1Invisible(); 
					makeCam5Invisible();

					lastActiveCamera = "cam4";

					map.animation.play("cove", false);

					changeCam.play();

					if (cam4.x != 0) {
						cam4.x = 0; // Reset the x position to the original
					}
				}
			}
			else if(FlxG.mouse.overlaps(cam5ButtonHitbox))
			{
				if(FlxG.mouse.pressed)
				{
					makeCam5Visible("Bruh"); 
					makeCam2Invisible(); 
					makeCam3Invisible(); 
					makeCam4Invisible();
					makeCam1Invisible();

					lastActiveCamera = "cam5";

					map.animation.play("closet", false);

					changeCam.play();

					if (cam5.x != -150) {
						cam5.x = -150; // Reset the x position to the original
					}
				}
			}
		}

		// When the game loses focus
		if (!gameHasFocus) {
			if (secondSound.playing) {
				secondSound.stop();
			}
			//DiscordClient.changePresence("Game Paused", null);

			// Store the current time
			// pauseTime = FlxG.game.ticks;
		}
		// else { // When the game regains focus
		// 	if (black.alpha == 0) {

		// 		if (pauseTime > 0) {
		// 			// Calculate the time elapsed during the pause
		// 			accumulatedElapsedTime += (FlxG.game.ticks - pauseTime);
		// 			pauseTime = 0; // Reset pauseTime
		// 		}

		// 		var endTime2:Float = startTime + duration;

		// 		// Adjust totalTimeGoingDown
		// 		totalTimeGoingDown = totalTime - accumulatedElapsedTime - elapsed;
		// 		DiscordClient.changePresence2(true, endTime2);
		// 	}
		// }

		// cursor.x = FlxG.mouse.x - 90; // Use FlxG.mouse.x instead of screenX
		// cursor.y = FlxG.mouse.y - 90; // Use FlxG.mouse.y instead of screenY

		var panBounds:Float = 50; // Adjust as needed for the desired effect

		var centerX:Float = FlxG.width / 2;

		var mouseX:Float = FlxG.mouse.screenX;

		var percentX:Float = (mouseX - centerX) / centerX;

		// if(canLook == true)
		// {

		office.x -= 15;
		office.x = FlxMath.lerp(office.x, -panBounds * percentX, elapsed * lerpSpeed);

		honkHitbox.x += 207;
		honkHitbox.x = FlxMath.lerp(honkHitbox.x, -panBounds * percentX, elapsed * lerpSpeed);

		timeSpriteTxt.x += 88;
		timeSpriteTxt.x = FlxMath.lerp(timeSpriteTxt.x, -panBounds * percentX, elapsed * lerpSpeed);

		office2.x -= 15;
		office2.x = FlxMath.lerp(office2.x, -panBounds * percentX, elapsed * lerpSpeed);

		door.x += 48.5;
		door.x = FlxMath.lerp(door.x, -panBounds * percentX, elapsed * lerpSpeed);

		door2.x += 184.5;
		door2.x = FlxMath.lerp(door2.x, -panBounds * percentX, elapsed * lerpSpeed);

		batteryPowerTxt.x += 55;
		batteryPowerTxt.x = FlxMath.lerp(batteryPowerTxt.x, -panBounds * percentX, elapsed * lerpSpeed);

		batteryPowerSprite.x += 105;
		batteryPowerSprite.x = FlxMath.lerp(batteryPowerSprite.x, -panBounds * percentX, elapsed * lerpSpeed);

		batteryPowerTxt.alpha = 0.86;

		// }

		//officeBlurry.x = office.x;


	// In your update function
		if(black.alpha <= 0.5)
		{
			if (FlxG.keys.justPressed.Q && canLook && !dead && batteryPower != 0) {
				canLook = false; // Disallow further toggles until the current one completes
			
				if (!isLookingRight) {
					office.visible = false;
					office2.visible = false;
					turning.visible = true;
					door.visible = false;
					door2.visible = false;
					notTurned = false;
					cambutton.visible = false;
					turning.animation.play("turning", false);
					timeSpriteTxt.visible = false;
					batteryPowerTxt.visible = false;
					batteryPowerSprite.visible = false;
			
					turning.animation.finishCallback = function(_:String):Void {
						door.visible = false;
						door2.visible = false;
						turning.visible = false;
						doorHallway.visible = true;
						isLookingRight = true;
						canLook = true;
					};
			
				} else {
					// Second press - start turning animation again and then move back to the office
					doorHallway.visible = false;
					turning.visible = true;
					turning.animation.play("back", false);
			
					turning.animation.finishCallback = function(_:String):Void {
						turning.visible = false;
						office.visible = true;
						office2.visible = true;
						isLookingRight = false;
						canLook = true; // Re-enable toggling after the animation
						notTurned = true;
						cambutton.visible = true;

						batteryPowerSprite.visible = true;

						batteryPowerTxt.visible = true;

						door.visible = true;
						door2.visible = true;

						timeSpriteTxt.visible = true;
						door.visible = true;
						door2.visible = true;
					};
				}
			}
		}

		if(sonicIsNearOffice && doorHallway.visible == true && FlxG.keys.justPressed.SPACE) 
		{
			if (!flashTriggered) {
				flashTriggered = true; // Set the flag immediately
		
				sonicGotFlashed = true;
				sonicDiesSound.play(); // Play sound after setting the flag
		
				FlxTween.tween(doorHallway2, {alpha: 0}, 0.75, {ease: FlxEase.quadInOut});
			}
		}
			
		if(turning.visible == true)
		{
			cambutton.visible = false;
		}

		if(black.alpha <= 0.5)
		{
			if(batteryPower != 0)
			{
				if (FlxG.keys.justPressed.ONE && !doorFlippedUp && doorHallway.visible == false && isFlip) {
					FlxTween.tween(door, {y: door.y + 275}, 0.2, {ease: FlxEase.linear, onComplete: function(twn:FlxTween):Void {
						doorFlippedUp = true;
					}});
					if(!toolCounterIncremented)
					{
						toolCounter++;
						toolCounterIncremented = true;
						toolCounterReverseIncremented = false;
					}
					doorSound.stop();
					doorSound.play();
					return;
				}
				
				if (FlxG.keys.justPressed.ONE && doorFlippedUp && doorHallway.visible == false && isFlip) {
					FlxTween.tween(door, {y: door.y - 275}, 0.2, {ease: FlxEase.linear, onComplete: function(twn:FlxTween):Void {
						doorFlippedUp = false;
					}});
					if(!toolCounterReverseIncremented)
					{
						toolCounter--;
						toolCounterIncremented = false;
						toolCounterReverseIncremented = true;
					}
					doorSound.stop();
					doorSound.play();
					return;
				}
		
				if (FlxG.keys.justPressed.TWO && !doorFlippedUp2 && doorHallway.visible == false && isFlip) {
					FlxTween.tween(door2, {y: door2.y + 275}, 0.2, {ease: FlxEase.linear, onComplete: function(twn:FlxTween):Void {
						doorFlippedUp2 = true;
					}});
					if(!toolCounterIncremented2)
					{
						toolCounter++;
						toolCounterIncremented2 = true;
						toolCounterReverseIncremented2 = false;
					}
					doorSound.stop();
					doorSound.play();
					return;
				}
				
				if (FlxG.keys.justPressed.TWO && doorFlippedUp2 && doorHallway.visible == false && isFlip) {
					FlxTween.tween(door2, {y: door2.y - 275}, 0.2, {ease: FlxEase.linear, onComplete: function(twn:FlxTween):Void {
						doorFlippedUp2 = false;
					}});
					if(!toolCounterReverseIncremented2)
					{
						toolCounter--;
						toolCounterIncremented2 = false;
						toolCounterReverseIncremented2 = true;
					}
					doorSound.stop();
					doorSound.play();
					return;
				}
			}
		}
		

        // Check if the Escape key is currently being pressed
        if (FlxG.keys.pressed.ESCAPE) {
            if (!isEscapePressed) {
                // The Escape key was just pressed, start the timer
                isEscapePressed = true;
                escapePressedTime = 0;
            } else {
                // The Escape key is being held down, increment the timer
                escapePressedTime += elapsed;
            }

            // Start fading in the text after 3 seconds
            if (escapePressedTime >= 3 && escapePressedTime < 5) {
				exitingText.alpha = (escapePressedTime - 3) / 2;
				exitingText.alpha = FlxMath.bound(exitingText.alpha, 0, 1);
            }

            // Check if the Escape key has been held for 5 seconds
            if (escapePressedTime >= 5) {
				FlxTween.tween(black, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween):Void {
					FlxG.switchState(new TitleScreenState());
					FlxG.sound.music.stop();
					FlxG.sound.playMusic(PathsInGame.musicPath + PathsInGame.menuMusicString + PathsInGame.ogg, 1, true);
				}});
            }
        } else if (isEscapePressed) {
            // The Escape key was released before 5 seconds passed, reset and fade out the text
            isEscapePressed = false;
            escapePressedTime = 0;
			FlxTween.tween(exitingText, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
        }

		if(black.alpha <= 0.5)
		{
			if (FlxG.mouse.overlaps(camButtonHitbox) && canFlip && notTurned && !dead) {
				canFlip = false; // Prevent further flips during the cooldown
				// Start the cooldown timer
				cambutton.visible = false;
	
				new FlxTimer().start(FLIP_COOLDOWN, function(tmr:FlxTimer) {
					canFlip = true;
					cambutton.visible = true;
					// animatronicWillAppear();
				}, 1);
				
				camFlip.visible = true; // Ensure camFlip is visible before playing any animations
				if (isFlip) {
					if(!toolCounterIncremented3)
					{
						toolCounter++;
						toolCounterIncremented3 = true;
						toolCounterReverseIncremented3 = false;
					}
					camFlip.animation.play(PathsInGame.flipString, false);
					camSound2.play();
					secondSoundTimer = haxe.Timer.delay(playSecondSound, 5000);
					switch(lastActiveCamera) {
						case "cam1":
							camFlip.animation.finishCallback = makeCam1Visible;
						case "cam2":
							camFlip.animation.finishCallback = makeCam2Visible;
						case "cam3":
							camFlip.animation.finishCallback = makeCam3Visible;
						case "cam4":
							camFlip.animation.finishCallback = makeCam4Visible;
						case "cam5":
							camFlip.animation.finishCallback = makeCam5Visible;
						default:
							camFlip.animation.finishCallback = makeCam1Visible;
					}
					canLook = false;
				} else {
					if(!toolCounterReverseIncremented3)
					{
						toolCounter--;
						toolCounterReverseIncremented3 = true;
						toolCounterIncremented3 = false;
					}
					makeCam1Invisible();
					makeCam2Invisible();
					makeCam3Invisible();
					makeCam4Invisible();
					makeCam5Invisible();
					map.visible = false;
					canLook = true;
					camStatic.visible = false;
					camFlip.animation.play(PathsInGame.flipString + reverseString, false);
					camSound2.stop();
					camSound.play();
					// Safely stop the second sound if it's playing
					if (cam1.x != 0) {
						cam1.x = 0; // Reset the x position to the original
					}
					if (cam2.x != -150) {
						cam2.x = -150; // Reset the x position to the original
					}
					if (cam3.x != -150) {
						cam3.x = -150; // Reset the x position to the original
					}
					if (cam4.x != 0) {
						cam4.x = 0; // Reset the x position to the original
					}
					if (cam5.x != -150) {
						cam5.x = -150; // Reset the x position to the original
					}
					if (cam1AnimatronicRed.x != 0) {
						cam1AnimatronicRed.x = 0; // Reset the x position to the original
					}
					if (cam2AnimatronicRed.x != 0) {
						cam2AnimatronicRed.x = 0; // Reset the x position to the original
					}
					if (cam3AnimatronicRed.x != 0) {
						cam3AnimatronicRed.x = 0; // Reset the x position to the original
					}
					if (cam4AnimatronicRed.x != 0) {
						cam4AnimatronicRed.x = 0; // Reset the x position to the original
					}
					if (cam5AnimatronicRed.x != 0) {
						cam5AnimatronicRed.x = 0; // Reset the x position to the original
					}

					if (cam1AnimatronicBlue.x != 0) {
						cam1AnimatronicBlue.x = 0; // Reset the x position to the original
					}
					if (cam2AnimatronicBlue.x != 0) {
						cam2AnimatronicBlue.x = 0; // Reset the x position to the original
					}
					if (cam3AnimatronicBlue.x != 0) {
						cam3AnimatronicBlue.x = 0; // Reset the x position to the original
					}
					if (cam4AnimatronicBlue.x != 0) {
						cam4AnimatronicBlue.x = 0; // Reset the x position to the original
					}
					if (cam5AnimatronicBlue.x != 0) {
						cam5AnimatronicBlue.x = 0; // Reset the x position to the original
					}

					if (cam1AnimatronicRedBlue.x != 0) {
						cam1AnimatronicRedBlue.x = 0; // Reset the x position to the original
					}
					if (cam2AnimatronicRedBlue.x != 0) {
						cam2AnimatronicRedBlue.x = 0; // Reset the x position to the original
					}
					if (cam3AnimatronicRedBlue.x != 0) {
						cam3AnimatronicRedBlue.x = 0; // Reset the x position to the original
					}
					if (cam4AnimatronicRedBlue.x != 0) {
						cam4AnimatronicRedBlue.x = 0; // Reset the x position to the original
					}
					if (cam5AnimatronicRedBlue.x != 0) {
						cam5AnimatronicRedBlue.x = 0; // Reset the x position to the original
					}

					if (tweenActive) {
						FlxTween.cancelTweensOf(cam1);
						FlxTween.cancelTweensOf(cam2);
						FlxTween.cancelTweensOf(cam3);
						FlxTween.cancelTweensOf(cam4);
						FlxTween.cancelTweensOf(cam5);
						FlxTween.cancelTweensOf(cam1AnimatronicRed);
						FlxTween.cancelTweensOf(cam2AnimatronicRed);
						FlxTween.cancelTweensOf(cam3AnimatronicRed);
						FlxTween.cancelTweensOf(cam4AnimatronicRed);
						FlxTween.cancelTweensOf(cam5AnimatronicRed);
						FlxTween.cancelTweensOf(cam1AnimatronicBlue);
						FlxTween.cancelTweensOf(cam2AnimatronicBlue);
						FlxTween.cancelTweensOf(cam3AnimatronicBlue);
						FlxTween.cancelTweensOf(cam4AnimatronicBlue);
						FlxTween.cancelTweensOf(cam5AnimatronicBlue);
						FlxTween.cancelTweensOf(cam1AnimatronicRedBlue);
						FlxTween.cancelTweensOf(cam2AnimatronicRedBlue);
						FlxTween.cancelTweensOf(cam3AnimatronicRedBlue);
						FlxTween.cancelTweensOf(cam4AnimatronicRedBlue);
						FlxTween.cancelTweensOf(cam5AnimatronicRedBlue);
						tweenActive = false; // No tween is active now
					}
					if (secondSound != null && secondSound.playing) {
						secondSound.stop();
					}
					// If a timer is set to play the sound later, cancel it
					if (secondSoundTimer != null) {
						secondSoundTimer.stop();
						secondSoundTimer = null;
					}
					camFlip.animation.finishCallback = makeCamFlipInvisible;
				}
				// Toggle the flip state for the next key press.
				isFlip = !isFlip;
			}
		}
	}

	override public function destroy():Void {
		// Remove the focus listeners
		FlxG.signals.focusLost.remove(onGameFocusLost);
		FlxG.signals.focusGained.remove(onGameFocusGained);

		super.destroy();
	}
		
}

enum AnimatronicType {
    BlueBaby;
    Sonic;
    GoldenFreddy;
}

class TimerData {
    public var time:Float;
    public var text:String;

    public function new(time:Float, text:String) {
        this.time = time;
        this.text = text;
    }
}