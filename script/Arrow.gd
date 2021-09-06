extends Area2D

# テスト用速度
var velocity = Vector2(0, 0)

func _ready() -> void:
	set_process(false)
	
func _process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = velocity.angle()
	
func fly():
	set_process(true)

	




func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()



