class_name PwgTileSet
extends Node


const DEFAULT_TILESET_PATH := &"res://addons/procedural_world_generator/default_assets/default_square_32x32_tileset.tres"


var _biome_atlas: TileSetAtlasSource
var _terrain_set_atlas: TileSetAtlasSource
var _underlying: TileSet


func _init() -> void:
	var default_terrain_set: TileSet = ResourceLoader.load(DEFAULT_TILESET_PATH)
	_biome_atlas = default_terrain_set.get_source(1)
	_terrain_set_atlas = default_terrain_set.get_source(0)
	_underlying = TileSet.new()


func prep() -> void:
	_underlying.add_source(_biome_atlas, 1)
	_underlying.add_source(_terrain_set_atlas, 0)
