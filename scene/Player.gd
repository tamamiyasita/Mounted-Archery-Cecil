extends Node2D

onready var anime = $AnimationPlayer
onready var bow :Sprite = $Cecil/Bow
onready var arrow_hand :Sprite = $Cecil/Arrow_H
onready var arrow_hand_base_position = arrow_hand.global_position
onready var power_bar = $TextureProgress

var Arrow = preload('res://scene/Arrow.tscn')
var arrow = null

const base_speed = 40
const max_speed = 800

export var arrow_speed = base_speed
export var gravity = 200

var charge_time = false
var ready_arrow = false

func _ready() -> void:
	power_bar.max_value = max_speed

func _unhandled_input(event: InputEvent) -> void:
	if ready_arrow:
		if event.is_action_pressed('shot'):
			charge_time = true
			anime.play('default')
			
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
	if ready_arrow == false:
		ready_arrow = true
		power_bar.value = arrow_speed
		
		anime.play('Draw_a_Bow')
		yield(anime, "animation_finished" )
		arrow = Arrow.instance()
		get_parent().add_child(arrow)
		arrow._ready()

	bow.global_rotation = get_local_mouse_position().angle()
	arrow_hand.global_rotation = get_local_mouse_position().angle()

	if is_instance_valid(arrow):
		arrow.global_rotation = get_local_mouse_position().angle()
		arrow_hand.global_rotation = get_local_mouse_position().angle()
		
		if charge_time:
			power_bar.value = arrow_speed
			arrow_speed += 7
			if max_speed < arrow_speed:
				arrow_speed = max_speed
			else:
				arrow_hand.global_position.x -= 0.07
				arrow.global_position = arrow_hand.global_position
		else:
			arrow_speed = base_speed
			arrow_hand.global_position = arrow_hand_base_position














