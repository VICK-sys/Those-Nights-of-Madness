package;

import flixel.FlxGame;
import openfl.display.Sprite;
import lime.app.Application;


class Main extends Sprite
{
	public function new()
	{
		super();

		DiscordClient.start();
		addChild(new FlxGame(0, 0, TitleScreenState));
	}	
}
