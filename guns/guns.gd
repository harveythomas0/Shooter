"""
Order for parameters:
	1. Fire Rate
	2. Bullet Damage
	3. Bullet Number
	4. Bullet Spread
	5. Bullet Speed
	6. Bullet Kill Time
	6. Default Animation Name
	7. Shoot Animation Name
	8. End of Gun
"""

class_name Guns


var pistol: Gun = Gun.new(5, 1, 1, 1, 500, 2, "pistol_default", "pistol_shoot", Vector2(48, 0))
var assault_rifle: Gun = Gun.new(10, 1, 1, 3, 500, 3, "ar_default", "ar_shoot", Vector2(69, 0))
var shotgun: Gun = Gun.new(2, 1, 4, 10, 500, 0.75, "shotgun_default", "shotgun_shoot", Vector2(72, 0))
