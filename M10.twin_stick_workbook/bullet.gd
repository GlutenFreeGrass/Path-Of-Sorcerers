extends Area2D

@export var speed = 800

var max_range := 1000
var traveled_distance =0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var distances = speed * delta
	var rotated = Vector2.RIGHT.rotated(rotation) * distances
	position += rotated

	traveled_distance += distances
	if traveled_distance > max_range:
		delete()

func delete():
	queue_free()
