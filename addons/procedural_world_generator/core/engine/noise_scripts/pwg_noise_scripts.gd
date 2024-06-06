class_name PwgNoiseScripts
extends Resource
## Used as a contract class by [class PwgEngine] to provide an interface[br]
## for developing and injecting new noise scripts to be used for the br]
## generation of worlds by the engine. Custom implementations should[br]
## extend this class and reassign [member PwgNoiseScript.noise_misc],[br]
## [member PwgNoiseScript.noise_alt], [member PwgNoiseScript.noise_moist],[br]
## and [member PwgNoiseScript.noise_temp], on initialization.


enum NoiseScripts {
	DEFAULT,
	CUSTOM,
	GRAND_RIVERS
}


## An additional noise configuration if one is needed. :)
var noise_misc: FastNoiseLite
## Altitude noise. Used to determine whether tiles are land, or non-land.
var noise_alt: FastNoiseLite
## Moisture noise. Used to determine the moisture/humidity of land tiles.
var noise_moist: FastNoiseLite
## Temperature noise. Used to determine the average temperature of tiles.
var noise_temp: FastNoiseLite


func _init() -> void:
	noise_misc = FastNoiseLite.new()
	noise_alt = FastNoiseLite.new()
	noise_moist = FastNoiseLite.new()
	noise_temp = FastNoiseLite.new()


static func make_scripts(script_type: NoiseScripts) -> PwgNoiseScripts:
	match script_type:
		NoiseScripts.DEFAULT:
			return PwgNoiseScripts.new()
		NoiseScripts.CUSTOM:
			return PwgCustomNoiseScript.new()
		NoiseScripts.GRAND_RIVERS:
			return PwgGrandRiversNoise.new()
		_:
			return PwgNoiseScripts.new()
