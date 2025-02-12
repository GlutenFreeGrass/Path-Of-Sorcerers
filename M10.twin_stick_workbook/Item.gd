class_name Item extends Resource

@export var name := ""
@export var texture : Texture2D
@export var sound_pickup: AudioStream = null

func use(player: Player) -> void:
	pass
