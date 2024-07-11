class_name EnemyManager
extends Node2D


@onready var player: Player = $"../Player"

@onready var fists_enemy: PackedScene = preload("res://enemies/fists_enemies/fists_enemy.tscn")
@onready var quick_fists_enemy: PackedScene = preload("res://enemies/fists_enemies/quick_fists_enemy.tscn")
@onready var slow_fists_enemy: PackedScene = preload("res://enemies/fists_enemies/slow_fists_enemy.tscn")

@onready var wave_scene: PackedScene = preload("res://enemies/wave/wave.tscn")
@onready var wave: Wave


func _ready():
	var new_wave: Wave = wave_scene.instantiate()
	new_wave.init(
		500,
		{
			fists_enemy: 0.5,
			quick_fists_enemy: 0.3,
			slow_fists_enemy: 0.2
		},
		1.5,
		1500,
		player
	)
	change_wave(new_wave)


func change_wave(new_wave: Wave):
	if wave != null:
		wave.queue_free()
	wave = new_wave
	add_child(wave)
