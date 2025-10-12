@tool
extends Sprite2D

@export var weapon_tscn : PackedScene : set = _set_weapon
@export var interaction_area : InteractionArea
@onready var player :Player = get_tree().get_first_node_in_group("Player")

var weapon : Weapon

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	interaction_area.on_interact = _on_interact

func _on_interact():
	self.queue_free()
	player.change_weapon(weapon_tscn)
	pass

func _set_weapon(_weapon_tscn :PackedScene):
	weapon_tscn = _weapon_tscn
	if _weapon_tscn and weapon_tscn.can_instantiate():
		self.texture = weapon_tscn.instantiate().texture
	else:
		self.texture = Texture.new()
