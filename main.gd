extends Node

@export var death_ball = preload("res://death_ball.tscn")
var first_death_ball = death_ball.instantiate()
var second_death_ball = death_ball.instantiate()
@onready var ShowTimeLeft: Label = get_node("/root/Main/ShowTimeLeft")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	_on_time_between_scenes_timeout()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	show_timer()
	
func show_timer():
	if $Level1.time_left == 0:
		$ShowTimeLeft.hide()
	else:
		$ShowTimeLeft.show()
		$ShowTimeLeft.text = str(int($Level1.time_left))

func hide_hud():
	get_node("/root/Main/HUD/Name").hide()
	get_node("/root/Main/HUD/Level").hide()
	get_node("/root/Main/HUD/HP").hide()
	get_node("/root/Main/HUD/CurrentHp").hide()
	get_node("/root/Main/HUD/Slash").hide()
	get_node("/root/Main/HUD/MaxHp").hide()
	get_node("/root/Main/HUD/HealthBar").hide()
	get_node("/root/Main/HUD/Fight").hide()
	get_node("/root/Main/HUD/Act").hide()
	get_node("/root/Main/HUD/Item").hide()
	get_node("/root/Main/HUD/Mercy").hide()
	
func show_hud():
	get_node("/root/Main/HUD/Name").show()
	get_node("/root/Main/HUD/Level").show()
	get_node("/root/Main/HUD/HP").show()
	get_node("/root/Main/HUD/CurrentHp").show()
	get_node("/root/Main/HUD/Slash").show()
	get_node("/root/Main/HUD/MaxHp").show()
	get_node("/root/Main/HUD/HealthBar").show()
	get_node("/root/Main/HUD/Fight").show()
	get_node("/root/Main/HUD/Act").show()
	get_node("/root/Main/HUD/Item").show()
	get_node("/root/Main/HUD/Mercy").show()

func game_over():
	$Player/CollisionPolygon2D.set_deferred("disabled", true)
	$Player/Area2D/CollisionPolygon2D.set_deferred("disabled", true)
	$Player.hide()
	$BoxArea.hide()
	$FirstBallTimer.stop()
	$SecondBallTimer.stop()
	$Level1.stop()
	remove_child(first_death_ball)
	remove_child(second_death_ball)
	get_node("/root/Main/HUD/GameOver").show()
	get_node("/root/Main/Restart").show()
	hide_hud()
	
	
func _on_time_between_scenes_timeout() -> void:
	await $FirstBallTimer.timeout
	add_child(first_death_ball)
	await $SecondBallTimer.timeout
	add_child(second_death_ball)
	await $Level1.timeout
	remove_child(first_death_ball)
	remove_child(second_death_ball)

func new_game():
	show_hud()
	$Player.show()
	$Player.can_take_damage = false
	$Player.current_health = 20
	$BoxArea.show()
	var current_health_hud = get_node("/root/Main/HUD/CurrentHp")
	current_health_hud.text = "20"
	$Player.position = $BoxArea.box_pos + $BoxArea.box_size / 2
	$Player/CollisionPolygon2D.set_deferred("disabled", false)
	$Player/Area2D/CollisionPolygon2D.set_deferred("disabled", false)
	$Level1.start()
	$FirstBallTimer.start()
	$SecondBallTimer.start()
	get_node("/root/Main/HUD/GameOver").hide()
	get_node("/root/Main/Restart").hide()
	ShowTimeLeft.text = "20"
	first_death_ball.position = $DeathballStartPosition.position
	await get_tree().create_timer(0.5).timeout
	$Player.can_take_damage = true

func _on_restart_pressed() -> void:
	new_game()
	
