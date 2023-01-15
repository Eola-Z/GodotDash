extends KinematicBody2D


var gravity_multiplier = 77
var gravity_vector = Vector2(0, gravity_multiplier)
var jump_height = 1150
var up = Vector2(0, -1)
var motion = Vector2()
var speed_multiplier = 1

# only the sprite rotates, the hitbox does not change
onready var sprite = $Sprite
var rotate_modifier = 0
var is_rotating = false

# variables for orb jumps
var can_yellow_jump = false
var can_purple_jump = false
var can_blue_jump = false
var can_red_jump = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if (self.position.x < 192) or (self.position.x > 256):
		self.die()
	self.position.x = 224
	
	gravity_vector = Vector2.DOWN * gravity_multiplier
	motion += gravity_vector
	
	if abs(motion.y) > 0.2:
		rotate_modifier = 0.115
	sprite.rotation += rotate_modifier
	
	# edge cases POGGGG
	if is_on_floor() or is_on_ceiling():
		sprite.rotation = round(self.rotation * 2 / PI) * (PI / 2)
		rotate_modifier = 0
	
	if gravity_multiplier > 0:
		# orb jumps
		if Input.is_action_just_pressed("ui_up"):
			if can_red_jump:
				motion.y = -1450
				can_red_jump = false
			if can_yellow_jump:
				motion.y = -1150
				can_yellow_jump = false
			if can_purple_jump:
				motion.y = -800
				can_purple_jump = false
		# jumping
		if(Input.is_action_pressed("ui_up") and is_on_floor() and !is_rotating):
			motion.y -= jump_height
	else:
		if is_on_ceiling():
			rotate_modifier = 0
			motion.y = 0
		if Input.is_action_just_pressed("ui_up"):
			if can_red_jump:
				motion.y = 1450
				can_red_jump = false
			if can_yellow_jump:
				motion.y = 1150
				can_yellow_jump = false
			if can_purple_jump:
				motion.y = 800
				can_purple_jump = false
		# jumping
		if(Input.is_action_pressed("ui_up") and is_on_ceiling() and !is_rotating):
			motion.y += jump_height
			
	# blue orb jumps
	if Input.is_action_pressed("ui_up") and can_blue_jump:
		gravity_multiplier *= -1
		motion.y *= -0.4
		can_blue_jump = false
	motion = move_and_slide(motion, up, false, 4, PI/4, false)

func die():
	self.queue_free()

# collision with other objects
func _on_Layout_body_entered(body):
	if body.name == "Player":
		body.die()

func _on_YellowPad_body_entered(body):
	if body.name == "Player":
		if gravity_multiplier < 0:
			motion.y = 1750
		else:
			motion.y = -1750

func _on_PurplePad_body_entered(body):
	if body.name == "Player":
		if gravity_multiplier < 0:
			motion.y = 1300
		else:
			motion.y = -1300

func _on_BluePad_body_entered(body):
	if body.name == "Player":
		gravity_multiplier *= -1
		if gravity_multiplier < 0:
			motion.y = -400
		else:
			motion.y = 400

func _on_RedPad_body_entered(body):
	if body.name == "Player":
		if gravity_multiplier < 0:
			motion.y = 2000
		else:
			motion.y = -2000


func _on_YellowGrav_body_entered(body):
	if body.name == "Player":
		gravity_multiplier = -78
		motion.y *= 0.4

func _on_BlueGrav_body_entered(body):
	if body.name == "Player":
		gravity_multiplier = 78
		motion.y *= 0.4


func _on_YellowOrb_body_entered(body):
	if body.name == "Player":
		can_yellow_jump = true

func _on_YellowOrb_body_exited(body):
	if body.name == "Player":
		can_yellow_jump = false

func _on_PurpleOrb_body_entered(body):
	if body.name == "Player":
		can_purple_jump = true

func _on_PurpleOrb_body_exited(body):
	if body.name == "Player":
		can_purple_jump = false

func _on_BlueOrb_body_entered(body):
	if body.name == "Player":
		can_blue_jump = true

func _on_BlueOrb_body_exited(body):
	if body.name == "Player":
		can_blue_jump = false

func _on_RedOrb_body_entered(body):
	if body.name == "Player":
		can_red_jump = true

func _on_RedOrb_body_exited(body):
	if body.name == "Player":
		can_red_jump = false

