@tool
class_name Pickup extends Area2D

@export var item: Item = null: set = set_item
@onready var hitbox: CollisionShape2D = $Hitbox
@onready var sprite_2d: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_item(item)
	body_entered.connect(func(body: Node2D) -> void:
		if body is Player:
			item.use(body)
			set_deferred("monitoring", false)
			queue_free()
			)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_item(value: Item) -> void:
	item = value
	if sprite_2d != null:
		sprite_2d.texture = item.texture
	
