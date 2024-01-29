package;

import flixel.util.FlxTimer;

class Animatronic3 {
    public var currentCamera:Int;
    public var active:Bool;
    public var name3:String;
    public var path:Array<Int>; // Preset path of camera indices the animatronic will follow
    public var pathIndex:Int; // Current position in the path
    public var moveCooldown:Float; // Cooldown time before next move
    public var moveTimer:FlxTimer; // Timer to handle movement cooldown
    public var aiLevel:Int;

    public static var youAreDead:Bool = false;

    public static var goldenFreddyGotYou:Bool = false;

    public function new(path:Array<Int>, name3:String, aiLevel:Int) {
        this.currentCamera = 0;
        this.path = path;
        this.name3 = name3;
        this.active = false;
        this.pathIndex = 0;
        this.moveCooldown = 4.97; // Cooldown in seconds, adjust as needed
        this.aiLevel = aiLevel;
        this.moveTimer = new FlxTimer();
    }

    public function activate():Void {
        this.active = true;
        trace("Activating");

        moveToNextCamera();
    }

    private function moveToNextCamera():Void {
        if (this.active) {
            var randomNumber:Int = Math.floor(Math.random() * 20) + 1; // Generate a number between 1 and 20
    
            if (randomNumber <= this.aiLevel) {
                // Incrementally move to the next camera, or reset to the first if at the end
                if (this.pathIndex < this.path.length - 1) {
                    this.pathIndex++;
                }
    
                this.currentCamera = this.path[this.pathIndex];
                updateCameraFeedVisual(this.currentCamera, this.name3);
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
                switch(name3) 
                {
                    case "Golden Freddy":
                        //PlayState.animatronicInRoomYellow = true;
                    default:
                        //PlayState.animatronicInRoomYellow = false;
                }
            case 1: 
                switch(name3)
                {
                    case "Golden Freddy":
                        //PlayState.animatronicInRoomYellow2 = true;
                    default:
                        //PlayState.animatronicInRoomYellow2 = false;
                }
            case 2: 
                switch(name3)
                {
                    case "Golden Freddy":
                        //PlayState.animatronicInRoomYellow3 = true;
                    default:
                        //PlayState.animatronicInRoomYellow3 = false;
                }

            case 3: 
                switch(name3)
                {
                    case "Golden Freddy":
                        //PlayState.animatronicInRoomYellow4 = true;
                    default:
                        //PlayState.animatronicInRoomYellow4 = false;
                }

            case 4: 
                switch(name3)
                {
                    case "Golden Freddy":
                        //PlayState.animatronicInRoomYellow5 = true;
                    default:
                        //PlayState.animatronicInRoomYellow5 = false;
                }
            case 5: 
                switch(name3)
                {
                    case "Golden Freddy":
                        //PlayState.animatronicInRoomYellow5 = false;
                        kill3();
                }
        }        
    }
    
    public function deactivate():Void {
        this.active = false;
        this.moveTimer.cancel(); // Stop the animatronic from moving
    }

    public function kill3()
    {
        Animatronic.babyGotYou = false;
        Animatronic2.sonicGotYou = false;
        goldenFreddyGotYou = true;
        youAreDead = true;
        trace("Golden Freddy Killed You!");
    }
}
