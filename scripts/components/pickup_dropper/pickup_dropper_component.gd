extends Node
class_name PickupDropper

# NOTE: 
# This script assumes the parent of the health component is a 3D node.

const BLOOD_COIN: PackedScene = preload("res://scenes/pickups/blood_coin/blood_coin.tscn")
const HEALTH_PICKUP: PackedScene = preload("res://scenes/pickups/health_pickup/health_pickup.tscn")

## Health component to connect death signal to
@export var health_component: HealthComponent

@export_category("Pickups")
## How many pickups should be dropped on death. 
@export var drop_blood_coins: bool = false
@export var drop_health_pickups: bool = false 
@export var drop_amount: int = 0

func _ready() -> void:
	health_component.died.connect(_drop_pickups)

func _drop_pickups() -> void:
	# Spawn pickups.
	var pickups_dropped: int = 0
	while pickups_dropped < drop_amount:
		if drop_blood_coins:
			var new_coin = BLOOD_COIN.instantiate()
			GameManager.add_child(new_coin)
			new_coin.global_position = health_component.get_parent().global_position
		else:
			var new_heal = HEALTH_PICKUP.instantiate()
			GameManager.add_child(new_heal)
			new_heal.global_position = health_component.get_parent().global_position
		pickups_dropped += 1
