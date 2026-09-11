class_name FlashCard extends Control

@onready var _kana_symbol: RichTextLabel = %KanaSymbol
@onready var _input_phonetic: LineEdit = %InputPhonetic

@export var kana_array: Array[KanaData] = []

var current_kana_index := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_random_index()
	_show_current_kana()
	_input_phonetic.text_submitted.connect(_user_input) # Connects the text_submitted signal to when the player presses enter.
	_input_phonetic.grab_focus()

## Used to update to the new kana, whenever the next kana advances.
func _show_current_kana() -> void:
## We use "kana" as a key to display the "value" of the dictionary.
	_kana_symbol.text = kana_array[current_kana_index].kana_character
	_input_phonetic.grab_focus()

## Takes the users text input and matches it against the current kana in romaji.
func _user_input(new_string: String) -> void:
	var guess := new_string.strip_edges().to_lower()
	var correct: String = kana_array[current_kana_index].romaji_character
	
	if guess == correct:
		print("Correct!")
		_next_kana()
	else:
		print("Try again.")
	
	_input_phonetic.clear() # Clears the LineEdit.
	_input_phonetic.grab_focus()

## Advances to the next kana in the array.
func _next_kana() -> void:
	current_kana_index += 1
	
	if current_kana_index >= kana_array.size() -1:
		print("Deck Complete!")
		get_tree().quit()
	
	_show_current_kana()

## Shuffles the array.
func _random_index() -> void:
	kana_array.shuffle()
