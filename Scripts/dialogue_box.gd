extends Control

var current_message = "Hello, can you hear me? Can you hear the VOID?"
var parsed_message = ""
var should_parse = false

func _ready():
	$AnimationPlayer.play("Appear")

func _process(delta):
	if should_parse:
		parsed_message += current_message[parsed_message.length()]
		should_parse = not current_message.match(parsed_message)
		$RichTextLabel.text = parsed_message

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	should_parse = true
	
	
func set_message(message):
	current_message = message

func add_to_message(text):
	current_message += text
