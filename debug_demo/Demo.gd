extends Node2D

@onready var tmap := $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	#var engine := PwgGlobal.get_engine()
	#var seed := randi()
	#var new_world := engine.generate_world(seed, 256, 256, $TileMap)
	
	var engine = PwgEngine.new()
	engine.set_scripts(PwgNoiseScripts.NoiseScripts.DEFAULT)
	engine.new_gen(100, 100, tmap)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
