extends Node2D


onready var player = $Player
onready var camera = $Camera2D
onready var song = $AudioStreamPlayer
onready var respawn_time = $Respawn
var alive = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if player.position.y < 640 and abs(player.position.y - camera.position.y) > 80 and alive:
		print(player.position.y)
		camera.set_position(Vector2(camera.position.x, player.position.y))
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Levels/Menu.tscn")



func _on_Player_player_death():
	alive = false
	song.stop()
	respawn_time.start()

func _on_Respawn_timeout():
	get_tree().reload_current_scene()

func _on_Finish_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Levels/Menu.tscn")
