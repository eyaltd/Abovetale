extends CharacterBody2D

@export var speed = 500
@onready var start_marker = get_node("/root/Main/PlayerStartPosition")
@onready var box_area = get_node("/root/Main/BoxArea")
@onready var current_health = 20
var max_heath = 20
var can_take_damage = false

func _ready() -> void:
	await get_tree().process_frame
	start_marker.position = box_area.box_pos + box_area.box_size / 2
	position = start_marker.position
	
	await get_tree().create_timer(0.5).timeout
	can_take_damage = true

func _process(delta: float) -> void:
	inputs(delta)
	position_limits()
	
func inputs(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		position += velocity * delta
		
func position_limits():
	position.x = clamp(position.x, box_area.box_pos.x + 13.0, box_area.box_pos.x + box_area.box_width - 13.0)
	position.y = clamp(position.y, box_area.box_pos.y + 13.0, box_area.box_pos.y + box_area.box_height - 13.0)
	start_marker.position = position
	
func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if can_take_damage:	
		var current_health_hud = get_node("/root/Main/HUD/CurrentHp")
		current_health -= 1
		current_health_hud.text = str(current_health)
		if current_health <= 0:
			get_node("/root/Main").game_over()
