extends State
class_name MeleeSkeletonChase


## NPC component controlling navigation
@export var npc: NPC
## The animation player attached to the skeleton's mesh. 
@export var skele_anim_player: AnimationPlayer
## Resource contain melee skeleton stats. 
@export var resource: MeleeSkeletonResource

## Reference to the player. 
var player: PlayerController

func enter_state():
	player = get_tree().get_first_node_in_group("player")

func state_physics_process(delta: float):
	# Play the running/chasing animation if the skeleton is moving. 
	if npc.velocity.length() > 0.0:
		skele_anim_player.play("Chase")
	# Play the idle animation if the skeleton is idle for some reason. 
	else:
		skele_anim_player.play("Idle")
	# Rotate the skeleton so that it is looking at the player. 
	var direction = player.global_transform.origin - npc.global_transform.origin
	if direction.length() > 0.001:
		var target_rotation = atan2(direction.x, direction.z)
		var current_rotation = npc.rotation.y
		npc.rotation.y = lerp_angle(current_rotation, target_rotation, resource.rotation_speed * delta)
	var distance = player.global_position - npc.global_position
	# Move towards the player if they are too far away to attack
	if distance.length() > resource.attack_range:
		npc.move_to_point(player.global_position, resource.speed)
	else:
		# Switch to the attack state if the player is in range
		transitioned.emit(self, "Attack")
		
