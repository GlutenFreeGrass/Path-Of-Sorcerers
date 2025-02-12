@tool
class_name Pickup extends Area2D

@export var item: Item = null: set = set_item
@onready var hitbox: CollisionShape2D = %Hitbox
@onready var audio_stream_player_2d: AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var sprite_2d: Sprite2D = %Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_item(item)
	body_entered.connect(func(body: Node2D) -> void:
		if body is Player:
			item.use(body)
			animation_player.play("Disappear")
			audio_stream_player_2d.play()
			animation_player.animation_finished.connect(func(animation_name: String) -> void:
				queue_free()
				)
			)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_item(value: Item) -> void:
	item = value
	if sprite_2d != null:
		sprite_2d.texture = item.texture
	
	if audio_stream_player_2d != null:
		audio_stream_player_2d.stream = item.sound_pickup
	
