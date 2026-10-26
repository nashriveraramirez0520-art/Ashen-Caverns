class_name ItemData #Esta es la plantilla la cual almacena los datos de cada item, como nombre, rareza, si es consumible, etc.
extends Resource

enum Rarity {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY}

@export var id: StringName
@export var display_name: String
@export var rarity: Rarity = Rarity.COMMON
@export var stackable: bool = false
@export var consumable: bool = false
@export var abilities: Array[Ability] = []
@export var max_stack: int = 1

func get_stack_limit() -> int:
    return max_stack if stackable else 1

func use(user: Node, target: Node) -> void:
    for ability in abilities:
        ability.execute(user, target)