extends Area2D
class_name Mob

export var min_speed = 150
export var max_speed = 250


var velocity = Vector2(100,0)

#func _on_VisibilityNotifier2D_screen_exited() -> void:
#	queue_free()
	
	
func _process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = velocity.angle()
	
