extends CharacterBody2D


var player: PackedScene = preload("res://player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := global_position.direction_to(get_globl)
	 
