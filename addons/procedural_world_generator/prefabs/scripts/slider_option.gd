class_name SliderOption
extends VBoxContainer

@onready var label := $LabelAndInputBox/ValueLabel
@onready var input := $LabelAndInputBox/ValueManualInput
@onready var slider := $ValueSlider

@export var value: int
@export var value_name: StringName
@export var minimum: int
@export var maximum: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _init(use_args: bool = false, vname: StringName = &"UnnamedSliderOption", initial_value: int = 0, min_value: int = 0, max_value: int = 100) -> void:
	if not use_args:
		return
	value = initial_value
	value_name = vname
	minimum = min_value
	maximum = max_value

func _on_value_slider_value_changed(new_value: float) -> void:
	value = maxi(mini(int(snapped(new_value, 1)), maximum), minimum)
	input.text = str(value)
	pass


func _on_value_manual_input_text_submitted(new_text: String) -> void:
	if new_text.is_valid_int():
		var new_text_value := new_text.to_int()
		if new_text_value >= minimum and new_text_value <= maximum:
			value = new_text_value
		slider.value = value
