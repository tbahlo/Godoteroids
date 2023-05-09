extends Node
var debug_msg : String
var fps_value : int
var uptime = 0
var projectileTemplate = preload("res://scenes/projectile.tscn")
var chargeroidTemplate = preload("res://scenes/chargeroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var start_amount = 3
	for i in range(start_amount):
		var chargeroid = chargeroidTemplate.instantiate()
		print("Added object: %s" % chargeroid.to_string())
		chargeroid.position = Vector2(randf_range(0, 1600), randf_range(0, 800))
		#chargeroid.velocity_vector = Vector2(randf_range(-25, 25), randf_range(-25, 25))
		add_child(chargeroid)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fps_value = 1/delta
	uptime += delta
	
	for child in get_children():
		if "argeroid" in child.to_string():
			if child.is_alive == false:
				if child.chargeroid_tier <= 2:
					var fragment = chargeroidTemplate.instantiate()
					fragment.position = child.position
					fragment.velocity_vector = child.velocity_vector
					fragment.chargeroid_tier = child.chargeroid_tier + 1
					var scale_factor = 1./(2**(fragment.chargeroid_tier))+0.25
					fragment.apply_scale(Vector2(scale_factor, scale_factor))
					add_child(fragment)
				child.queue_free()

func _on_debug_msg_timer_timeout():
	var prefix = "[%.3f] " % uptime
	debug_msg = prefix + "Amount of children = %d \n" % get_child_count()
	debug_msg += prefix +  "FPS = " + str(fps_value) + "\n"
	debug_msg += prefix +  "------------"
	print(debug_msg)


func _on_player_player_shoots():
	var projectile = projectileTemplate.instantiate()
	projectile.hide()
	projectile.direction_vector = $Player.direction_vector
	projectile.velocity_vector = $Player.velocity_vector + projectile.initial_speed * $Player.direction_vector
	projectile.position = $Player.position
	add_child(projectile)
	projectile.show()
