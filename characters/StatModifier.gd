class_name StatModifier extends Resource

var stat: String        # "ac", "attack", "str", etc
var value: int
var source: String      # "Mage Armor", "Ring of Protection"
var duration: int = -1  # -1 = permanent
