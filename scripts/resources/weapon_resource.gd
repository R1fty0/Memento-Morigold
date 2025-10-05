extends Resource
class_name WeaponResource

@export_category("Damage")
## How much damage the weapon does per shot. 
@export var damage: float = 10.0 
@export_group("Falloff")
@export var has_falloff: bool = true
## How much damage is lost per metre of distance.
@export var falloff_rate: float = 0.1
## The lowest amount of damage the weapon can do due to damage falloff. 
@export var minimum_falloff_damage: float = 4.0

@export_category("Reloading")
## How long does it take to reload a single round into the gun. 
@export var round_reload_time: float = 0.2
## How long the gun has to wait before being able to fire again (intended to preventing the gun firing during
## the revolver's hammer, shotgun's pump and rifle's lever being pulled back). 
@export var firing_cooldown: float = 0.25

@export_category("Misc")
## How much knockback due to enemies recieve when being shot. 
@export var knockback_force: float = 0.1
## How big the weapon's magazine is. 
@export var magazine_size: int = 6

## How much ammo is currently in the weapon's magazine. 
var ammo_in_magazine: int = 6
