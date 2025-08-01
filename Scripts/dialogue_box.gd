extends Control

var current_message = "Hello, can you hear me? Can you hear the VOID?"
var parsed_message = ""
var should_parse = false

var dialog = null
var tree_index = 0
var dial_index = 0
var dialog_tree = [
	[
		["SET", "The void."],
		["ADD", " The void."],
		["ADD", " The void."],
		["ADD", " The void."],
		["DELAY", 3],
		["SET", "My ultimate goal, if I were to make a mod, would be another Final Boss line, similar to CC and AF. Basically, using special Engraved Gems that you craft, you can summon various different bosses based off of the gems (Fire, Ice, Shadow, Telekenesis, Creation, Solar, and Lunar). You'll get special weapons and equipment for beating these bosses, and an Encrusted Fragment. After combining all of these fragments, it'll end up summoning this final boss, a power-crazed human named Paul that used to secretly care for Maxwell while he was on the throne, and wants nothing more than to overthrow the current Queen. Once eventually defeated, Charlie will end up smiting him (similar to AF), and it'll unlock Waul as a playable character as your final reward."],
		["DELAY", 1]
	],
]

func _ready():
	$AnimationPlayer.play("Appear")

func _process(delta):
	if should_parse:
		parsed_message += current_message[parsed_message.length()]
		if current_message.match(parsed_message): pause(1)
		$RichTextLabel.text = parsed_message

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print(self.visible)
	if self.visible and dial_index < dialog_tree[tree_index].size():
		should_parse = true
		dialog = dialog_tree[tree_index][dial_index]
		if dialog[0] == "DELAY":
			pause(dialog[1])
			return
		elif dialog[0] == "SET":
			set_message(dialog[1])
		elif dialog[0] == "ADD":
			add_to_message(dialog[1])
	elif self.visible:
		end_dialog()

func begin_dialog():
	$AnimationPlayer.play("Appear")
	
func end_dialog():
	$AnimationPlayer.play_backwards("Appear")
	should_parse = false
	
func set_message(text):
	current_message = text
	parsed_message = ""

func add_to_message(text):
	current_message += text
	
func pause(time):
	$Timer.start(time)
	should_parse = false

func _on_timer_timeout() -> void:
	dial_index += 1
	_on_animation_player_animation_finished("Appear")
