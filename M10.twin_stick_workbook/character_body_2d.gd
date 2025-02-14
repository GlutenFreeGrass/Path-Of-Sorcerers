class_name Mob extends CharacterBody2D

@export var damage := 1
@export var max_speed := 500.0
@export var acceleration := 700.0
@export var health = 5: set = set_health
@onready var hit_box: Area2D = $HitBox
@onready var timer: Timer = $Timer


var players: Player = null
@onready var detector: Area2D = $detector



func _ready() -> void:
	detector.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			players = body
			print("AAAAAAAAAAAAAAAAA")
	)
	detector.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			timer.stop()
	)

	hit_box.body_entered.connect(func (body:Node) -> void: 
		if body is Player:
			body.health -= damage
			timer.start()
	)
	timer.timeout.connect(func() -> void:
		players.health -= damage
		)
func _physics_process(delta: float) -> void:
	if players == null:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	else:
		var direction := global_position.direction_to(players.global_position)
		var distance := global_position.distance_to(players.global_position)
		var speed := max_speed if distance > 120.0 else max_speed * distance / 120.0
		var desired_velocity := direction * speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	move_and_slide()
	
func set_health(new_health: int) -> void:
	health = new_health
	if health <= 0:
		die()

func die() -> void:
	queue_free()
	
