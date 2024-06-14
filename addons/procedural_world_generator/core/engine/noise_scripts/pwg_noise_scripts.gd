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
	print("double make")
	self.noise_misc = FastNoiseLite.new()
	self.noise_alt = FastNoiseLite.new()
	self.noise_moist = FastNoiseLite.new()
	self.noise_temp = FastNoiseLite.new()


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


## Guestimated/approximated noise values at certain percentiles[br]
## for this instance's [class FastNoiseLite] configurations.[br]
## Should be overridden by inheriting classes.[br]
## [WARNING]: These values are only estimates. For further details[br]
## about how the estimates were made, see TODO: Put methodology somewhere o-o
func get_percentile_value(percentile: int) -> float:
	match percentile:
		5:
			return -0.4
		10:
			return -0.32
		15:
			return -0.28
		20:
			return -0.22
		25:
			return -0.18
		30:
			return -0.14
		35:
			return -0.105
		40:
			return 0.0
		45:
			return 0.0
		50:
			return 0.0
		55:
			return 0.0
		60:
			return 0.0
		65:
			return 0.0
		70:
			return 0.0
		75:
			return 0.0
		80:
			return 0.0
		85:
			return 0.0
		90:
			return 0.0
		95:
			return 0.0
		100:
			return 0.0
		_:
			return -99.99
			
	return 0.0
