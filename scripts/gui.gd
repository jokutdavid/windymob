extends CanvasLayer

func _process(delta):
	$FPSCounter.text = str(round(1 / delta)) + " FPS"
