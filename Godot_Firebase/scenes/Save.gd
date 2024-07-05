extends Button

var COLLECTION_ID = "player_position"
@onready var player = get_node("/root/World/Player")

func _on_save_pressed():
	save_data()
	pass # Replace with function body.

func save_data():
	var auth = Firebase.Auth.auth
	
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var data = {
			"CreatedBy": auth.localid,
			"player_position":  player.position 
			}
		var task: FirestoreTask = collection.update(auth.localid, data)
	pass


func _on_load_pressed():
	load_data()
	pass # Replace with function body.
	
func load_data():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var task: FirestoreTask = collection.get_doc(auth.localid)
		var finished_task: FirestoreTask = await task.task_finished
		var document = finished_task.document
		print(document)
		get_docs(document)
	pass
	
func get_docs(document):
	var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
	var docs = await collection.get_doc(document.doc_name).get_document
	print(docs.doc_fields.player_position)
	var pos: Array = docs.doc_fields.player_position.replace("(", "").replace(")", "").split(",")
	player.position.x = int(pos[0])
	player.position.y = int(pos[1])
	print(player.position)
	#var player_pos = Vector2i(str_to_var(docs.doc_fields.player_position))
	#player.position = player_pos
	pass
