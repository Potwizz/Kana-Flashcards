extends Control

@onready var _kana_symbol: RichTextLabel = %KanaSymbol
@onready var _input_phonetic: LineEdit = %InputPhonetic

var current_kana_index := 0

var kana_array: Array[Dictionary] = [
	{
		"romaji": "a", "kana" : "あ"
	},
	{
		"romaji" : "i", "kana" : "い"
	}
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_show_current_kana()
	print("array size: " + str(current_kana_index))
	_input_phonetic.text_submitted.connect(_user_input)
	_input_phonetic.grab_focus()

func _show_current_kana() -> void:
## We use "kana" as a key to display the "value" of the dictionary.
	_kana_symbol.text = kana_array[current_kana_index]["kana"]

func _user_input(new_string: String) -> void:
	var guess := new_string.strip_edges().to_lower()
	var correct: String = kana_array[current_kana_index]["romaji"]
	
	if guess == correct:
		print("Correct!")
		_next_kana()
	else:
		print("Try again.")
	
	_input_phonetic.clear()
	_input_phonetic.grab_focus()

func _next_kana() -> void:
		current_kana_index += 1
		if current_kana_index >= kana_array.size():
			print("Deck complete!")
			current_kana_index = 0
		_show_current_kana()
