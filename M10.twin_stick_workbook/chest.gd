@tool
class_name Chest extends Area2D

@export var possible_items: Array[Item] = []
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

var is_near_player := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(func (body: Node) -> void:
		is_near_player = true
		)
	body_exited.connect(func (body: Node) -> void:
		is_near_player = false
		)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if is_near_player and event.is_action_pressed("interact"):
		animation_player.play("Open")
		create_pickup()
		set_deferred("monitoring", false)
		get_viewport().set_input_as_handled()
		


func create_pickup() -> void:
	if possible_items == []:
		return

	var item: Item = possible_items.pick_random()
	var pickup: Pickup = preload("res://pickup.tscn").instantiate()
	pickup.item = item
	add_child(pickup)

	var random_angle := randf_range(0.0, 2.0 * PI)
	var random_direction := Vector2(0.5, 0.0).rotated(random_angle)
	var land_position := random_direction * randf_range(60.0, 120.0)

	const FLIGHT_TIME := 0.4
	const HALF_FLIGHT_TIME := FLIGHT_TIME / 2.0

	var tween := create_tween()
	tween.set_parallel()
	pickup.scale = Vector2(0.25, 0.25)
	tween.tween_property(pickup, "scale", Vector2(0.5, 0.5), HALF_FLIGHT_TIME)
	tween.tween_property(pickup, "position:x", land_position.x, FLIGHT_TIME)

	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	var jump_height := randf_range(10.0, 15.0)
	tween.tween_property(pickup, "position:y", land_position.y - jump_height, HALF_FLIGHT_TIME)
	tween.set_ease(Tween.EASE_IN)
