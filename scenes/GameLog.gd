extends Node

signal advance 

var rich_text_label_ref: RichTextLabel = null

func register_log_ui(label_node: RichTextLabel):
	if label_node:
		rich_text_label_ref = label_node
		print("GameLog UI registered successfully.")
	else:
		print("Error: Passed a null node to register_log_ui!")

func add_entry(entry_text: String):
	if rich_text_label_ref != null:
		rich_text_label_ref.append_text(entry_text)
		rich_text_label_ref.scroll_to_line(9999)
	else:
		print("GameLog.gd ERROR: rich_text_label_ref is NULL. UI not connected!")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Advance"):
		advance.emit()
	pass
