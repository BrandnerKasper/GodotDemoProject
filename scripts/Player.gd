extends Area2D

# Signals
signal hit

# Declare member variables here. Examples:
export var speed = 400; #(pixels/sec)
var screen_size #Size of the game window


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	# Hide player
	hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Player Movement
	var velocity = Vector2.ZERO

	# Set Movement direction
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	# Set correct animation to play
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		# $AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

	# Normalize velocity and play animation if there is one
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# Set position of player and don`t let it move outside the window
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Player_body_entered(_body: Node):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos: Vector2):
	position = pos
	show()
	$CollisionShape2D.disabled = false
