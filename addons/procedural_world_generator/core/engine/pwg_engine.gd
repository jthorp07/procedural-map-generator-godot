class_name PwgEngine
extends Resource
## Parent node of the Procedural World Generator engine
## 
## Holds and exposes configuration values for world generation.[br]
## Also exposes methods methods that return a generated world using the[br]
## engine's current configuration.

# signals

# enums
## The shape of individual tiles on the map
enum TileShape {
	## Square tiles
	SQUARE,
	## Hexagonal tiles
	HEXAGON,
}


# constants

var tileset: TileSet
var tile_shape: TileShape
var _noise_scripts: PwgNoiseScripts = PwgNoiseScripts.make_scripts(PwgNoiseScripts.NoiseScripts.DEFAULT)
var _looper: CoordinateLooper = CoordinateLooper.new()
var _tilemap_wrapper: PwgTileMap = PwgTileMap.new()
var _land_cells: Array[Vector2i] = []
var _tilemap_node: TileMap = null
var _spawn: Vector2i
# optional built-in virtual _init method

# optional built-in virtual _enter_tree() method

# built-in virtual _ready method

# remaining built-in virtual methods

# public methods
## Generates and returns a new world using the engine's[br]
## current settings. The world is returned in a new [TileMap] node.
func generate_world(seed: int, width: int, height: int, tilemap: TileMap) -> TileMap:
	#var tilemap := TileMap.new()

	# print("actual:\n%d\n%d\n%d" % [_noise_alt.seed, _noise_moisture.seed, _noise_temp.seed])
	
	tilemap.tile_set = tileset
	tilemap.add_layer(1)
	
	var spawn := tilemap.local_to_map(Vector2(0, 0))
	var land_cells: Array[Vector2i] = []
	
	for x in range(width):
		for y in range(height):
			var coords := Vector2i(spawn.x - width / 2 + x, spawn.y - height / 2 + y)
			
			var height_noise := _noise_scripts.noise_alt.get_noise_2dv(coords)
			var moisture_noise := _noise_scripts.noise_moist.get_noise_2dv(coords)
			var temp_noise := _noise_scripts.noise_temp.get_noise_2dv(coords)
			
			# if x == 100 and y == 100:
				# print("100, 100:\n%f\n%f\n%f\n" % [height_noise, moisture_noise, temp_noise])
			
			if moisture_noise > .5:
				land_cells.append(coords)
				var atlas_coords := Vector2(min(round((moisture_noise + 10) / 5), 2), round((temp_noise + 10) / 5))
				tilemap.set_cell(PwgTileMap.PwgTileMapLayer.BIOME, coords, 1, atlas_coords.floor())
			else:
				var atlas_coords := Vector2(3, round((temp_noise + 10) / 5))
				tilemap.set_cell(0, coords, 1, atlas_coords.floor())
			
			# var height_noise := _noise_alt.get_noise_2dv(coords) * 150
			# var moisture_noise := _noise_moisture.get_noise_2dv(coords) * 10
			# var temp_noise := _noise_temp.get_noise_2dv(coords) * 10
			
			# if moisture_noise > .5:
				# land_cells.append(coords)
				# var atlas_coords := Vector2(min(round((moisture_noise + 10) / 5), 2), round((temp_noise + 10) / 5))
				# tilemap.set_cell(0, coords, 1, atlas_coords.floor())
			# else:
				# var atlas_coords := Vector2(3, round((temp_noise + 10) / 5))
				# tilemap.set_cell(0, coords, 1, atlas_coords.floor())
	
	tilemap.set_cells_terrain_connect(1, land_cells, 0, 0)
	print("Land percent: %f\n" % [land_cells.size() / (float(width) * float(height))])
	return tilemap


func new_gen(width: int, height: int, tilemap: TileMap):
	
	# Init:
	#		- Make script
	#		- Set seeds
	_tilemap_wrapper.set_tilemap(tilemap)
	_initialize_world_gen()
	_looper.fill_map(width, height, _noise_scripts, _map_fill_lambda)
	_world_gen_cleanup()
	pass


## Sets the engine's noise scripts to one of the sets of scripts[br]
## defined in [enum PwgNoiseScripts.NoiseScripts] and [method PwgNoiseScripts.make_scripts].
func set_scripts(script_type: PwgNoiseScripts.NoiseScripts):
	_noise_scripts = PwgNoiseScripts.make_scripts(script_type)


# private methods
## Sets a random seed for all [class FastNoiseLite] instances in this [br]
## instance's [member PwgEngine._noise_scripts]. Called at the beginning[br]
## of world generation.
func _initialize_world_gen():
	
	# Idk why but these values don't get initialized when they should be earlier
	if _noise_scripts == null:
		_noise_scripts = PwgNoiseScripts.make_scripts(PwgNoiseScripts.NoiseScripts.DEFAULT)
	elif _noise_scripts.noise_alt == null:
		print("had to reassign :(")
		_noise_scripts.noise_misc = FastNoiseLite.new()
		_noise_scripts.noise_alt = FastNoiseLite.new()
		_noise_scripts.noise_moist = FastNoiseLite.new()
		_noise_scripts.noise_temp = FastNoiseLite.new()
		
	# Seed all the noise scripts
	seed(randi())
	var seeds = Vector4(randi() / 100, randi() / 100, randi() / 100, randi() / 100)
	_noise_scripts.noise_alt.seed = seeds.x
	_noise_scripts.noise_moist.seed = seeds.y
	_noise_scripts.noise_temp.seed = seeds.z
	_noise_scripts.noise_misc.seed = seeds.w
	
	# Set tilemap node to fill
	_tilemap_node = _tilemap_wrapper.get_tilemap()


func _world_gen_cleanup():
	# cleanup
	_tilemap_node = null
	_land_cells = []


## Function to be passed to [method CoordinateLooper.fill_map]. This method[br]
## should be called and provided with noise values and coordinates for every[br]
## tile in the map that should be generated.
func _map_fill_lambda(x, y, altitude, moisture, temperature, misc):
	
	var coords = Vector2i(x, y)
	if moisture > .5:
		_land_cells.append(coords)
		var atlas_coords := Vector2(min(round((moisture + 10) / 5), 2), round((temperature + 10) / 5))
		_tilemap_node.set_cell(0, coords, 1, atlas_coords.floor())
	else:
		var atlas_coords := Vector2(3, round((temperature + 10) / 5))
		_tilemap_node.set_cell(0, coords, 1, atlas_coords.floor())
	_tilemap_node.set_cells_terrain_connect(1, _land_cells, 0, 0)


# subclasses
