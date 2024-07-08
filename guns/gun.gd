class_name Gun


var fire_rate: float
var bullet_damage: float
var bullet_number: int
var bullet_spread: float
var bullet_speed: float

var default_anim_name: String
var shoot_anim_name: String


func _init(_fire_rate: float, _bullet_damage: float, _bullet_number: int, _bullet_spread: float, _bullet_speed: float,
		_default_anim_name: String, _shoot_anim_name: String) -> void:
	fire_rate = _fire_rate
	bullet_damage = _bullet_damage
	bullet_number = _bullet_number
	bullet_spread = _bullet_spread
	bullet_speed = _bullet_speed
	default_anim_name = _default_anim_name
	shoot_anim_name = _shoot_anim_name


func shoot(position: Vector2, rotation: float, bullet: PackedScene, bullet_manager: Node2D, attack_cooldown: Timer,
		animated_sprite: AnimatedSprite2D) -> void:
	if not attack_cooldown.is_stopped():
		return

	for i in range(bullet_number):
		var new_bullet = bullet.instantiate()
		new_bullet.init(position, rotation, bullet_speed, bullet_damage)
		apply_spread(new_bullet)
		bullet_manager.add_child(new_bullet)
	
	attack_cooldown.start(1 / fire_rate)
	
	animated_sprite.play(shoot_anim_name)


func apply_spread(bullet: Bullet) -> void:
	bullet.rotation_degrees += randf_range(-bullet_spread, bullet_spread)


func reset_animation(animated_sprite: AnimatedSprite2D) -> void:
	if animated_sprite.animation == shoot_anim_name:
		animated_sprite.play(default_anim_name)
