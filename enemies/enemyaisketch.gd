extends CharacterBody2D

enum {
	FLOCK,
	ATTACK,
	RETREAT
}

var state = FLOCK

@export var cohesion: float
@export var alignment: float
@export var separation: float
@export var follow: float


func update(positions: Array, velocities: Array, player: Player):
	match state:
		FLOCK:
			flock(positions, velocities, player.position)
		ATTACK:
			attack()
		RETREAT:
			retreat()


func flock(positions: Array, velocities: Array, target: Vector2):
	var cohesion_vec: Vector2 = positions.reduce(func(acc, vec): return acc + vec.normalized()) / positions.size() - position
	var alignment_vec: Vector2 = velocities.reduce(func(acc, vec): return acc + vec.normalized()) / velocities.size() - position
	
	var separation_vec: Vector2 = Vector2.ZERO

	for pos in positions:
		if pos == position:
			continue
		
		var opposite_vec: Vector2 = position - pos

		if opposite_vec.length() < separation:
			separation_vec += opposite_vec.normalized() * (separation - opposite_vec.length())
	
	var target_vec = (target - position).normalized()

	position += ((cohesion_vec * cohesion + alignment_vec * alignment) + target_vec * follow) / 2 + separation_vec


func attack():
	pass


func retreat():
	pass
