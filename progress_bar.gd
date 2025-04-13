extends TextureProgressBar

@onready var health_bar = $TextureProgressBar

var current_health = 20
var max_health = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.max_value = max_health
	max_health.value = current_health
