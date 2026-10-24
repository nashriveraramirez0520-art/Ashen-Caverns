class_name Ability
extends Resource

@export var id: StringName
@export var display_name: String
@export_multiline var description: String

func use(_user: Node, _target: Node = null) -> void: #Eliminar el "_" de user y target cuando se implemente la función
    push_warning("Ability use() sin implementar: %s" % id)
    