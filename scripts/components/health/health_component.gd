extends Node
class_name HealthComponent

## NOTE:
## This component must be the child of whatever object you want dead when its health runs out.

signal died 
signal took_damage
signal healed

@export var max_health: float = 100
var current_health: float = 100

func _ready() -> void:
	current_health = max_health
	
func take_damage(amount: float):
	if amount >= current_health: 
		_die()
	else:
		current_health -= amount
		took_damage.emit()

func is_full_health() -> bool:
	if current_health >= max_health:
		return true
	else:
		return false

func _die():
	died.emit()
	get_parent().queue_free()

func heal(amount: float):
	if current_health < max_health:
		current_health += amount
		healed.emit()
