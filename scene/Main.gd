extends Node

export (PackedScene) var Mob
var score

func _ready() -> void:
	randomize()
	new_game()
func new_game() -> void:
	score = 0
	$StartTimer.start()

func _on_StartTimer_timeout() -> void:
	$ScoreTimer.start()


func _on_ScoreTimer_timeout() -> void:
	score += 1


func _on_MobTimer_timeout() -> void:
	pass # Replace with function body.
	$MobPath/PathFollow2D.offset = randi()
	var mob = Mob.instance() as Mob
	add_child(mob)
#	var direction = $MobPath/PathFollow2D.rotation + PI / 2
#	mob.position = $MobPath/PathFollow2D.position
#	mob.rotation = direction
#
#	mob.liner_volecity
