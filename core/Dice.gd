class_name Dice extends Node

# Roll a single die, e.g. roll_dice(20) → 1–20
func roll_dice(sides: int) -> int:
	return randi_range(1, sides)

# Roll multiple dice, e.g. roll(3, 6) → 3d6
func roll(count: int, sides: int) -> int:
	var total := 0
	for i in count:
		total += roll_dice(sides)
	return total

# Utility for common dice
func d4() -> int: return roll_dice(4)
func d6() -> int: return roll_dice(6)
func d8() -> int: return roll_dice(8)
func d10() -> int: return roll_dice(10)
func d12() -> int: return roll_dice(12)
func d20() -> int: return roll_dice(20)
