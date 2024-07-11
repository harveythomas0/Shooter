class_name Enemy
extends CharacterBody2D


@export var speed: float
@export var max_health: float
@export var attack_damage: float

var cohesion: float = 1
var alignment: float = 0.2
var separation: float = 30
var follow: float = 2

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player

var health: float


func init(_player: Player):
	player = _player


func _ready():
	health = max_health


func update(positions: Array, velocities: Array) -> void:
	var cohesion_vec: Vector2 = positions.reduce(func(acc, vec): return acc + vec.normalized()) / positions.size() - position
	var alignment_vec: Vector2 = velocities.reduce(func(acc, vec): return acc + vec.normalized()) / velocities.size() - position
	
	cohesion_vec = cohesion_vec.normalized()
	alignment_vec = alignment_vec.normalized()
	
	var separation_vec: Vector2 = Vector2.ZERO

	for pos in positions:
		if pos == position:
			continue
		
		var opposite_vec: Vector2 = position - pos

		if opposite_vec.length() < separation:
			separation_vec += opposite_vec.normalized() * (separation - opposite_vec.length())
	
	var target_vec = (player.position - position).normalized()

	velocity = ((cohesion_vec * cohesion + alignment_vec * alignment) + target_vec * follow) / 2 + separation_vec
	
	velocity = velocity.normalized() * speed
	
	print(velocity.normalized() - (player.position - position).normalized())
	
	move_and_slide()
	
	look_at(player.position)


func handle_bullet_hit(damage: float) -> void:
	animated_sprite.play("hit")
	
	health -= damage
	if health <= 0:
		queue_free()


func _on_animation_finished() -> void:
	if animated_sprite.animation == "hit":
		animated_sprite.play("default")
