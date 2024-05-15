extends Node3D


signal clicko


var button_clicker: PackedScene = preload("res://scenes/components/button_clicker.tscn")
var import: Script = preload("res://scripts/utils/import.gd")

var language = 'fr'

# Called when the node enters the scene tree for the first time.
func _ready():
	instantiate_buttons()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_click():
	$UI.increment_via_bpc()
	%LabelBananas.text = str($UI.bananas)
	clicko.emit()


func instantiate_buttons():
	var imported_clickers = import.import_json("res://json/clickers.json")

	for clicker in imported_clickers:
		var button = button_clicker.instantiate()
		
		button.clicker_name = clicker.name[language]
		button.value = clicker.value
		button.type = clicker.type
		button.price = clicker.price
		button.price_multiplier = clicker.price_multiplier
		button.picture_path = clicker.picture_path
		button.description = clicker.description[language]
		
		button.get_node('%Button').disabled = false
		button.nb_owned = 0
		
		if clicker.type == 'bps':
			%ClickerSection.add_child(button)
		elif clicker.type == 'bpc':
			%BuffSection.add_child(button)
