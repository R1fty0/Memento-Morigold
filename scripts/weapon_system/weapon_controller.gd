extends Node3D
class_name WeaponController

# NOTE:
# The node containing this script also serves as the 3d position where weapons are held. 

## Where weapons should be held by the player.
@onready var weapon_position: Node3D = $"../Head/Camera3D/WeaponPosition"
## The raycast used for weapon shooting. 
@onready var weapon_raycast: RayCast3D = $"../Head/Camera3D/WeaponRaycast"
@onready var round_reload_timer: Timer = $RoundReloadTimer
@onready var firing_cooldown_timer: Timer = $FiringCooldownTimer

## Store a list of all the weapons the player currently has equipped. 
var weapons: Array[Weapon] = []
## The weapon the player currently has equipped. 
var current_weapon: Weapon
## Whether the current weapon can fire or not.
var can_current_weapon_fire: bool = true
## Whether the current weapon is reloading or not.
var is_current_weapon_reloading: bool = false
## Whether the current weapon is undergoing the firing cooldown.
var is_current_weapon_cooling_down: bool = false

## Temp references to guns
@onready var revolver: Revolver = $Revolver
@onready var shotgun: Shotgun = $Shotgun
@onready var rifle: Rifle = $Rifle

func _ready() -> void:
	# Tell the game manager this script exists. 
	GameManager.weapon_controller = self
	# Connect the signal needed from the firing cooldown timer.
	firing_cooldown_timer.timeout.connect(renable_weapon_after_firing_cooldown)
	
	## TEMP
	add_weapon(revolver)
	add_weapon(shotgun)
	add_weapon(rifle)
	_equip_weapon(revolver)

## Add a new weapon to the player's inventory. 
func add_weapon(new_weapon: Weapon) -> void:
	weapons.append(new_weapon)
	
	## TEMP
	new_weapon.global_position = weapon_position.global_position 
	new_weapon.get_parent_node_3d().remove_child(new_weapon)
	weapon_position.add_child(new_weapon)
	new_weapon.unequip()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("equip_weapon_1"):
		# Check if the player has a weapon in this slot. 
		if weapons.size() >= 0:
			# Check if desired weapon is already equipped.
			if current_weapon != weapons[0]:
				# Equip the weapon. 
				_equip_weapon(weapons[0])
	elif event.is_action_pressed("equip_weapon_2"):
		# Check if the player has a weapon in this slot. 
		if weapons.size() >= 1:
			# Check if desired weapon is already equipped.
			if current_weapon != weapons[1]:
				# Equip the weapon. 
				_equip_weapon(weapons[1])
	elif event.is_action_pressed("equip_weapon_3"):
		# Check if the player has a weapon in this slot. 
		if weapons.size() >= 2:
			# Check if desired weapon is already equipped.
			if current_weapon != weapons[2]:
				# Equip the weapon. 
				_equip_weapon(weapons[2])
	else:
		# Weapon shooting. 
		if event.is_action_pressed("shoot") and !is_current_weapon_reloading and !is_current_weapon_cooling_down:
			_shoot_weapon(current_weapon)
		# Weapon reloading. 
		elif event.is_action_pressed("reload") and !current_weapon.is_fully_loaded() and !is_current_weapon_reloading:
			_reload_weapon(current_weapon)
			current_weapon.reload()

func _equip_weapon(weapon: Weapon):
	# Deequip the current weapon if there is one equipped. 
	if current_weapon:
		current_weapon.unequip()
	weapon.equip()
	current_weapon = weapon

func _shoot_weapon(weapon: Weapon):
		# Prevent the weapon from firing if there is no ammo in the magazine. 
	if current_weapon.weapon_resource.ammo_in_magazine <= 0:
		can_current_weapon_fire = false
	else:
		can_current_weapon_fire = true	
	# Fire the weapon. 
	if can_current_weapon_fire:
		current_weapon.weapon_resource.ammo_in_magazine -= 1
		var hit_col = weapon_raycast.get_collider()
		if hit_col:
			# Damage the thing we hit if we can. 
			if hit_col is HurtboxComponent:
				hit_col.health_component.take_damage(weapon.weapon_resource.damage)
		# Trigger firing cooldown
		firing_cooldown_timer.wait_time = current_weapon.weapon_resource.firing_cooldown
		is_current_weapon_cooling_down = true
		firing_cooldown_timer.start()
	
func _reload_weapon(weapon: Weapon):
	round_reload_timer.wait_time = weapon.weapon_resource.round_reload_time
	is_current_weapon_reloading = true
	round_reload_timer.start()
	await round_reload_timer.timeout
	is_current_weapon_reloading = false
	current_weapon.weapon_resource.ammo_in_magazine += 1
	
func renable_weapon_after_firing_cooldown(): 
	is_current_weapon_cooling_down = false
