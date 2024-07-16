class_name NoiseScriptUtils
extends Resource


const DEFAULT_SCALAR: float = 16.0 + (2.0 / 3.0)
const ONE_THIRD: float = 1.0 / 3.0

static func scale_noise(val: float#, fractal_type: FastNoiseLite.FractalType, noise_type: FastNoiseLite.NoiseType, dimension: int
						) -> float:
	var raw_scaled = (val + 0.6) * DEFAULT_SCALAR
	return maxf(raw_scaled, 0.0)

## Returns an estimate of the threshold for [param percentile] for a given[br]
## [class FastNoiseLite] configuration.[br]
## @experimental
static func get_percentile_value(percentile: int#, fractal_type: FastNoiseLite.FractalType, noise_type: FastNoiseLite.NoiseType, dimension: int
								) -> float:
	match percentile:
		5:
			return 3.0 + ONE_THIRD
		10:
			return 4.0 + (2.0 * ONE_THIRD)
		15:
			return 5.0 + ONE_THIRD 
		20:
			return 6.0 + ONE_THIRD
		25:
			return 7.0
		30:
			return 7.0 + (2.0 * ONE_THIRD)
		35:
			return 8.25
		40:
			return 8.8 + (ONE_THIRD / 10.0)
		45:
			return 9.41 + ((2.0 * ONE_THIRD) / 100.0)
		50:
			return 10.0
		55:
			return 10.5
		60:
			return 11.0
		65:
			return 11.0 + (2.0 * ONE_THIRD)
		70:
			return 12.0 + ONE_THIRD
		75:
			return 12.8 + (ONE_THIRD / 10.0)
		80:
			return 13.0 + (2.0 * ONE_THIRD)
		85:
			return 14.5
		90:
			return 15.0 + (2.0 * ONE_THIRD)
		95:
			return 16.0 + (2.0 * ONE_THIRD)
		100:
			return 20.0
		_:
			return -1.0
