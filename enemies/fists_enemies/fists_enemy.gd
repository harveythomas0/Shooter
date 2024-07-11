class_name FistsEnemy
extends Enemy


@export var attack_speed: float

@onready var attack_cooldown: Timer = $AttackCooldown
@onready var fists: Area2D = $Fists


func _ready():
	super._ready()
	attack_cooldown.wait_time = 1 / attack_speed


func update(positions: Array, velocities: Array):
	super.update(positions, velocities)
	handle_attack()


func handle_attack():
	if player in fists.get_overlapping_bodies():
		if attack_cooldown.is_stopped():
			player.handle_enemy_attack(attack_damage)
			attack_cooldown.start()
