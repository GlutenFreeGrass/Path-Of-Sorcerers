class_name Item_Action extends Item

@export var healing_amount := 2.5

func use(player: Player) -> void:
	player.health += healing_amount
