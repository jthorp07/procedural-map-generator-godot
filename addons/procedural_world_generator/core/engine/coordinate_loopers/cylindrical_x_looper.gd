class_name CylindricalXLooper
extends CoordinateLooper


func _init() -> void:
	looper = func(width: int, height: int, scripts: PwgNoiseScripts, filler_lambda: Callable):
		var delta_rotation_x: float = TAU / float(width)
		var delta_rotation_y: float = TAU / float(height)
		var cur_x: float
		var fwidth: float = float(width)
		var fheight: float = float(height)
		for x in range(width):
			for y in range(height):
				# Sinusoidal functions with period=width and amplitude=width/2
				# Makes the looper still move 1 on each axis for each sample value & wrap on one axis
				var nx = fwidth / 2.0 * cos((TAU * float(x)) / fwidth)
				var ny = fwidth / 2.0 * sin((TAU * float(y)) / fwidth)
				var nz = y
				var altitude = scripts.noise_alt.get_noise_3d(nx, ny, nz)
				var moisture = scripts.noise_moist.get_noise_3d(nx, ny, nz)
				var temperature = scripts.noise_temp.get_noise_3d(nx, ny, nz)
				var misc = scripts.noise_misc.get_noise_3d(nx, ny, nz)
				filler_lambda.call(x, y, altitude, moisture, temperature, misc)
