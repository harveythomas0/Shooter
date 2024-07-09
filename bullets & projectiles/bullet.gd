class_name Bullet
extends Area2D


var speed: float
var damage: float
var kill_time: float

@onready var kill_timer: Timer = $KillTimer


func init(_position: Vector2, _rotation: float, _speed: float, _damage: float, _kill_time: float):
	position = _position
	rotation = _rotation
	speed = _speed
	damage = _damage
	kill_time = _kill_time


func _ready() -> void:
	kill_timer.start(kill_time)


func _physics_process(delta: float) -> void:
	position += Vector2(1, 0).rotated(rotation) * speed * delta


func _on_kill_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node) -> void:
	if body.has_method("handle_bullet_hit"):
		body.handle_bullet_hit(damage)
		queue_free()
