extends Node3D


var button_clicker: PackedScene = preload("res://scenes/components/button_clicker.tscn")
var import: Script = preload("res://scripts/utils/import.gd")

var language = 'fr'


func _ready():
	instantiate_buttons()

func _process(delta):
	increment_via_bps(delta)
	disable_expensive_clickers()
	

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

func _on_build(clicker):
	%World.toggle_build_mode(true, clicker)


############## Clicker
var bananas: float = 0:
	set(new_val):
		bananas = new_val
		%LabelBananas.value = bananas
	get:
		return bananas

var bananas_total: float = 0:
	set(new_val):
		bananas_total = new_val
		#%LabelBananasTotal.value = new_val
	get:
		return bananas_total

var pollution_total: float = 0:
	set(new_val):
		pollution_total = new_val
		#%LabelPollution.value = new_val
	get:
		return pollution_total

var bps: float = 0:
	set(new_val):
		bps = new_val
		#%LabelBps.value = bps
	get:
		return bps

var bpc: float = 1:
	set(new_val):
		bpc = new_val
		#%LabelBpc.value = bpc
	get:
		return bpc


func increment_bananas(amount: float) -> void:
	bananas += amount

	if amount > 0:
		bananas_total += amount
		pollution_total += (amount * 160) / 1000
	
	print(bananas)

func increment_via_bps(delta: float) -> void:
	increment_bananas(bps * delta)

func increment_via_bpc() -> void:
	increment_bananas(bpc)

func increment_bp(amount: float, type: String) -> void:
	self[type] += amount

func _on_button_main_pressed() -> void:
	increment_via_bpc()

func disable_expensive_clickers() -> void:
	for b in %ClickerSection.get_children() + %BuffSection.get_children():
		b.get_node("AspectRatioContainer").get_node("Button").disabled = bananas < b.price

func _on_buy(clicker: Dictionary) -> void:
	increment_bp(clicker.value, clicker.type)
	increment_bananas(-clicker.price)
