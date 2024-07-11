class_name Enemy
extends CharacterBody2D


@export var speed: float
@export var max_health: float
@export var attack_damage: float

var centering_factor: float = 0.05
var min_distance: float = 250
var avoid_factor: float = 0.05
var matching_factor: float = 0.05
var chasing_factor: float = 0.3

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player

var health: float


func init(_player: Player):
	player = _player


func _ready():
	health = max_health


func update(positions: Array, velocities: Array) -> void:
	move_towards_center(positions)
	avoid_others(positions)
	match_velocity(velocities)
	chase_player()

	velocity = velocity.normalized() * speed
	
	move_and_slide()
	
	look_at(player.position)


func move_towards_center(positions: Array):
	var center: Vector2 = Vector2.ZERO

	for pos in positions:
		center += pos
	
	center /= positions.size()

	velocity += center * centering_factor


func avoid_others(positions: Array):
	var move: Vector2 = Vector2.ZERO

	for pos in positions:
		if pos != position and (position - pos).length() < min_distance:
			move += position - pos
	
	velocity += move * avoid_factor


func match_velocity(velocities: Array):
	var average: Vector2 = Vector2.ZERO

	for vel in velocities:
		average += vel
	
	average /= velocities.size()

	velocity += (velocity - average) * matching_factor


func chase_player():
	velocity += (player.position - position) * chasing_factor


func handle_bullet_hit(damage: float) -> void:
	animated_sprite.play("hit")
	
	health -= damage
	if health <= 0:
		queue_free()


func _on_animation_finished() -> void:
	if animated_sprite.animation == "hit":
		animated_sprite.play("default")
