import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import openfl.events.Event;
import openfl.display.Bitmap;
import openfl.display.Loader;
import openfl.media.Sound;
import openfl.net.URLRequest;
import flixel.util.FlxSignal;

import openfl.events.IOErrorEvent; // Add this line

import openfl.net.URLLoader;
import openfl.net.URLLoaderDataFormat;

class LoadingState extends FlxState
{
    private var loadingText:FlxText;
    private var loadingText2:FlxText;
    private var assetLoader:AssetLoader;

    private var tipsText:FlxText;
    private var tips:Array<String> = ["Tip: Watch out for Sonic.EXE in the door behind you!", "Tip: Make sure to check the hallway camera for ???", "Tip: Did you know that Soy likes big bla-"]; // Add more tips as needed
    private var lastTipIndex:Int = -1;
    private var tipTimer:FlxTimer;

    override public function create():Void
    {
        super.create();

        loadingText = new FlxText(0, FlxG.height / 2 - 10, FlxG.width, "Loading...");
        loadingText.setFormat(null, 16, 0xFFFFFFFF, "center");
        add(loadingText);

        // Initialize tips text
        tipsText = new FlxText(0, FlxG.height / 2 + 20, FlxG.width, "");
        tipsText.setFormat(null, 16, 0xFFFFFFFF, "center");
        add(tipsText);

        loadingText2 = new FlxText(0, FlxG.height / 2 + 60, FlxG.width, "Press Enter to start the night!");
        loadingText2.setFormat(null, 16, 0xFFFFFFFF, "center");
        loadingText2.visible = false;
        add(loadingText2);

        // Display the initial tip immediately
        updateTip(null);

        // Initialize and start the timer for subsequent tips
        tipTimer = new FlxTimer();
        tipTimer.start(5, updateTip, 0); // 0 for infinite loops

        assetLoader = new AssetLoader();
        assetLoader.onProgress.add(onLoadingProgress);
        assetLoader.onComplete.add(onLoadingComplete);

        assetLoader.loadAssets();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if(loadingText2.visible == true)
        {
            if (FlxG.keys.justPressed.ENTER) 
            {
                FlxTween.tween(loadingText, {alpha: 0}, 1.5, {ease: FlxEase.quadInOut});
                FlxTween.tween(loadingText2, {alpha: 0}, 1.5, {ease: FlxEase.quadInOut});
                FlxTween.tween(tipsText, {alpha: 0}, 1.5, {ease: FlxEase.quadInOut});
                new FlxTimer().start(1.5, function(tmr:FlxTimer) {
                    FlxG.switchState(new PlayState());
                });
            }
        }
    }

    private function onLoadingProgress():Void // No parameters
    {
        // Access the counts from the assetLoader
        var loadedCount:Int = assetLoader.loadedAssetsCount;
        var totalCount:Int = assetLoader.totalAssetsCount;
        var progressText:String = "Loading... " + loadedCount + "/" + totalCount + " (" + Std.int(assetLoader.currentProgress * 100) + "%)";
        loadingText.text = progressText;
    }

    private function onLoadingComplete():Void 
    {
        trace("Loading progress updated");

        loadingText2.visible = true;
    }

    private function updateTip(Timer:FlxTimer):Void {
        var randomTipIndex:Int = Std.random(tips.length);
        tipsText.text = tips[randomTipIndex];
    }
}

class AssetLoader
{
    public var onProgress:FlxSignal; // Updated
    public var onComplete:FlxSignal; // Updated
    public var currentProgress:Float = 0; // Existing
    public var loadedAssetsCount:Int = 0; // New
    public var totalAssetsCount:Int = 0; // New

    private var assetsToLoad:Array<String>;
    private var loadedAssets:Int = 0;

    public static var loadedBitmaps:Map<String, Bitmap> = new Map<String, Bitmap>();
    public static var loadedXMLs:Map<String, String> = new Map<String, String>();
    public static var loadedSounds:Map<String, Sound> = new Map<String, Sound>();

    public function new() 
    {
        onProgress = new FlxSignal();
        onComplete = new FlxSignal();
        assetsToLoad = [
        PathsInGame.soundPath + "letter_sound" + PathsInGame.ogg,
        PathsInGame.soundPath + "camleave" + PathsInGame.ogg,
        PathsInGame.soundPath + "camenter" + PathsInGame.ogg,
        PathsInGame.soundPath + "camloop" + PathsInGame.ogg,
        PathsInGame.soundPath + "flashlight" + PathsInGame.ogg,
        PathsInGame.soundPath + "phonecall" + PathsInGame.ogg,
        PathsInGame.soundPath + "changeCam" + PathsInGame.ogg,
        PathsInGame.soundPath + "garble" + PathsInGame.ogg,
        PathsInGame.soundPath + "boo" + PathsInGame.ogg,
        PathsInGame.soundPath + "dedstaticSound" + PathsInGame.ogg,
        PathsInGame.soundPath + "endCall" + PathsInGame.ogg,
        PathsInGame.soundPath + "doorSound" + PathsInGame.ogg,
        PathsInGame.soundPath + "sonicDies" + PathsInGame.ogg,
        PathsInGame.soundPath + "powerdown" + PathsInGame.ogg,
        PathsInGame.soundPath + "winning" + PathsInGame.ogg,
        PathsInGame.soundPath + "deathLine1" + PathsInGame.ogg,
        PathsInGame.soundPath + "deathLine2" + PathsInGame.ogg,
        PathsInGame.soundPath + "deathLine3" + PathsInGame.ogg,
        PathsInGame.soundPath + "deathLine4" + PathsInGame.ogg,
        PathsInGame.soundPath + "deathLine5" + PathsInGame.ogg,
        PathsInGame.soundPath + "deathLine6" + PathsInGame.ogg,
        PathsInGame.soundPath + "deathLine7" + PathsInGame.ogg,
        PathsInGame.soundPath + "hurt_grunt_1" + PathsInGame.ogg,
        PathsInGame.soundPath + "hurt_grunt_2" + PathsInGame.ogg,
        PathsInGame.soundPath + "hurt_grunt_3" + PathsInGame.ogg,
        PathsInGame.soundPath + "hurt_grunt_4" + PathsInGame.ogg,
        PathsInGame.soundPath + "honk" + PathsInGame.ogg,
        PathsInGame.menuPaths + "firstDegreeMurder" + PathsInGame.png,
        PathsInGame.menuPaths + PathsInGame.blackString + PathsInGame.png,
        PathsInGame.inGamePath + "muteButton" + PathsInGame.png,
        PathsInGame.inGamePath + "gameOverBG" + PathsInGame.png,
        PathsInGame.inGamePath + "gameOver" + PathsInGame.png,
        PathsInGame.inGamePath + "gameOverLight" + PathsInGame.png,
        PathsInGame.inGamePath + "Office" + PathsInGame.png,
        PathsInGame.inGamePath + "Office2" + PathsInGame.png,
        PathsInGame.inGamePath + "door" + PathsInGame.png,
        PathsInGame.inGamePath + "door" + PathsInGame.png,
        PathsInGame.inGamePath + "OfficeBlurry" + PathsInGame.png,
        PathsInGame.inGamePath + "doorHallway" + PathsInGame.png,
        PathsInGame.inGamePath + "sonicAtDoor" + PathsInGame.png,
        PathsInGame.inGamePath + "doorHallwayBlurry" + PathsInGame.png,
        PathsInGame.inGamePath + "jumpscares/blue_baby_jumpscare" + PathsInGame.png, 
        PathsInGame.inGamePath + "jumpscares/blue_baby_jumpscare" + PathsInGame.xml,
        PathsInGame.inGamePath + "jumpscares/SONIC" + PathsInGame.png, 
        PathsInGame.inGamePath + "jumpscares/SONIC" + PathsInGame.xml,
        PathsInGame.inGamePath + "jumpscares/goldenFreddyJumpscare" + PathsInGame.png,
        PathsInGame.inGamePath + "jumpscares/goldenFreddyJumpscare" + PathsInGame.xml,
        PathsInGame.inGamePath + "deadjumpscare" + PathsInGame.png, 
        PathsInGame.inGamePath + "deadjumpscare" + PathsInGame.xml,
        PathsInGame.inGamePath + "turning" + PathsInGame.png,
        PathsInGame.inGamePath + "turning" + PathsInGame.xml,
        PathsInGame.inGamePath + "Flashlight" + PathsInGame.png,
        PathsInGame.inGamePath + "win" + PathsInGame.png,
        PathsInGame.inGamePath + "win" + PathsInGame.xml,
        PathsInGame.inGamePath + "numbers" + PathsInGame.png,
        PathsInGame.inGamePath + "numbers" + PathsInGame.xml,
        PathsInGame.camFlipPath,
        PathsInGame.inGamePath + "camera" + PathsInGame.flipString + PathsInGame.xml,
        PathsInGame.cameraPath + PathsInGame.staticString + PathsInGame.png,
        PathsInGame.cameraPath + PathsInGame.staticString + PathsInGame.xml,
        PathsInGame.cameraPath + "camScene1" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene1Animatronic" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene2Animatronic" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene3Animatronic" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene4Animatronic" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene5Animatronic" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene1AnimatronicBlue" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene2AnimatronicBlue" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene3AnimatronicBlue" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene4AnimatronicBlue" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene5AnimatronicBlue" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene1Animatronic2" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene2Animatronic2" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene3Animatronic2" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene4Animatronic2" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene5Animatronic2" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene2" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene3" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene4" + PathsInGame.png,
        PathsInGame.cameraPath + "camScene5" + PathsInGame.png,
        PathsInGame.cameraPath + "map" + PathsInGame.png,
        PathsInGame.cameraPath + "map" + PathsInGame.xml,
        PathsInGame.menuPaths + PathsInGame.blackString + PathsInGame.png,
        PathsInGame.menuPaths + PathsInGame.blackString + PathsInGame.png,
        PathsInGame.menuPaths + PathsInGame.blackString + PathsInGame.png,
        PathsInGame.inGamePath + "battery" + PathsInGame.png,
        PathsInGame.inGamePath + "battery" + PathsInGame.xml,
        PathsInGame.inGamePath + "cambutton" + PathsInGame.png
    ];
    }

    public function loadAssets():Void 
    {
        for (assetPath in assetsToLoad)
        {
            if (endsWith(assetPath, ".ogg"))
            {
                var sound:Sound = new Sound();
                sound.addEventListener(Event.COMPLETE, onAudioLoaded);
                sound.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent) { onAssetError(e, assetPath); });
                sound.load(new URLRequest(assetPath));
            }
            else if (endsWith(assetPath, ".xml"))
            {
                var xmlLoader:URLLoader = new URLLoader();
                xmlLoader.dataFormat = URLLoaderDataFormat.TEXT;
                xmlLoader.addEventListener(Event.COMPLETE, onXMLLoaderComplete);
                xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent) { onAssetError(e, assetPath); });
                xmlLoader.load(new URLRequest(assetPath));
            }
            else
            {
                var loader:Loader = new Loader();
                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAssetLoaded);
                loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent) { onAssetError(e, assetPath); });
                loader.load(new URLRequest(assetPath));
            }
        }
    }

    private function onAssetError(event:IOErrorEvent, assetPath:String):Void 
    {
        trace("Failed to load asset: " + assetPath + " | Error: " + event.text);
    }
        

    private function endsWith(str:String, suffix:String):Bool
    {
        if (str.length < suffix.length) return false;
        return str.substr(-suffix.length) == suffix;
    }

    private function onAudioLoaded(event:Event):Void
    {
        // Audio file loaded
        handleAssetLoaded();
    }

    private function handleAssetLoaded():Void
    {
        loadedAssets++;
        currentProgress = loadedAssets / assetsToLoad.length;
        loadedAssetsCount = loadedAssets;
        totalAssetsCount = assetsToLoad.length;

        onProgress.dispatch();

        if (currentProgress >= 1)
        {
            onComplete.dispatch();
        }
    }

    private function onXMLLoaderComplete(event:Event):Void
    {
        // XML file loaded
        handleAssetLoaded();
    }

    private function onAssetLoaded(event:Event):Void
    {
        var loader:Loader = cast(event.currentTarget.loader, Loader);
        var bitmap:Bitmap = cast(loader.content, Bitmap);
        var key:String = event.currentTarget.url; // Or however you define the key
        trace("Asset loaded: " + key);
        loadedBitmaps.set(key, bitmap);

        loadedAssets++;
        currentProgress = loadedAssets / assetsToLoad.length;
        loadedAssetsCount = loadedAssets; // Update the count
        totalAssetsCount = assetsToLoad.length; // Set the total count
        onProgress.dispatch(); // No parameters

        if (currentProgress >= 1)
        {
            onComplete.dispatch();
        }
    }
}



