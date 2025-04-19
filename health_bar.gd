extends TextureProgressBar

@onready var current_hp: Label = get_node("/root/Main/HUD/CurrentHp")
@onready var max_hp: Label = get_node("/root/Main/HUD/MaxHp")
	
func _process(delta: float) -> void:
	var current = int(current_hp.text)
	var max = int(max_hp.text)
	max_value = max
	value = current
