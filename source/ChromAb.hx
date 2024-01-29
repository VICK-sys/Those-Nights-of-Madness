import flixel.system.FlxAssets.FlxShader;

class ChromAb extends FlxShader // https://www.shadertoy.com/view/XtBXDt
{
	@:glFragmentSource('
	{
		#pragma header

		uniform vec3 iResolution;           // viewport resolution (in pixels)
		uniform float iTime;                 // shader playback time (in seconds)
		uniform float     iTimeDelta;            // render time (in seconds)
		uniform float     iFrameRate;            // shader frame rate
		uniform int       iFrame;                // shader playback frame
		uniform float     iChannelTime[4];       // channel playback time (in seconds)
		uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)
		uniform vec4      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
		uniform samplerXX iChannel0..3;          // input channel. XX = 2D/Cube
		uniform vec4      iDate;                 // (year, month, day, time in seconds)
		uniform float     iSampleRate;           // sound sample rate (i.e., 44100)

		vec2 uv = fragCoord.xy / iResolution.xy;
	
		float amount = 0.0;
		
		amount = (1.0 + sin(iTime*6.0)) * 0.5;
		amount *= 1.0 + sin(iTime*16.0) * 0.5;
		amount *= 1.0 + sin(iTime*19.0) * 0.5;
		amount *= 1.0 + sin(iTime*27.0) * 0.5;
		amount = pow(amount, 3.0);
	
		amount *= 0.05;
		
		vec3 col;
		col.r = texture( iChannel0, vec2(uv.x+amount,uv.y) ).r;
		col.g = texture( iChannel0, uv ).g;
		col.b = texture( iChannel0, vec2(uv.x-amount,uv.y) ).b;
	
		col *= (1.0 - amount * 0.5);
		
		fragColor = vec4(col,1.0);
	}')
	
	public function new()
	{
		super();
		iTime.value = [0.0];
	}

	public function update(elapsed:Float)
	{
		iTime.value[0] += elapsed;
	}
}