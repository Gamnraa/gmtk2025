extends AudioStreamPlayer

var state = Global.NONE
var current_time = 0
var tween = create_tween()

@onready var songs = {
	Global.RED:load("res://Audio/r.ogg"),
	Global.BLUE:load("res://Audio/b.ogg"),
	Global.GREEN:load("res://Audio/g.ogg"),
	Global.REDGREEN:load("res://Audio/rg.ogg"),
	Global.REDBLUE:load("res://Audio/rb.ogg"),
	Global.GREENBLUE:load("res://Audio/gb.ogg"),
	Global.REDGREENBLUE:load("res://Audio/rgb.ogg"),
	Global.NONE:load("res://Audio/base_track.ogg")
}

func _ready():
	state = Global.State
	play()
	get_stream_playback().switch_to_clip_by_name("base")
	

func _process(delta):
	if state != Global.State:
		get_stream_playback().switch_to_clip(Global.State)
		state =  Global.State
		
	
	
	
