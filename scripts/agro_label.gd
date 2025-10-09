class_name AgroLabel extends Label

@export var anim_player : AnimationPlayer

func appear():
	anim_player.play("appear")
