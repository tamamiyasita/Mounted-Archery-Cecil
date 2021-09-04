extends Node2D

onready var anime = $AnimationPlayer
onready var bow :Sprite = $Cecil/Bow
onready var arrow_hand :Sprite = $Cecil/Arrow_H
onready var arrow_hand_base_position = arrow_hand.global_position

var Arrow = preload('res://scene/Arrow.tscn')
var arrow = null

const base_speed = 40
const max_speed = 800

export var arrow_speed = base_speed
export var gravity = 200

var charge_time = false
var ready_arrow = false

func _unhandled_input(event: InputEvent) -> void:
	if is_instance_valid(arrow) and ready_arrow:
		if event.is_action_pressed('shot'):
			anime.play('default')
			charge_time = true
			
		elif event.is_action_released('shot'):
			arrow.global_transform = bow.global_transform
			arrow.velocity = arrow.transform.x * arrow_speed
			arrow.gravity = gravity
	#		yield(get_tree().create_timer(1.0), "timeout")
			shoot(arrow)
			charge_time = false
			ready_arrow = false




func shoot(b) -> void:
	b.fly()

func _physics_process(delta: float) -> void:
	if !is_instance_valid(arrow):
		anime.play('Draw_a_Bow')
		yield(anime, "animation_finished" )
		ready_arrow = true
		arrow = Arrow.instance()
		get_parent().add_child(arrow)
		arrow._ready()

	bow.global_rotation = get_local_mouse_position().angle()
	arrow_hand.global_rotation = get_local_mouse_position().angle()

	if is_instance_valid(arrow):
		arrow.global_rotation = get_local_mouse_position().angle()
		arrow_hand.global_rotation = get_local_mouse_position().angle()
		
		if charge_time:
			arrow_speed += 5
			if max_speed < arrow_speed:
				arrow_speed = max_speed
			else:
				arrow_hand.global_position.x -= 0.07
				arrow.global_position = arrow_hand.global_position
		else:
			arrow_speed = base_speed
			arrow_hand.global_position = arrow_hand_base_position
