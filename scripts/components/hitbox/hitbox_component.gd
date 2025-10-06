extends Area3D
class_name HitboxComponent

## This value is updated the weapon script this hitbox is attached to. 
@export var damage: float = 0.0

func _ready() -> void:
	area_entered.connect(_check_object_hit)

func enable_hitbox() -> void:
	monitoring = true
	monitorable = true

func disable_hitbox() -> void: 
	monitoring = false
	monitorable = false
	
## Triggered when the hitbox hits something while enabled. 
func _check_object_hit(area: Area3D) -> void: 
	if area is HurtboxComponent:
		if area.health_component:
			area.health_component.take_damage(damage)
	
