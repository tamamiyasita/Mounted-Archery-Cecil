extends Node2D

onready var bow :Sprite = $Cecil/Bow
onready var arrow_hand :Sprite = $Cecil/Arrow_H

var Arrow = preload('res://scene/Arrow.tscn')

const base_speed = 40
const max_speed = 800

export var arrow_speed = base_speed
export var gravity = 200

var charge_time = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('shot'):
		charge_time = true
	if event.is_action_released('shot'):
#		yield(get_tree().create_timer(1.0), "timeout")
		shoot()
		charge_time = false




func shoot() -> void:
	var b = Arrow.instance()
	get_parent().add_child(b)
#	b.global_position = global_position
	b.global_transform = bow.global_transform
	b.velocity = b.transform.x * arrow_speed
	b.gravity = gravity
#	b.rotation = bow.rotation

func _physics_process(delta: float) -> void:
	bow.global_rotation = get_local_mouse_position().angle()
	arrow_hand.global_rotation = get_local_mouse_position().angle()
	if charge_time:
		arrow_speed += 5
		if max_speed < arrow_speed:
			arrow_speed = max_speed
	else:
		arrow_speed = base_speed
