extends Area2D
signal hit

@export var speed = 500
@onready var start_marker = get_node("/root/Main/StartPosition")
@onready var box_area = get_node("/root/Main/BoxArea")

func _ready() -> void:
	await get_tree().process_frame
	var box_center = box_area.box_pos + box_area.box_size / 2
	start_marker.position = box_center
	position = box_center
	
func _process(delta: float) -> void:
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
		
	position.x = clamp(position.x, box_area.box_pos.x + 13.0, box_area.box_pos.x + box_area.box_width - 13.0)
	position.y = clamp(position.y, box_area.box_pos.y + 13.0, box_area.box_pos.y + box_area.box_height - 13.0)
	
	start_marker.position = position
func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
