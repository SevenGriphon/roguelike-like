extends EnemyFollow
class_name EnemyAgresiveFollow

var agro_time :float

func enter():
	super()
	agro_time = randf_range(3, 5)
	ignore_distance = true

func update(delta):
	if agro_time > 0:
		super.update(delta)
		agro_time -= delta
	else:
		state_transition.emit(self, "Follow")

func physics_update(delta):
	super(delta)
