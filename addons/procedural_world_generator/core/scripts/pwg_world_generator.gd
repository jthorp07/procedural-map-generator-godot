@tool
class_name PwgWorldGenerator
extends Node
## An node that exposes editor configuration for an underlying instance[br]
## of [class PwgEngine]

@export var tile_set: TileSet
@export_group("World Settings")
@export var map_shape: PwgMapShape.MapShape = PwgMapShape.MapShape.RECTANGLE:
	set(val):
		_map_shape_config = PwgMapShape.make_map_shape(val)
		print(_map_shape_config.get_class())
		map_shape = val
		notify_property_list_changed()
				
@export var _map_shape_config: PwgMapShape = PwgMapShape.new()
@export_group("Noise Settings")
## The noise that will be used to make the height map for the world
@export var noise_scripts: PwgNoiseScripts.NoiseScripts = PwgNoiseScripts.NoiseScripts.DEFAULT
@export_group("Biome Settings")
## Flag Values:[br][br]
## [code]apply_polar_heatmap[/code] - When set, applies a heat map on top of the
## noise values that results in a hot equator (mid Y values) and cold poles (high 
## and low Y values)[br]
## [code]moisture_x_heat_y[/code] - When set, indexes into texture atlas assuming 
## moisture values should increase from left to right and heat values should
## increase from top to bottom. Else switches axes.[br]
## [code]ignore_heat[/code] - When set, heat noise will be discarded.[br]
## [b]NOTE:[/b] If the heat map flag is set, the heat map will still be used to 
## index into the texture atlas[br]
## [code]ignore_moisture[/code] - When set, moisture noise will be discarded.[br]
## [b]NOTE:[/b] This does not affect bodies of water, only biomes
@export_flags("Apply Polar Heatmap:1", "Moisture=X Axis\nHeat=Y Axis:2",\
		"Ignore Heat Noise:4", "Ignore Moisture Noise:8") var biome_flags: int = 0


var engine = PwgEngine.new()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
