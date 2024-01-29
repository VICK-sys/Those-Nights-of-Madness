package;

import flixel.util.FlxTimer;

class Animatronic2 {
    public var currentCamera:Int;
    public var active:Bool;
    public var name2:String;
    public var path:Array<Int>; // Preset path of camera indices the animatronic will follow
    public var pathIndex:Int; // Current position in the path
    public var moveCooldown:Float; // Cooldown time before next move
    public var moveTimer:FlxTimer; // Timer to handle movement cooldown
    public var aiLevel:Int;

    public static var sonicMoved:Bool = false;
    public static var sonicMoved2:Bool = false;
    public static var sonicMoved3:Bool = false;
    public static var sonicMoved4:Bool = false;
    public static var sonicMoved5:Bool = false;

    public static var youAreDead:Bool = false;

    public static var sonicGotYou:Bool = false;

    public function new(path:Array<Int>, name2:String, aiLevel:Int) {
        this.currentCamera = path[0]; // Start at the first camera in the path
        this.path = path;
        this.name2 = name2;
        this.active = false;
        this.pathIndex = 0;
        this.moveCooldown = 4.97;
        this.aiLevel = aiLevel;
        this.moveTimer = new FlxTimer();
    }
    
    public function activate():Void {
        this.active = true;
        trace("Activating");
    
        updateCameraFeedVisual(this.currentCamera, this.name2); // Ensure initial visibility
        moveToNextCamera();
    }    

    private function moveToNextCamera():Void {
        if (this.active) {
            var randomNumber:Int = Math.floor(Math.random() * 20) + 1; // Generate a number between 1 and 20
        
            if (randomNumber <= this.aiLevel) {
                if(PlayState.sonicGotFlashed) {
                    this.pathIndex = 0;
                    PlayState.sonicGotFlashed = false;
                    PlayState.sonicIsNearOffice = false;
                    PlayState.flashTriggered = false;
                    PlayState.doorHallway2.visible = false;
                    PlayState.doorHallway2.alpha = 1;
                } else if (this.pathIndex < this.path.length - 1) {
                    this.pathIndex++;
                    switch(pathIndex)
                    {
                        case 0:
                            sonicMoved = true;
                        case 1:
                            sonicMoved2 = true;
                        case 2:
                            sonicMoved3 = true;
                        case 3:
                            sonicMoved4 = true;
                        case 4:
                            sonicMoved5 = true;
                    }
                }
        
                this.currentCamera = this.path[this.pathIndex];
                updateCameraFeedVisual(this.currentCamera, this.name2);
                trace("Updating Camera Feed Visual - Animatronic is now at camera: " + this.currentCamera);
            } else {
                trace("Animatronic did not move due to AI level check");
            }
        
            // Reset the move timer with the cooldown
            this.moveTimer.start(this.moveCooldown, function(tmr:FlxTimer) {
                moveToNextCamera(); // Move to the next camera after the cooldown
                trace("Moving To Next Camera");
            }, 1);
        }        
    }       

    private function updateCameraFeedVisual(cameraIndex:Int, animatronicName:String):Void {
        // Reset all animatronics to false
        PlayState.resetAnimatronicsVisibility();
    
        // Set the relevant animatronic to true based on the camera index
        switch (cameraIndex) {
            case 0:
                switch(name2) 
                {
                    case "Sonic":
                        PlayState.animatronicInRoomBlue = true;
                    default:
                        PlayState.animatronicInRoomBlue = false;
                }
            case 1: 
                switch(name2)
                {
                    case "Sonic":
                        PlayState.animatronicInRoomBlue2 = true;
                    default:
                        PlayState.animatronicInRoomBlue2 = false;
                }
            case 2: 
                switch(name2)
                {
                    case "Sonic":
                        PlayState.animatronicInRoomBlue3 = true;
                    default:
                        PlayState.animatronicInRoomBlue3 = false;
                }

            case 3: 
                switch(name2)
                {
                    case "Sonic":
                        PlayState.animatronicInRoomBlue4 = true;
                    default:
                        PlayState.animatronicInRoomBlue4 = false;
                }

            case 4: 
                switch(name2)
                {
                    case "Sonic":
                        PlayState.animatronicInRoomBlue5 = true;
                    default:
                        PlayState.animatronicInRoomBlue5 = false;
                }
            case 5: 
                switch(name2)
                {
                    case "Sonic":
                        PlayState.sonicIsNearOffice = true;
                    default:
                        PlayState.sonicIsNearOffice = false;
                }
            case 6:
                switch(name2)
                {
                    case "Sonic":
                        PlayState.sonicIsNearOffice = false;
                        kill2();
                }

        }        
    }

    public function updateAILevel(newLevel:Int):Void {
        this.aiLevel = newLevel;
        trace("AI Level updated to: " + this.aiLevel);
        // Adjust other properties like moveCooldown based on new AI level
    }    
    
    public function deactivate():Void {
        this.active = false;
        this.moveTimer.cancel(); // Stop the animatronic from moving
    }

    public function kill2()
    {
        Animatronic.babyGotYou = false;
        sonicGotYou = true;
        Animatronic3.goldenFreddyGotYou = false;
        youAreDead = true;
        trace("Sonic Killed You!");
    }
}
