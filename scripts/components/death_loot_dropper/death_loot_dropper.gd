extends Node
class_name DeathLootDropper

# NOTE: 
# This script assumes the parent of the health component is a 3D node.

const BLOOD_COIN: PackedScene = preload("res://scenes/pickups/blood_coin/blood_coin.tscn")
const HEALTH_PICKUP: PackedScene = preload("res://scenes/pickups/health_pickup/health_pickup.tscn")

## The enemy's death that triggers this script. 
@export var enemy: CharacterBody3D

@export_category("Pickups")
## How many pickups should be dropped on death. 
@export var drop_blood_coins: bool = false
@export var drop_health_pickups: bool = false 
@export var drop_amount: int = 0


## Triggered by other scripts.
func drop_pickups() -> void:
	# Spawn pickups.
	var pickups_dropped: int = 0
	while pickups_dropped < drop_amount:
		if drop_blood_coins:
			var new_coin = BLOOD_COIN.instantiate()
			GameManager.add_child(new_coin)
			new_coin.global_position = enemy.global_position
		else:
			var new_heal = HEALTH_PICKUP.instantiate()
			GameManager.add_child(new_heal)
			new_heal.global_position = enemy.global_position
		pickups_dropped += 1
