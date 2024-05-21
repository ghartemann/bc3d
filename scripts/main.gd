extends Node3D

var button_clicker: PackedScene = preload("res://scenes/components/button_clicker.tscn")
var import: Script = preload("res://scripts/utils/import.gd")

var language = 'fr'


########## CLICKER VARS
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

var bpc: float = 110:
	set(new_val):
		bpc = new_val
		#%LabelBpc.value = bpc
	get:
		return bpc

var clickers_owned: Dictionary = {}


########## BASE FUNCTIONS
func _ready():
	instantiate_buttons()


func _process(delta):
	increment_via_bps(delta)
	disable_expensive_clickers()



########## SIGNAL FUNCTIONS
func _on_build(clicker):
	%World.toggle_build_mode(true, clicker)


func _on_button_main_pressed() -> void:
	increment_via_bpc()


func _on_buy(clicker: Dictionary) -> void:
	increment_bp(clicker.value, clicker.type)
	increment_bananas(-clicker.price)
	addClickerToOwnedArray(clicker)



########## FUNCTIONS
func instantiate_buttons():
	var imported_clickers = import.import_json("res://json/clickers.json")

	for clicker in imported_clickers:
		var button = button_clicker.instantiate()
		
		button.clicker_name = clicker.name[language]
		button.clicker_slug = clicker.slug
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


func increment_bananas(amount: float) -> void:
	bananas += amount

	if amount > 0:
		bananas_total += amount
		pollution_total += (amount * 160) / 1000


func increment_via_bps(delta: float) -> void:
	increment_bananas(bps * delta)
	#TODO: ici faudra calc le bps en fonction du nb de clickers possédés dans clickers_owned ce sera bien mieux


func increment_via_bpc() -> void:
	increment_bananas(bpc)


func increment_bp(amount: float, type: String) -> void:
	self[type] += amount


func disable_expensive_clickers() -> void:
	var array = %ClickerSection.get_children() + %BuffSection.get_children()
	var button_array = array.map(func(b): return b.get_node("AspectRatioContainer").get_node("Button"))
	
	for i in range(button_array.size()):
		button_array[i].disabled = bananas < array[i].price

func addClickerToOwnedArray(clicker: Dictionary) -> void:
	if (clickers_owned.has(clicker.slug) == false):
		clickers_owned[clicker.slug] = 0

	clickers_owned[clicker.slug] += 1

#cette fonction sert à r pour l'instant
func deleteClickerFromOwnedArray(clicker: Dictionary) -> void:
	if (clickers_owned.has(clicker.slug) == true):
		clickers_owned[clicker.slug] -= 1

		if clickers_owned[clicker.slug] == 0:
			clickers_owned.erase(clicker.slug)