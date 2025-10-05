extends Area3D
class_name PlayerInventoryManager

@export var player_health_component: HealthComponent
@export var pickup_radius: float = 2.0 

@onready var pickup_collider: CollisionShape3D = $PickupCollider

## How many blood coins does the player have. 
var blood_coins: int = 0


func _ready() -> void:
	pickup_collider.shape.radius = pickup_radius
	area_entered.connect(pickup_item)

func pickup_item(area: Area3D) -> void:
	if area is BloodCoin:
		blood_coins += 1
		area.queue_free()
	elif area is HealthPickup:
		# Don't pick up the health pickup if the player is full health. 
		if GameManager.player_controller.health_component.is_full_health():
			pass
		else:
			GameManager.player_controller.health_component.heal(area.heal_amount)
			area.queue_free()
	
