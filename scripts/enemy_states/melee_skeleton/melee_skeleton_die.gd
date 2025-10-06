extends State
class_name MeleeSkeletonDie

@export var npc: NPC
@export var anim_player: AnimationPlayer
@export var melee_skeleton_root: MeleeSkeleton
@export var death_loot_dropper: DeathLootDropper

func enter_state():
	# Bring the skeleton to a stop. 
	npc.velocity = Vector3.ZERO
	# Play death animation.
	anim_player.play("Death")
	death_loot_dropper.drop_pickups()
	await anim_player.animation_finished
	melee_skeleton_root.queue_free()
