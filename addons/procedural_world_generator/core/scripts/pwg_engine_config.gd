@tool
class_name PWGEngineConfig
extends Resource

## Parent node of the Procedural World Generator engine
## 
## Holds and exposes configuration values for world generation.[br]
## Also exposes methods methods that return a generated world using the[br]
## engine's current configuration.
## 
## @experimental

# signals

# enums

# constants

# @export variables
var PWGEngine = preload("res://addons/procedural_world_generator/core/engine/pwg_engine.gd")
@export_group("Tile Properties")
@export var tileset: TileSet
@export var tile_shape: PWGEngine.TileShape
## [b]IMPORTANT:[/b] See plugin docs (README.md) or examples on GitHub (if any are posted) for detailed instructions
@export var biome_count: int = 3

@export_group("World Generation Terrain Configuration")
@export_subgroup("Default Configurables")
## A value of 0 will result in a waterless world.[br]
## A value of 10 will result in a landless world.
@export_range(0, 10) var water_level
@export_range(0, 10) var moisture_level
@export_range(0, 10) var temperature_level
@export_subgroup("Custom Configurables")
@export var custom_worldgen_configs: Array[int] = [] # TODO: Refactor to WorldGenTerrainConfig

# public variables

# private variables

# @onready variables


# optional built-in virtual _init method

# optional built-in virtual _enter_tree() method

# built-in virtual _ready method

# remaining built-in virtual methods

# public methods

# private methods

# subclasses
