extends State
class_name MeleeSkeletonHit

@export var npc: NPC
@export var anim_player: AnimationPlayer


func enter_state() -> void:
	# Bring the skeleton to a stop. 
	npc.velocity = Vector3.ZERO
	# Play hit animation.
	anim_player.play("Hit")
	await anim_player.animation_finished
	transitioned.emit(self, "Chase")
	
