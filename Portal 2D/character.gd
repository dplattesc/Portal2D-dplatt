extends "res://object.gd"
const speed = 10
const jumpForce = -200
const friction = 0.95
var on_ground = true
func _ready():
	contact_monitor = true
	max_contacts_reported = 10
func _physics_process(delta):
	
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(0, 15)) #create ray query below character
	var collision = get_world_2d().direct_space_state.intersect_ray(query) #check world collision at ray query
	if get_colliding_bodies() and collision: #check for touching ground
		on_ground = true
	else:
		on_ground = false
	var motion = Vector2()
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")  #set x motion with keybinds
	print(linear_velocity)
	if motion.length_squared() > 0: 
		motion = motion.normalized() * speed
		apply_impulse(Vector2(motion.x, 0)) #set speed
	if motion.length_squared() == 0 and on_ground: 
		linear_velocity.x *= friction #slow down character on ground
	if on_ground and Input.is_action_just_pressed("ui_select"): #set y motion with jump
		apply_impulse(Vector2(0, jumpForce))
