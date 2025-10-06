extends Node3D
class_name MeleeSkeleton

# NOTE:
# This script assumes there is a state named "Hit" in the state machine. 
# This script assumes there is a state named "Die" in the state machine. 

@export var health_component: HealthComponent
@export var state_machine: StateMachine

func _ready() -> void:
	health_component.took_damage.connect(_switch_to_hit_state)
	health_component.died.connect(_switch_to_died_state)
	
func _switch_to_hit_state() -> void:
	state_machine.change_state(state_machine.current_state, "Hit")

func _switch_to_died_state() -> void:
	state_machine.change_state(state_machine.current_state, "Die")
