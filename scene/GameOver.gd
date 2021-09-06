extends Control

onready var score:RichTextLabel = get_node("CenterContainer/VBoxContainer/CenterContainer/Score")
onready var max_combo:RichTextLabel = get_node("CenterContainer/VBoxContainer/CenterContainer2/MaxCombo")
onready var score_record:Label = get_node("NinePatchRect2/CenterContainer/VBoxContainer/CenterContainer/Label")
onready var combo_record:Label = get_node("NinePatchRect2/CenterContainer/VBoxContainer/CenterContainer2/Label2")

export (Resource) var ScoreV



func _on_Button_pressed() -> void:
	get_tree().change_scene("res://scene/Main.tscn")


func _ready() -> void:
	var cur_score = ScoreV.score
	var cur_combo = ScoreV.max_combo
	
	
	score.bbcode_text = "SCORE : {0}".format([cur_score])
	max_combo.bbcode_text ="MAX COMBO : {0}".format([cur_combo])
	if ScoreV.score_log < cur_score:
		ScoreV.score_log = cur_score
	if ScoreV.max_combo_log < cur_combo:
		ScoreV.max_combo_log = cur_combo
	score_record.text = "SCORE RECORD : {0}".format([ScoreV.score_log])
	combo_record.text = "COMBO RECORD: {0}".format([ScoreV.max_combo_log])


func _on_Quit_pressed() -> void:
	get_tree().quit()
