extends Node2D

@export var box_width = 175
@export var box_height = 175

var box_pos : Vector2
var box_size : Vector2 

func _ready() -> void:
	box_pos = Vector2((get_window().size.x - box_width) / 2, (get_window().size.y - box_height) / 1.5)
	box_size = Vector2(box_width, box_height)

func _draw() -> void:
	draw_rect(Rect2(box_pos, box_size), Color.WHITE, false, 4.0)
