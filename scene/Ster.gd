extends Area2D
class_name Mob

export var min_speed = 150
export var max_speed = 250
export var Burst : PackedScene

onready var burst_range :CollisionShape2D = $Range/BurstRange
onready var anime :AnimationPlayer = $AnimationPlayer
onready var sprite :Sprite = $Sprite
onready var range_b : CollisionShape2D = $Range/BurstRange

var burst = null

var velocity = Vector2(100,0)

func _ready() -> void:
	range_b.disabled = true


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	
	
func _process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = velocity.angle()
	
func burst_on() ->void:
	if burst == null:
		get_tree().call_group("main", "score_update", 500)
		burst = Burst.instance() as Particles2D
		get_parent().add_child(burst)
		burst.position = position
		anime.play('burst')
		sprite.hide()


func _on_Ster_area_entered(area: Area2D) -> void:
	burst_on()




func _on_Range_area_entered(area: Area2D) -> void:
#	yield(get_tree(),'idle_frame')
	yield(get_tree().create_timer(0.8), "timeout")
	burst_on()
