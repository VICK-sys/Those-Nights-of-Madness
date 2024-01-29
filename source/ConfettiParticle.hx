import flixel.graphics.FlxGraphic;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.FlxG;
import flixel.util.FlxColor;

class ConfettiParticle extends FlxSprite {
    static var confettiBitmap:FlxGraphic;

    var velocityCap:Float;
    var velocityRate:Float = 5000;
    var velocityBurst:Float = -3000;
    var rotationSpeed:Float;
    var sineWaveOffset:Float;
    var windEffect:Float;
    var colorShiftRate:Float;
    var sizeChangeRate:Float;
    var rand:FlxRandom;

    public function new(color:FlxColor, sizeX:Int, sizeY:Int) {
        super(0, 0);
        if (confettiBitmap == null || confettiBitmap.key == null) {
            confettiBitmap = FlxG.bitmap.create(1, 1, 0xFFffffff, false, "confetti");
        }

        this.color = color;
        frames = confettiBitmap.imageFrame;
        scale.set(sizeX, sizeY);
        updateHitbox();

        rand = new FlxRandom();

        visible = false; // Make particles off by default
        active = false;
        moves = false; // Disable physics logic while off

        // Random properties for unique behaviors
        velocityCap = rand.float(150, 250); // Varying max fall speeds
        rotationSpeed = rand.float(-10, 10); // Random rotation speed
        sineWaveOffset = rand.float(0, 2 * Math.PI); // Sine wave offset
        windEffect = 0; // Initial wind effect
        colorShiftRate = rand.float(0.1, 1); // Color shift rate
        sizeChangeRate = rand.float(0.95, 1); // Size change rate
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        // Accelerate downwards until velocity cap is reached
        if (velocity.y < velocityCap) {
            velocity.y += velocityRate * elapsed;
        }

        // Disable particle once off-screen
        if (y > FlxG.height) {
            visible = false;
            moves = false;
            active = false;
            y = 0;
        }

        // Apply unique behaviors when visible
        if (visible) {
            // Sine wave horizontal movement
            x += Math.sin(FlxG.elapsed + sineWaveOffset) * 5;

            // Wind effect
            if (rand.int(0, 100) < 5) { // 5% chance to change wind effect
                windEffect = rand.float(-50, 50);
            }
            velocity.x += windEffect * elapsed;

            // Color shift
            color = FlxColor.interpolate(color, FlxColor.WHITE, colorShiftRate * elapsed);

            // Size change
            scale.set(scale.x * sizeChangeRate, scale.y * sizeChangeRate);

            // Rotation
            angle += rotationSpeed;
        }
    }

    override function updateAnimation(elapsed:Float):Void {}

    // Launch the particle with random velocity and enable physics
    public function launchParticle() {
        velocity.y = velocityBurst;
        velocity.x = rand.float(-100, 100);
        visible = true; // Make visible again
        active = true;
        moves = true; // Enable physics logic
    }
}
