extends Node3D
class_name Weapon

# NOTE: 
# A template class for which all weapons derive from. 
# Magazines might not be filled if the ready function is overrided. 

## Contains weapon stat data. 
@export var weapon_resource: WeaponResource

func _ready() -> void:
	weapon_resource.ammo_in_magazine = weapon_resource.magazine_size

func equip() -> void:
	pass
	
func unequip() -> void:
	pass
	
func shoot() -> void: 
	pass
		
func reload() -> void:
	pass
	
func is_fully_loaded() -> bool:
	if weapon_resource.ammo_in_magazine < weapon_resource.magazine_size:
		return false
	else:
		return true
