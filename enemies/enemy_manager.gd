class_name EnemyManager
extends Node2D


@onready var player: Player = $"../Player"

@onready var fists_enemy: PackedScene = preload("res://enemies/fists_enemies/fists_enemy.tscn")
@onready var quick_fists_enemy: PackedScene = preload("res://enemies/fists_enemies/quick_fists_enemy.tscn")
@onready var slow_fists_enemy: PackedScene = preload("res://enemies/fists_enemies/slow_fists_enemy.tscn")

@onready var wave_scene: PackedScene = preload("res://enemies/wave/wave.tscn")
@onready var wave: Wave = wave_scene.instantiate()


func _ready():
	add_child(wave)
	
	wave.init(
		10,
		{
			fists_enemy: 0.5,
			quick_fists_enemy: 0.35,
			slow_fists_enemy: 0.15
		},
		2,
		1500,
		player
	)
