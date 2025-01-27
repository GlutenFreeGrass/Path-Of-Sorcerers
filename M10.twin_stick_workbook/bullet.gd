extends Area2D

@export var speed = 400
#@export_range(0.0, 360.0, 1.0, "radians_as_degrees") var random_angle := PI / 12.0
#@export_range(100.0, 2000.0, 1.0) var max_range := 500.0
#@export_range(100.0, 3000.0, 1.0) var max_bullet_speed := 1500.0

var max_range := 500.0
var traveled_distance = 0.0
var damage = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(func(body:Node)-> void:
		if body is Mob:
			body.health -= damage
	)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var distances = speed * delta
	var rotated = Vector2.RIGHT.rotated(rotation) * distances
	position += rotated * speed * delta

	traveled_distance += distances
	if traveled_distance > max_range:
		delete()
	
	
func delete():
	queue_free()


func _on_body_exited(body: Node2D) -> void:
	delete()
