class_name Inventory
extends RefCounted

signal changed

var slots: Array = []

func _init(size: int) -> void:
    slots.resize(size)
    slots.fill(null)

func add(item: ItemData, quantity: int = 1) -> bool:
    if quantity <= 0:
        return false

    if get_free_space_for(item) < quantity:
        return false

    var remaining: int =  quantity
    var limit:int = item.get_stack_limit()

    if item.stackable:
        for i in slots.size():
            if remaining <= 0:
                break
            var stack: ItemStack = slots[i]
            if stack != null and stack.item.id == item.id:
                var to_add: int = mini(limit - stack.quantity, remaining)
                stack.quantity += to_add
                remaining -= to_add

    for i in slots.size():
        if remaining <= 0:
            break
        if slots[i] == null:
            var to_place: int = mini(limit, remaining)
            slots[i] = ItemStack.new(item, to_place)
            remaining -= to_place

    changed.emit()
    return true

func get_free_space_for(item: ItemData) -> int:
    var limit: int = item.get_stack_limit()
    var total: int = 0
    for i in slots.size():
        var stack: ItemStack = slots[i]
        if stack == null:
            total += limit
        elif stack.item.id == item.id:
            total += limit - stack.quantity
    return total

    
