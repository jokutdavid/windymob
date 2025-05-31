extends CanvasLayer

func _process(delta):
	$FPSCounter.text = str(Engine.get_frames_per_second()) + "FPS"
