extends Resource
class_name PlayerResource


@export_category("Movement")
## Normal speed.
@export var move_speed : float = 7.0
## Speed of jump.
@export var jump_velocity : float = 4.5
@export var dash_velocity: float = 9.0

@export_category("Camera")
@export var camera_sens : float = 0.002
## Camera headbobbing. 
@export var bob_freq: float = 2.0
@export var bob_amp: float = 0.08
@export var bob_time: float = 0.02

