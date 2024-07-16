extends Node2D

@onready var tmap := $TileMap


func _ready():
	var engine = PwgEngine.new()
	engine.set_scripts(PwgNoiseScripts.NoiseScripts.GRAND_RIVERS)
	engine.new_gen(750, 750, tmap)


func _process(_delta):
	pass


func _test_utils_values_print():
	print("test utils")
	for i in range(20):
		print("test %d %f\n" % [(i + 1) * 5, NoiseScriptUtils.get_percentile_value((i + 1) * 5)])
