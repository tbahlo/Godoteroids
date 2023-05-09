extends Node2D

@export var initial_speed = 400
var direction_vector = Vector2(0, 0)
var velocity_vector = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity_vector * delta
	rotation = direction_vector.angle() + deg_to_rad(90)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
