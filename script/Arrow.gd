extends Area2D

# テスト用速度
var velocity = Vector2(350, 0)


func _process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = velocity.angle()
	


func _on_Arrow_body_entered(body: Node) -> void:
	queue_free()
