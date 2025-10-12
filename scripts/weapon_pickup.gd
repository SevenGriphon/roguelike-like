extends Node2D

@export var interaction_area :InteractionArea
@export var sprite :Sprite2D
@export var weapon_data :WeaponData
@onready var player :Player = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	sprite.texture = weapon_data.texture
	interaction_area.on_interact = _on_interact

func _on_interact():
	print("Picked Up")
	player.change_weapon(weapon_data)
