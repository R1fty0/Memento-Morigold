extends CharacterBody3D
class_name NPC

# Video (7:51): https://www.youtube.com/watch?v=2W4JP48oZ8U

@export var agent: NavigationAgent3D 
var move_speed: float = 2.0

func move_to_point(point_position: Vector3, speed: float):
	agent.target_position = point_position
	move_speed = speed
	
func _physics_process(delta: float) -> void:
	var destination = agent.get_next_path_position()
	var direction = (destination - global_position).normalized()
	velocity = move_speed * direction
	move_and_slide()
