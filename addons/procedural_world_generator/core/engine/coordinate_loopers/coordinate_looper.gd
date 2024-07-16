class_name CoordinateLooper
extends Resource
## Used as a contract class by [class PwgEngine] to provide an interface[br]
## for developing and injecting new methods to obtain and apply noise values[br]
## to the generation of worlds by the engine. Custom implementations should[br]
## extend this class and reassign [member CoordinateLooper.looper] on initialization.


enum Loopers {
	RECTANGULAR,
	CYLINDRICAL_X,
	CYLINDRICAL_Y
}

## Should be a function that extracts noise values from [param scripts][br]
## for a set of coodrinates corresponding to [param width] and [param height][br]
## and calls [param filler_lambda] for each set of coords and noise values.
var looper: Callable = func(width: int, height: int, scripts: PwgNoiseScripts, filler_lambda: Callable):
	for x in range(width):
		for y in range(height):
			var altitude = NoiseScriptUtils.scale_noise(scripts.noise_alt.get_noise_2d(x, y))
			var moisture = NoiseScriptUtils.scale_noise(scripts.noise_moist.get_noise_2d(x, y))
			var temperature = NoiseScriptUtils.scale_noise(scripts.noise_temp.get_noise_2d(x, y))
			var misc = NoiseScriptUtils.scale_noise(scripts.noise_misc.get_noise_2d(x, y))
			#print("Alt: %f, Mst: %f, Tmp: %f, Msc: %f\n" % [altitude, moisture, temperature, misc])
			filler_lambda.call(x, y, altitude, moisture, temperature, misc)


## Calls this instance's [member CoordinateLooper.looper]
func fill_map(width: int, height: int, scripts: PwgNoiseScripts, filler_lambda: Callable):
	looper.call(width, height, scripts, filler_lambda)
