extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body is Player:
		body.velocity.y = -600
		animated_sprite_2d.play("jump")
		
		
	else:
		animated_sprite_2d.play("default")
	pass # Replace with function body.
