extends CharacterBody3D

signal death

@export var moveSpeed : float = 2
@export var rotationSpeed : float = 3 

const SPEED = 3.0

@export_node_path var dialog_path
@export_node_path var fall_trigger_path
@export var ragdoll_skeleton : Skeleton3D
@export var capsule_collider : CollisionShape3D
@export var animation_player : AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var dead = false;
var disable_movement = false

@onready var fall_trigger = get_node(fall_trigger_path)


func _ready():
	print(get_node(dialog_path))
	get_node(dialog_path).connect("dialog_begin", anim_dialog_begin)
	var helper = func(body):
		if body == self:
			_fall_trigger_entered()
	fall_trigger.connect("body_entered", helper)


func _physics_process(delta):
	if not _sanity() or disable_movement:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector( "Move Right", "Move Left", "Move Back", "Move Front")
	var direction = (transform.basis * Vector3(0, 0,moveSpeed * - input_dir.y)* delta)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	anim_panic(input_dir.y)
		# var calcrot = atan2(input_dir.y*2,input_dir.x*2) * 57.29 
	#	rotation_degrees.y = calcrot
	rotation_degrees.y += input_dir.x * rotationSpeed * delta
	move_and_slide()


func _fall_trigger_entered():
	_pass_out()
	await get_tree().create_timer(1.0).timeout
	emit_signal("death")

	

func _pass_out():
	if not _sanity():
		return
	ragdoll_skeleton.physical_bones_start_simulation()
	get_tree().create_timer(10).timeout.connect(self.hide)
	#capsule_collider.disabled = true
	dead = true
	

func _sanity() -> bool:
	return !dead


func anim_dialog_begin():
	anim_play("talk")


func anim_panic(walkspeed):
	if walkspeed != 0:
		anim_play("panic_run", walkspeed<0)
	else:
		anim_play("panic")


func anim_play(animation_name,backwards = false):
	if (animation_player.current_animation != animation_name):
		if (backwards):
			animation_player.play(animation_name)
		else:
			animation_player.play_backwards(animation_name)


func hurt():
	$Hurt.play()
