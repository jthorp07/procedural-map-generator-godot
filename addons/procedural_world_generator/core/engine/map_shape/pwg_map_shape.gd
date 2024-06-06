class_name PwgMapShape
extends Resource


## Represents options for map shapes supported by the engine.[br][br]
## [b]Note:[/b] Certain map shapes may be incompatible with some[br]
## engine configurations. These cases are documented in all of the[br]
## affected shapes, and in these cases, the shape will be used and[br]
## the affected configuration options will be ignored.[br]
## @experimental
enum MapShape {
	## A rectangular map. Map size parameters are width and height.
	RECTANGLE,
	## A hexagonal map. Map size parameter is side length.
	HEXAGON,
	# A spherical map. Radius should be supplied in place of width[br]
	# and the height parameter will be ignored.[br]
	# [b]Note:[/b] This shape will disable map wrapping on any axis.
	#SPHERE
}


## Adds a dimension to the noise sampling so that the generated world can 
## seemlessly wrap from one side to the other
@export var wrap_horizontal: bool = true
## Adds a dimension to the noise sampling so that the generated world can 
## seemlessly wrap from top to bottom
@export var wrap_vertical: bool = false


static func make_map_shape(shape: MapShape) -> PwgMapShape:
	match shape:
		PwgMapShape.MapShape.RECTANGLE:
			return PwgMapShape.new()
		PwgMapShape.MapShape.HEXAGON:
			return PwgHexMapShape.new()
		_:
			return PwgMapShape.new()
