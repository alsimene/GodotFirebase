extends Button




func _on_pressed():
	Firebase.Auth.logout()
	get_tree().quit()
	pass # Replace with function body.
