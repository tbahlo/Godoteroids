extends Node2D

@export var thrust = 100 # px/s
@export var turn_rate = 180 # deg/s
signal hit
signal player_shoots

var direction_vector = Vector2(0, -1)
var velocity_vector = Vector2(0, 10)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# handle inputs:
	if Input.is_action_pressed("thrust"):
		velocity_vector += direction_vector * thrust * delta
		$PlayerBody/ThrustSprite.visible = true
	else:
		$PlayerBody/ThrustSprite.visible = false

	if Input.is_action_pressed("turn_left"):
		direction_vector = direction_vector.rotated(deg_to_rad(-turn_rate*delta))
	if Input.is_action_pressed("turn_right"):
		direction_vector = direction_vector.rotated(deg_to_rad(turn_rate*delta))
	
	if Input.is_action_pressed("shoot"):
		shoot()
	

	position += velocity_vector * delta
	rotation = direction_vector.angle() + deg_to_rad(90)


func shoot():
	if $PlayerReloadTimer.time_left <= 0:
		player_shoots.emit()
		$PlayerReloadTimer.start()


func _on_player_body_area_entered(area):
	if "argeroid" in area.to_string():
		hit.emit()
		queue_free()
