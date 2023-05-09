extends Node2D

@export var chargeroid_tier = 0
@export var charge = 100.0

var chargeroidTemplate = preload("res://scenes/chargeroid.tscn")
var velocity_vector = Vector2(0, 0)
var turn_rate : float
var is_alive : bool

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	turn_rate = randf_range(-45, 45)
	is_alive = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + velocity_vector * delta
	rotation += deg_to_rad(turn_rate * delta)

func _on_chargeroid_body_area_entered(area):
	if "rojectile" in area.to_string():
		hit.emit()
		is_alive = false
