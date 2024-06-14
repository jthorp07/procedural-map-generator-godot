class_name PwgCustomNoiseScript
extends PwgNoiseScripts
## Basically an editor interface for [class PwgNoiseScripts].[br]
## Exports all noise scripts to the editor so that they can be[br]
## tuned there.[br][br]
## [b]WARNING:[/b] This class is meant for developer use in the[br]
## editor for testing and debugging. To make a script that can[br]
## be customized by end users, you will have to make your own UI[br]
## to provide that access.

@export var e_noise_misc: FastNoiseLite
@export var e_noise_alt: FastNoiseLite
@export var e_noise_moist: FastNoiseLite
@export var e_noise_temp: FastNoiseLite


func _init() -> void:
	if e_noise_alt != null:
		noise_alt = e_noise_alt
	if e_noise_moist != null:
		noise_moist = e_noise_moist
	if e_noise_temp != null:
		noise_temp = e_noise_temp
	if e_noise_misc != null:
		noise_misc = e_noise_misc
