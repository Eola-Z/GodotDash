extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player_speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(delta):
	self.translate(Vector2(-20 * player_speed, 0))





func _on_HalfSpeed_body_entered(body):
	if body.name == "Player":
		player_speed = 0.8

func _on_NormalSpeed_body_entered(body):
	if body.name == "Player":
		player_speed = 1

func _on_DoubleSpeed_body_entered(body):
	if body.name == "Player":
		player_speed = 1.2

func _on_TripleSpeed_body_entered(body):
	if body.name == "Player":
		player_speed = 1.5

func _on_QuadSpeed_body_entered(body):
	if body.name == "Player":
		player_speed = 2



func _on_Player_player_death():
	player_speed = 0
