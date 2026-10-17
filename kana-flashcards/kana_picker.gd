class_name KanaPicker extends Control

@onready var _kana_container: GridContainer = %GridContainer

@export var kana_table: KanaTables
@export var picked_kana: Array[KanaData] = []

var current_kana_index := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_buttons()
	for button in _kana_container.get_children():
		if button is Button:
			button.pressed.connect(_pick_kana_press)

func _create_buttons() -> void:
	for kana_entry: Dictionary in kana_table.basic_hiragana_table:
		var button := Button.new()
		_kana_container.add_child(button)
		button.text = kana_entry["kana"]



func _pick_kana_press() -> void:
	for button in _kana_container.get_children():
		if button is Button:
			for kana_entry: Dictionary in kana_table.basic_hiragana_table:
				if kana_entry["kana"] == button.text:
					picked_kana.append(kana_entry)
					print(picked_kana)
					## Stop finding once we found a match.
					break
