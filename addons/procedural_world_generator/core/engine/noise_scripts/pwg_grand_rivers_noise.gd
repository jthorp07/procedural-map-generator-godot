class_name PwgGrandRiversNoise
extends PwgNoiseScripts

## Higher values will result in more "rivers" in the noise
@export var river_frequency_weight: int = 1
## Higher values will result in wider "rivers"
@export var river_width_weight: int = 5


func _init() -> void:
	super._init()
	noise_alt.fractal_type = FastNoiseLite.FRACTAL_RIDGED
	noise_alt.fractal_octaves = river_frequency_weight
	noise_alt.frequency = .001 * river_width_weight
