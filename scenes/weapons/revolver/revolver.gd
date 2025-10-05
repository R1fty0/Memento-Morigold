extends Weapon
class_name Revolver

@onready var mesh: MeshInstance3D = $Mesh

func equip() -> void:
	mesh.visible = true
	
func unequip() -> void:
	mesh.visible = false
	
func shoot() -> void: 
	pass
		
func reload() -> void:
	pass
