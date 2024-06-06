class_name PwgTileMap
extends Node
## A wrapper for [class TileMap] that 

enum PwgTileMapLayer {
	BIOME,
	TERRAIN,
	BUILDABLE,
	UNIT,
	FOG
}


var biome_atlas
var _underlying: TileMap = null


func set_tilemap(tmap: TileMap):
	_underlying = tmap
	_prep_tilemap()


func get_tilemap() -> TileMap:
	return _underlying


## Resets all layers that will be used by the engine in[br]
## the TileMap.
func _prep_tilemap():
	if _underlying == null:
		_underlying = TileMap.new()
	for i in range(PwgTileMapLayer.size()):
		_underlying.remove_layer(i)
		_underlying.add_layer(i)
