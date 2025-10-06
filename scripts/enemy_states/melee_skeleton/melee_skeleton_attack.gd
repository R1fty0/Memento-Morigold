extends State
class_name MeleeSkeletonAttack


@export var damage: float = 20.0
@export var attack_recovery_time: float = 1.0

@onready var attack_recovery_timer: Timer = $AttackRecoveryTimer
var can_attack: bool = true

func _ready() -> void:
	attack_recovery_timer.wait_time = attack_recovery_time

func state_process(_delta: float):
	if can_attack:
		can_attack = false
		attack_recovery_timer.start()
	

func reset_attack() -> void:
	can_attack = true
