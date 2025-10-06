extends State
class_name MeleeSkeletonAttack


@export var resource: MeleeSkeletonResource
@export var anim_player: AnimationPlayer
@export var sword_hitbox: HitboxComponent
@export var npc: NPC
@export var attack_recovery_timer: Timer 

var can_attack: bool = true
var is_attacking: bool = false

## Reference to the player. 
var player: PlayerController

func enter_state():
	player = get_tree().get_first_node_in_group("player")
	sword_hitbox.disable_hitbox()

func _ready() -> void:
	attack_recovery_timer.wait_time = resource.time_between_attacks
	attack_recovery_timer.timeout.connect(reset_attack)
	sword_hitbox.damage = resource.damage

func state_process(_delta: float):
	var distance = player.global_position - npc.global_position
	# Attack if we are in range, not attacking, and not waiting on the attack recovery cooldown.
	if can_attack and !is_attacking and distance.length() <= resource.attack_range:
		npc.velocity = Vector3.ZERO
		sword_hitbox.enable_hitbox()
		anim_player.play("Attack")
		is_attacking = true
		await anim_player.animation_finished
		sword_hitbox.disable_hitbox()
		is_attacking = false
		attack_recovery_timer.start()
		can_attack = false
	# Run after the player if they leave attack range before we attack. 
	elif !is_attacking and distance.length() > resource.attack_range:
		transitioned.emit(self, "Chase")
	
func reset_attack() -> void:
	can_attack = true
	
func exit_state() -> void:
	# Turn off the sword hitbox in case the attack animation gets interrupted.
	sword_hitbox.disable_hitbox()
