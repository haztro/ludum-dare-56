extends Node


enum RESOURCE_TYPE {
	WOOD,
	STONE,
	FOOD,
	CREATURES,
	GOLD,
}

enum CREATURE_TYPE {
	GATHERER,
	WARRIOR,
}

var resources = {
	RESOURCE_TYPE.WOOD: 0, 
	RESOURCE_TYPE.STONE: 0, 
	RESOURCE_TYPE.FOOD: 0,
	RESOURCE_TYPE.CREATURES: 0,
	RESOURCE_TYPE.GOLD: 0,
	}


var GATHERER_FOOD_COST = 10
var GATHERER_WOOD_COST = 25
var WARRIOR_FOOD_COST = 20
var WARRIOR_WOOD_COST = 50
var WARRIOR_STONE_COST = 25
var CAMP_FACTOR = 100.0

var area_cleared = false

func add_resource(resource_type: RESOURCE_TYPE, amount:int=1):
	resources[resource_type] += amount
	var ui = get_tree().get_first_node_in_group("ui")
	ui.resource_icons[resource_type].set_value(resources[resource_type])
	if resource_type == RESOURCE_TYPE.GOLD:
		var num_enemies = len(get_tree().get_nodes_in_group("enemy"))
		if num_enemies == 0:
			area_cleared = true
			ui.win_state()


func remove_resource(resource_type: RESOURCE_TYPE, amount:int=1):
	resources[resource_type] -= amount
	var ui = get_tree().get_first_node_in_group("ui")
	ui.resource_icons[resource_type].set_value(resources[resource_type])


func summon_creature(creature_type: CREATURE_TYPE):
	if creature_type == CREATURE_TYPE.GATHERER:
		if resources[RESOURCE_TYPE.FOOD] >= GATHERER_FOOD_COST and resources[RESOURCE_TYPE.WOOD] >= GATHERER_WOOD_COST:
			remove_resource(RESOURCE_TYPE.FOOD, GATHERER_FOOD_COST)
			remove_resource(RESOURCE_TYPE.WOOD, GATHERER_WOOD_COST)
			get_tree().get_first_node_in_group("world").add_gatherer()
		else:
			return false
	elif creature_type == CREATURE_TYPE.WARRIOR:
		if resources[RESOURCE_TYPE.FOOD] >= WARRIOR_FOOD_COST and resources[RESOURCE_TYPE.WOOD] >= WARRIOR_WOOD_COST and resources[RESOURCE_TYPE.STONE] >= WARRIOR_STONE_COST:
			remove_resource(RESOURCE_TYPE.FOOD, WARRIOR_FOOD_COST)
			remove_resource(RESOURCE_TYPE.WOOD, WARRIOR_WOOD_COST)
			remove_resource(RESOURCE_TYPE.STONE, WARRIOR_STONE_COST)
			get_tree().get_first_node_in_group("world").add_warrior()
		else:
			return false
	return true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
