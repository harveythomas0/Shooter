class_name Wave
extends Node2D


signal wave_over

@onready var spawn_timer: Timer = $SpawnTimer

var enemy_number: int
var enemy_to_spawn_prob: Dictionary
var spawn_time: float
var spawn_distance: float

var player: Player

var enemy_to_cumulative_spawn_prob: Dictionary = {}

var enemies_spawned: int = 0


func init(_enemy_number: int, _enemy_to_spawn_prob: Dictionary, _spawn_time: float, _spawn_distance: float, _player: Player):
	enemy_number = _enemy_number
	enemy_to_spawn_prob = _enemy_to_spawn_prob
	spawn_time = _spawn_time
	spawn_distance = _spawn_distance
	player = _player
	
	calculate_cumulative_prob()


func _on_spawn_timer_timeout():
	if enemies_spawned < enemy_number:
		spawn_enemy()
		enemies_spawned += 1
	
	if enemies_spawned == enemy_number:
		emit_signal("wave_over")

	spawn_timer.start(spawn_time)


func spawn_enemy() -> void:
	var spawn_angle: float = randf_range(0, 2*PI)
	var spawn_pos: Vector2 = Vector2(cos(spawn_angle), sin(spawn_angle)) * spawn_distance
	
	var new_enemy: Enemy = decide_enemy()
	
	add_child(new_enemy)
	
	new_enemy.global_position = spawn_pos + player.position


func decide_enemy() -> Enemy:
	var random_num: float = randf()
	
	for enemy: PackedScene in enemy_to_cumulative_spawn_prob.keys():
		if random_num <= enemy_to_cumulative_spawn_prob[enemy]:
			var new_enemy: Enemy = enemy.instantiate()
			new_enemy.init(player)
			return new_enemy
	
	return null


func calculate_cumulative_prob():
	var count: float = 0
	
	for enemy: PackedScene in enemy_to_spawn_prob.keys():
		count += enemy_to_spawn_prob[enemy]
		enemy_to_cumulative_spawn_prob[enemy] = count
