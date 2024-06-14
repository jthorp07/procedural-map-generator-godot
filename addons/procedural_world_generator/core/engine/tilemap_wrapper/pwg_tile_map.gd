class_name PwgTileMap
extends Node
## A node that contains and prepares a [class TileMap][br]
## that can be used by a [class PwgEngine].

enum PwgTileMapLayer {
	BIOME,
	TERRAIN,
	BUILDABLE,
	UNIT,
	FOG
}


## [class TileSetAtlasSource] to be used as the biome[br]
## atlas for the [class TileMap] prepared by this node.
@export var biome_atlas: TileSetAtlasSource = null:
	set(val):
		biome_atlas = val
		_tileset._biome_atlas = val
## [class TileSetAtlasSource] to be used as the terrain[br]
## set atlas for the [class TileMap] prepared by this node.
@export var terrain_atlas: TileSetAtlasSource = null:
	set(val):
		terrain_atlas = val
		_tileset._terrain_set_atlas = val
var _underlying: TileMap = null
var _tileset: PwgTileSet = PwgTileSet.new()


## Sets the [class TileMap] reference that will be prepared[br]
## and returned by [method PwgTileMap.get_tilemap].
func set_tilemap(tmap: TileMap):
	_underlying = tmap


func get_tilemap() -> TileMap:
	_prep_tilemap()
	return _underlying


func set_biome_atlas(atlas: TileSetAtlasSource):
	biome_atlas = atlas
	_tileset.add_source(atlas, 0)


## Resets all layers that will be used by the engine in[br]
## the TileMap.
func _prep_tilemap() -> TileMap:
	if _underlying == null:
		_underlying = TileMap.new()
	for i in range(PwgTileMapLayer.size()):
		_underlying.remove_layer(i)
		_underlying.add_layer(i)
	_tileset.prep()
	_underlying.tile_set = _tileset._underlying
	return _underlying
		
