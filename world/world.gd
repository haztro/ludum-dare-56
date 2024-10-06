extends Node2D


var tree_scene: PackedScene = preload("res://world/tree.tscn")
var stone_scene: PackedScene = preload("res://world/stone.tscn")
var food_scene: PackedScene = preload("res://world/food.tscn")
var monument_scene: PackedScene = preload("res://world/monument.tscn")

var wood_item_scene: PackedScene = preload("res://world/wood_item.tscn")
var stone_item_scene: PackedScene = preload("res://world/stone_item.tscn")
var food_item_scene: PackedScene = preload("res://world/food_item.tscn")
var gold_item_scene: PackedScene = preload("res://world/gold_item.tscn")

var gatherer_scene: PackedScene = preload("res://creature/gatherer.tscn")
var warrior_scene: PackedScene = preload("res://creature/warrior.tscn")
var enemy_gatherer_scene: PackedScene = preload("res://creature/enemy_gatherer.tscn")
var enemy_warrior_scene: PackedScene = preload("res://creature/enemy_warrior.tscn")


var camp_scene: PackedScene = preload("res://world/camp.tscn")

var grid_size: int = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	

func _ready():
	generate()
	
	#print(len(get_tree().get_nodes_in_group("tree")) * 4)
	#print(len(get_tree().get_nodes_in_group("food")) * 4)
	#print(len(get_tree().get_nodes_in_group("stone")) * 4)
	#
	#
	#var num_e = len(get_tree().get_nodes_in_group("enemy"))
	#print(num_e)
	#print(num_e * 50)
	#print(num_e * 25)
	#print(num_e * 25)
	#


func add_first_man():
	add_gatherer()
	
	
func add_gatherer():
	$AudioStreamPlayer.play()
	get_tree().get_first_node_in_group("player").add_creature(gatherer_scene.instantiate())
	
func add_warrior():
	$AudioStreamPlayer.play()
	get_tree().get_first_node_in_group("player").add_creature(warrior_scene.instantiate())
	

func drop_item(item_type: Game.RESOURCE_TYPE, drop_pos: Vector2):
	if item_type == Game.RESOURCE_TYPE.WOOD:
		var wood = wood_item_scene.instantiate()
		add_child(wood)
		wood.drop_item(drop_pos)
	elif item_type == Game.RESOURCE_TYPE.STONE:
		pass
	elif item_type == Game.RESOURCE_TYPE.FOOD:
		pass
	
	
func add_enemy(camp: Camp):
	var distance = Vector2.ZERO.distance_to(camp.position)
	var factor = 5*(1 - exp(-0.001 * distance)) + 1
	
	for i in range(factor):
		var enemy = enemy_warrior_scene.instantiate()
			
		camp.members.append(enemy)
		enemy.camp = camp
		enemy.position = camp.position + Vector2.LEFT.rotated(randf_range(0, 2*PI)) * randi_range(10.0, 16.0)
		add_child(enemy)
	
	
func generate():
	var tree_noise: FastNoiseLite
	var tree_noise_detail: FastNoiseLite
	var camp_noise: FastNoiseLite
	var food_noise: FastNoiseLite
	var stone_noise: FastNoiseLite
	var monument_noise: FastNoiseLite
	
	seed(1)  # For reproducibility, you might want to use a fixed seed
	tree_noise = FastNoiseLite.new()
	tree_noise.seed = randi()  # Or use a fixed seed for consistent generation
	tree_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	tree_noise.frequency = 0.05
	tree_noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	tree_noise.fractal_octaves = 1
	tree_noise.fractal_lacunarity = 2
	tree_noise.fractal_gain = 0.5
	
	tree_noise_detail = FastNoiseLite.new()
	tree_noise_detail.seed = randi()  # Or use a fixed seed for consistent generation
	tree_noise_detail.noise_type = FastNoiseLite.TYPE_SIMPLEX
	tree_noise_detail.frequency = 0.5
	tree_noise_detail.fractal_type = FastNoiseLite.FRACTAL_FBM
	tree_noise_detail.fractal_octaves = 1
	tree_noise_detail.fractal_lacunarity = 2
	tree_noise_detail.fractal_gain = 0.5
	
	
	camp_noise = FastNoiseLite.new()
	camp_noise.seed = randi()  # Or use a fixed seed for consistent generation
	camp_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	camp_noise.frequency = 0.9
	camp_noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	camp_noise.fractal_octaves = 1
	camp_noise.fractal_lacunarity = 2
	camp_noise.fractal_gain = 0.5
	
	food_noise = FastNoiseLite.new()
	food_noise.seed = randi()  # Or use a fixed seed for consistent generation
	food_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	food_noise.frequency = 0.5
	food_noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	food_noise.fractal_octaves = 1
	food_noise.fractal_lacunarity = 2
	food_noise.fractal_gain = 0.5
	
	stone_noise = FastNoiseLite.new()
	stone_noise.seed = randi()  # Or use a fixed seed for consistent generation
	stone_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	stone_noise.frequency = 0.9
	stone_noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	stone_noise.fractal_octaves = 1
	stone_noise.fractal_lacunarity = 2
	stone_noise.fractal_gain = 0.5
	
	
	monument_noise = FastNoiseLite.new()
	monument_noise.seed = randi()  # Or use a fixed seed for consistent generation
	monument_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	monument_noise.frequency = 0.9
	monument_noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	monument_noise.fractal_octaves = 1
	monument_noise.fractal_lacunarity = 2
	monument_noise.fractal_gain = 0.5
	
	for x in range(-grid_size, grid_size):
		for y in range(-grid_size, grid_size):
			
			var distance = Vector2(x*4, y*4).length()
			
			if distance > 150 and monument_noise.get_noise_2d(x, y) > 0.98:
				var monument = monument_scene.instantiate()
				monument.position = Vector2(x*8 + randi_range(0, 2), y*4 + randi_range(0, 2))
				add_child(monument)
				continue
			
			if food_noise.get_noise_2d(x, y) > 0.93:
				var food = food_scene.instantiate()
				food.position = Vector2(x*8 + randi_range(0, 2), y*4 + randi_range(0, 2))
				add_child(food)
				continue
							
							
			if stone_noise.get_noise_2d(x, y) > 0.93:
				var stone = stone_scene.instantiate()
				stone.position = Vector2(x*8 + randi_range(0, 2), y*4 + randi_range(0, 2))
				add_child(stone)
				continue
				
			
			if distance > 100 and camp_noise.get_noise_2d(x, y) > 0.955:
				var camp = camp_scene.instantiate()
				camp.position = Vector2(x*8 + randi_range(0, 2), y*4 + randi_range(0, 2))
				add_child(camp)
				continue
				

			if tree_noise.get_noise_2d(x, y) > 0.85 or tree_noise_detail.get_noise_2d(x, y) > 0.95: 
				var tree = tree_scene.instantiate()
				tree.position = Vector2(x*8 + randi_range(0, 2), y*4 + randi_range(0, 2))
				add_child(tree)
				continue
			
			
