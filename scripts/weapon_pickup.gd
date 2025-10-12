@tool
extends Node2D

@export var interaction_area :InteractionArea
@export var sprite :Sprite2D
@export var weapon_data :WeaponData : set = _set_weapon_data
@onready var player :Player = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	interaction_area.on_interact = _on_interact

func _on_interact():
	player.change_weapon(weapon_data)
	self.queue_free()

func _set_weapon_data(data :WeaponData):
	weapon_data = data
	if data:
		sprite.texture = weapon_data.texture
	else:
		sprite.texture = Texture.new()
