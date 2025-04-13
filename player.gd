extends Area2D
signal hit

@export var speed = 500
var box_area: Node2D

func _ready() -> void:
	box_area = get_node("/root/Main/BoxArea")
	
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
	position.x = clamp(position.x, box_area.box_pos.x + 13, box_area.box_pos.x + box_area.box_width - 13)
	position.y = clamp(position.y, box_area.box_pos.y + 13, box_area.box_pos.y + box_area.box_height - 13)
	
func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
