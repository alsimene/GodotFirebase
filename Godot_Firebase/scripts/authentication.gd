extends Node2D

@onready var email_line_edit = $VBoxContainer/EmailLineEdit
@onready var password_line_edit = $VBoxContainer/PasswordLineEdit
@onready var state_label = $VBoxContainer/StateLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	if Firebase.Auth.check_auth_file():
		state_label.text = "Logging in"
		get_tree().change_scene_to_file("res://scenes/World.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_login_button_pressed():
	var email = email_line_edit.text
	var password = password_line_edit.text
	Firebase.Auth.login_with_email_and_password(email, password)
	state_label.text = "Logging in"
	pass # Replace with function body.


func _on_signup_button_pressed():
	var email = email_line_edit.text
	var password = password_line_edit.text
	
	Firebase.Auth.signup_with_email_and_password(email, password)
	state_label.text = "Signing up"
	pass # Replace with function body.
	
func on_login_succeeded(auth):
	state_label.text = "Log in Success"
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://scenes/World.tscn")
	pass
	
func on_signup_succeeded(auth):
	
	state_label.text = "Sign up Success"
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://scenes/World.tscn")
	pass

func on_login_failed(error_code, message):
	state_label.text = "Login failed. Error: %s " %message
	pass

func on_signup_failed(error_code, message):

	state_label.text = "Sign up failed. Error: %s " %message
	pass
