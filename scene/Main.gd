extends Node

export (PackedScene) var Mob
export (PackedScene) var B_Mob
export (Resource) var ScoreV

onready var score_text:Label = $CanvasLayer/VBoxContainer/ScoreLabel
onready var time_text:Label = $CanvasLayer/VBoxContainer/TimeLabel
onready var max_combo_text:Label = $CanvasLayer/VBoxContainer/MaxcomboLabel
onready var back_color :TextureRect = $TextureRect2

onready var combo_text:RichTextLabel = $CanvasLayer/VBoxContainer2/ComboLabel
onready var bonus_time:RichTextLabel = $CanvasLayer/VBoxContainer2/BonusTime

onready var combo_timer:Timer = $ComboTimer
onready var big_star :Node = $BigStar

var time
var score
var combo := 0
var max_combo := 0
var bonus := 0

func _ready() -> void:
	randomize()
	new_game()
func new_game() -> void:
	time = 61
	score = 0
	combo = 0
	max_combo = 0
	combo_text.hide()
	bonus_time.hide()
	$StartTimer.start()


func _physics_process(delta: float) -> void:
	if time + bonus <= 0:
		ScoreV.score = score
		ScoreV.max_combo = max_combo
		get_tree().change_scene("res://scene/GameOver.tscn")
	


func _on_StartTimer_timeout() -> void:
	$ScoreTimer.start()


func score_update(value) -> void:
	var bonus = combo_count()
	score += (value*(combo*1.2))
	score_text.text = "SCORE : {0}".format([str(score)])
	
func combo_count() -> int:
	combo += 1
	if combo > max_combo:
		max_combo = combo 
		max_combo_text.text = "MAX COMBO : {0}".format([str(max_combo)])
		
	if combo > 7:
		bonus_time.show()
		bonus = int((combo - 4) /2)
#		time += bonus
		bonus_time.bbcode_text = "[rainbow freq=0.4 sat=0.5 val=1] Time bonus {0} seconds! [/rainbow]".format([bonus])
		
	if combo > 1:
		var time_out = 4.0
		combo_text.show()
		combo_text.bbcode_text = "[wave amp={0} freq=10] {1} COMBO!".format([str(int(combo*2)+50), str(combo)])
		combo_timer.start(time_out)
		
	return bonus

func _on_ScoreTimer_timeout() -> void:
	time -= 1
	time_text.text = "TIME : {0}".format([str(time)])


func _on_MobTimer_timeout() -> void:
	pass # Replace with function body.
	$MobPath/PathFollow2D.offset = randi()
	if time % 12 == 0:
		var mob = B_Mob.instance() as B_Mob
		if big_star.get_child_count() < 1:
			big_star.add_child(mob)
			mob.position = $MobPath/PathFollow2D.global_position	
			
	else:
		var mob = Mob.instance() as Mob
		add_child(mob)
		mob.position = $MobPath/PathFollow2D.global_position	


func _on_ComboTimer_timeout() -> void:
	time += bonus
	combo = 0
	bonus = 0
	combo_text.hide()
	bonus_time.hide()
