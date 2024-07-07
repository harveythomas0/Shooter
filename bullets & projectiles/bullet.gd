class_name Bullet
extends Area2D


var speed: float
var damage: float

@onready var kill_timer: Timer = $KillTimer


func init(_position: Vector2, _rotation: float, _speed: float, _damage: float):
	position = _position
	rotation = _rotation
	speed = _speed
	damage = _damage


func _ready() -> void:
	kill_timer.start()


func _physics_process(delta: float) -> void:
	position += Vector2(1, 0).rotated(rotation) * speed * delta


func _on_kill_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node) -> void:
	if body.has_method("handle_bullet_hit"):
		body.handle_bullet_hit(damage)
		queue_free()
