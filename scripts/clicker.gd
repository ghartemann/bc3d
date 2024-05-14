extends Node


var bananas: float = 0:
	set(new_val):
		bananas = new_val
		#%LabelBananas.value = bananas
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
		%LabelBps.value = bps
	get:
		return bps

var bpc: float = 1:
	set(new_val):
		bpc = new_val
		%LabelBpc.value = bpc
	get:
		return bpc

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


################### Custom functions
func increment_bananas(amount: float) -> void:
	bananas += amount

	if amount > 0:
		bananas_total += amount
		pollution_total += (amount * 160) / 1000

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
		b.get_node("Button").disabled = bananas < b.price

func _on_buy(type: String, value: float, price: float) -> void:
	increment_bp(value, type)
	increment_bananas(-price)
