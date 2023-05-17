extends Node
var debug_msg : String
var fps_value : int
var uptime = 0
var projectileTemplate = preload("res://scenes/projectile.tscn")
var chargeroidTemplate = preload("res://scenes/chargeroid.tscn")
var charged_actors = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var start_amount = 3
	for i in range(start_amount):
		var chargeroid = chargeroidTemplate.instantiate()
		print("Added object: %s" % chargeroid.to_string())
		chargeroid.position = Vector2(randf_range(0, 1600), randf_range(0, 800))
		#chargeroid.velocity_vector = Vector2(randf_range(-25, 25), randf_range(-25, 25))
		charged_actors.append(chargeroid)
		add_child(chargeroid)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fps_value = 1/delta
	uptime += delta
	
	#apply_charge_interaction()
	spawn_fragments()

func apply_charge_interaction():
	for i in range(len(charged_actors)):
		var first_body = charged_actors[i]
		for j in range(i+1, len(charged_actors)):
			var second_body = charged_actors[j]
			var distance_vector = first_body.position - second_body.position
			var distance = distance_vector.length()
			var velocity_change = first_body.charge * second_body.charge
			velocity_change /= distance**2
			first_body.velocity_vector += velocity_change * distance_vector.abs()
			second_body.velocity_vector -= velocity_change * distance_vector.abs()

func spawn_fragments():
	for actor in charged_actors:
		if actor.is_alive == false:
			if actor.chargeroid_tier <= 2:
				print(range(actor.amount_of_fragments))
				for i in range(actor.amount_of_fragments):
					var fragment = chargeroidTemplate.instantiate()
					fragment.position = actor.position
					#fragment.position += Vector2(randf_range(-75, 75), randf_range(-75, 75))
					fragment.velocity_vector = actor.velocity_vector
					fragment.velocity_vector += Vector2(randf_range(-75, 75), randf_range(-75, 75))
					
					fragment.chargeroid_tier = actor.chargeroid_tier + 1
					
					var scale_factor = 1./(2**(fragment.chargeroid_tier))+0.5
					fragment.apply_scale(Vector2(scale_factor, scale_factor))
					add_child(fragment)
					charged_actors.append(fragment)
			charged_actors.erase(actor)
			actor.queue_free()

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
