extends Node2D


@export var spawn_distance: float
@export var max_enemies: int
@export var spawn_time: float

@onready var player: Player = $"../Player"
@onready var spawn_timer: Timer = $SpawnTimer

@onready var fists_enemy: PackedScene = preload("res://enemies/fists_enemies/fists_enemy.tscn")
@onready var quick_fists_enemy: PackedScene = preload("res://enemies/fists_enemies/quick_fists_enemy.tscn")
@onready var slow_fists_enemy: PackedScene = preload("res://enemies/fists_enemies/slow_fists_enemy.tscn")

# Must sum to 1
@onready var enemy_to_spawn_prob: Dictionary = {
	fists_enemy: 0.5,
	quick_fists_enemy: 0.35,
	slow_fists_enemy: 0.15
}

var enemy_to_cumulative_spawn_prob: Dictionary = {}


func _ready():
	calculate_cumulative_prob()


func _process(delta: float) -> void:
	if get_child_count() - 1 < max_enemies:
		if spawn_timer.is_stopped():
			spawn_enemy()
			spawn_timer.start(spawn_time)


func spawn_enemy() -> void:
	var spawn_angle: float = randf_range(0, 2*PI)
	var spawn_pos: Vector2 = Vector2(cos(spawn_angle), sin(spawn_angle)) * spawn_distance
	
	var new_enemy: Enemy = decide_enemy()
	
	add_child(new_enemy)
	
	new_enemy.global_position = spawn_pos + player.position


func decide_enemy() -> Enemy:
	var random_num: float = randf()
	
	for enemy: PackedScene in enemy_to_spawn_prob.keys():
		if random_num <= enemy_to_cumulative_spawn_prob[enemy]:
			return enemy.instantiate()
	
	return null


func calculate_cumulative_prob():
	var count: float = 0
	
	for enemy: PackedScene in enemy_to_spawn_prob.keys():
		count += enemy_to_spawn_prob[enemy]
		enemy_to_cumulative_spawn_prob[enemy] = count
