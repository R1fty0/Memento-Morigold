extends State
class_name MeleeSkeletonChase

## How far the skeleton can melee attack. 
@export var attack_range: float = 3.0
## NPC component controlling navigation
@export var npc: NPC
## How fast the skeleton moves.
@export var speed: float = 3.0

## Reference to the player. 
var player: PlayerController

func enter_state():
	player = get_tree().get_first_node_in_group("player")

func state_physics_process(_delta: float):
	# Check how far the player is from the enemy
	var distance = player.global_position - npc.global_position
	# Move towards the player if they are too far away to attack
	if distance.length() > attack_range:
		print("Moving towards player.")
		npc.move_to_point(player.global_position, speed)
	else:
		# Switch to the attack state if the player is in range
		transitioned.emit(self, "Attack")
		print("Switching to attacking player.")
		
