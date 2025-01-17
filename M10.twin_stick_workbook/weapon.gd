extends Node2D
@export var bullet_scene: PackedScene = preload("res://bullet.tscn")
@export_range(0.0, 360.0, 1.0, "radians_as_degrees") var random_angle := PI / 12.0
@export_range(100.0, 2000.0, 1.0) var max_range := 500.0
@export_range(100.0, 3000.0, 1.0) var bullet_speed := 1500.0


func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Shoot"):
		shoot()
	
	
func shoot() -> void:
	var bullets: Node = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullets)
	bullets.global_position = global_position
	bullets.global_rotation = global_rotation
	bullets.max_range = max_range
	bullets.speed = bullet_speed
	bullets.rotation += randf_range(-random_angle / 1.0, random_angle / 1.0)
