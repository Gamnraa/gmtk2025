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
	stream = songs[Global.State]
	stream
	play()

func _process(delta):
	current_time += delta
	
	print(get_playback_position(), " ", stream.get_length())
	if get_playback_position() >= stream.get_length(): 
		seek(0)
		play()
		
	if state != Global.State:
		var t = get_playback_position()
		#stop()
		state = Global.State
		stream = songs[Global.State]
		await tween.tween_property(self, "volume_db", 0, 26)
		#tween.parallel().tween_property(self, "volume_db", 1, .16)
		tween.play()
		play()
		#tween.tween_property(self, "volume_db", 1, 1)
		#tween.play()
		seek(t)
		
	
	
	
