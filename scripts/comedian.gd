extends CharacterBody3D


const SPEED = 3.0

@export_node_path var fall_trigger_path

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var fall_trigger = get_node(fall_trigger_path)
var target_velocity = Vector3.ZERO
var angular_accelaration = 5
var speed

func _ready():
	var helper = func(body):
		if body == self:
			_fall_trigger_entered()
	fall_trigger.connect("body_entered", helper)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta


	var direction = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left") || Input.is_action_pressed("move_back") || Input.is_action_pressed("move_forward"):
		speed = 10
		velocity = Vector3(Input.get_action_strength("move_right")-Input.get_action_strength("move_left"),0,Input.get_action_strength("move_down")-Input.get_action_strength("move_forward"))
	else:
		speed = 0
		
	rotation.y = lerp(rotation.y,atan2(-velocity.x,-velocity.z),delta*angular_accelaration)
		# Setting the basis property will affect the rotation of the node.
		#$Pivot.basis = Basis.looking_at(direction)
	
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#if Input.is_action_pressed("move_forward")
	#var input_dir = Input.get_vector("move_left", "move_right", "move_back", "move_front")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#
	#if direction:
		#print(direction)
		#velocity.x = direction.x * SPEED
		#rotation.y += direction.z * SPEED * delta
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	self.move_and_slide(velocity *speed, Vector3.UP)


func _fall_trigger_entered():
	print("Fall trigger triggered :)")
