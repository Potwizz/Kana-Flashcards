class_name KanaPicker extends Control

@onready var _kana_container: GridContainer = %GridContainer

@export var kana_table: KanaTables
var picked_kana: Array[KanaData] = []

var current_kana_index := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_buttons()

func _create_buttons() -> void:
	for kana_entry: Dictionary in kana_table.hiragana_table:
		var button := Button.new()
		_kana_container.add_child(button)
		button.text = kana_entry["kana"]
