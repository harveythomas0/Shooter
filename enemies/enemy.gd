class_name Enemy
extends CharacterBody2D


@export var speed: float
@export var max_health: float
@export var attack_damage: float

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player

var health: float


func init(_player: Player):
	player = _player


func _ready():
	health = max_health


func _physics_process(_delta: float) -> void:
	var direction: Vector2 = (player.position - position).normalized()
	
	velocity = direction * speed
	
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
