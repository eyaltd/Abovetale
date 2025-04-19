extends CharacterBody2D
signal hit

@onready var start_marker = get_node("/root/Main/DeathballStartPosition")
@onready var box_area = get_node("/root/Main/BoxArea")
@onready var player_health = get_node("/root/Main/Player")

var my_velocity = Vector2(200, 200)
var direction: Vector2
func _ready() -> void:
	position = start_marker.position
	direction =  random_direction()
	
func _process(delta: float) -> void:
	$AnimatedSprite2D.rotate(5 * delta)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * my_velocity * delta)
	if collision:
		direction = direction.bounce(collision.get_normal())

func random_direction():
	var new_direction = Vector2()
	new_direction.x = [1, -1].pick_random()
	new_direction.y = [1, -1].pick_random()
	return new_direction.normalized()
