extends Label

func _process(delta: float) -> void:
	text = "Ammo: " + str(GameManager.weapon_controller.current_weapon.weapon_resource.ammo_in_magazine) + "/" + str(GameManager.weapon_controller.current_weapon.weapon_resource.magazine_size)
