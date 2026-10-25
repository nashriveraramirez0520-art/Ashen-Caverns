extends CharacterBody2D

# =====================================================
# 1. FÍSICAS DE CAÍDA Y SALTO (valores en píxeles)
# =====================================================
const JUMP_HEIGHT := 110.0       # altura del salto
const TIME_TO_PEAK := 0.40       # segundos hasta llegar arriba
const TIME_TO_FALL := 0.30       # segundos para caer (menor = cae más rápido)
const MAX_FALL_SPEED := 900.0    # velocidad máxima de caída

# Se calculan solas a partir de los valores de arriba
var jump_velocity: float = -(2.0 * JUMP_HEIGHT) / TIME_TO_PEAK
var jump_gravity: float = (2.0 * JUMP_HEIGHT) / (TIME_TO_PEAK * TIME_TO_PEAK)
var fall_gravity: float = (2.0 * JUMP_HEIGHT) / (TIME_TO_FALL * TIME_TO_FALL)

func _current_gravity() -> float:
	# En 2D, Y negativa es hacia arriba: subir = velocity.y < 0
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += _current_gravity() * delta
		velocity.y = min(velocity.y, MAX_FALL_SPEED)

func _handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_crouching:
		velocity.y = jump_velocity


# =====================================================
# 2. VELOCIDAD DE CAMINAR Y AGACHADO
# =====================================================
const WALK_SPEED := 250.0
const CROUCH_SPEED := 110.0
const ACCELERATION := 1800.0    # qué tan rápido alcanza la velocidad
const FRICTION := 2200.0        # qué tan rápido se detiene

const STAND_HEIGHT := 64.0
const CROUCH_HEIGHT := 36.0

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var ceiling_check: RayCast2D = $RayCast2D

var is_crouching := false

func _handle_crouch() -> void:
	var wants_crouch := Input.is_action_pressed("crouch")
	# Si hay techo encima, te quedas agachado aunque sueltes la tecla
	is_crouching = wants_crouch or (is_crouching and ceiling_check.is_colliding())

	var new_height := CROUCH_HEIGHT if is_crouching else STAND_HEIGHT
	var shape := collision.shape as RectangleShape2D
	shape.size.y = new_height
	collision.position.y = -new_height / 2.0   # mantiene los pies en el suelo

func _handle_movement(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	var speed := CROUCH_SPEED if is_crouching else WALK_SPEED

	if direction != 0.0:
		velocity.x = move_toward(velocity.x, direction * speed, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, FRICTION * delta)


# =====================================================
# 3. CONFIGURACIÓN DE TECLAS
# =====================================================
# Para cambiar una tecla, edita solo esta tabla
const KEY_BINDINGS := {
	"move_left":  [KEY_A, KEY_LEFT],
	"move_right": [KEY_D, KEY_RIGHT],
	"jump":       [KEY_SPACE, KEY_W, KEY_UP],
	"crouch":     [KEY_S, KEY_DOWN, KEY_CTRL],
    "backpack":   [KEY_I]
    "grab":       [KEY_E]
    "interact":   [MOUSE_BUTTON_RIGHT]
}

func _setup_inputs() -> void:
	for action in KEY_BINDINGS:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		for key in KEY_BINDINGS[action]:
			var event := InputEventKey.new()
			event.physical_keycode = key
			InputMap.action_add_event(action, event)


# =====================================================
# BUCLE PRINCIPAL
# =====================================================
func _ready() -> void:
	_setup_inputs()

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_handle_crouch()
	_handle_jump()
	_handle_movement(delta)
	move_and_slide()

    

func _Abrir_y_cerrar_mochila
        
         var inventario_abierto: bool = false

          _unhandled_input(event: float) -> void:

	        # Si presionas la tecla "inventario" (por ejemplo, la I)            
            if Input.is_action_just_pressed("backpack"):

        # Invertimos el valor: si era falso pasa a verdadero, y viceversa

            inventario_abierto = not inventario_abierto
		
		        if inventario_abierto:
	        
            		print("Mochila abierto")
			# ( $UI_Inventario.show())
	        	
                else:
		            
                    print("Mochila cerrado")
			# ($UI_Inventario.hide())

func _movi_de_slots
    
     _unhandled_input(event: InputEvent) -> void:
	# --- DETECTAR RUEDA DEL RATÓN (SCROLL) ---
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			# Girar rueda hacia arriba -> Mover al slot anterior
			slot_activo -= 1
			if slot_activo < 0:
				slot_activo = 4 # Vuelve al último slot si te pasas
			cambiar_slot(slot_activo)

		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			# Girar rueda hacia abajo -> Mover al siguiente slot
			slot_activo += 1
			if slot_activo > 4:
				slot_activo = 0 # Vuelve al primer slot si te pasas
			cambiar_slot(slot_activo)

		# --- CLICS DE RATÓN (TUS CLICS ORIGINALES) ---
		elif event.button_index == MOUSE_BUTTON_LEFT:
			print("Click izquierdo en slot ", slot_activo + 1)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			print("Click derecho en slot ", slot_activo + 1)
