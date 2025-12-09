class_name Skills extends Node

enum SkillType {
	ACROBATICS,
	ANIMAL_HANDLING,
	ARCANA,
	ATHLETICS,
	DECEPTION,
	HISTORY,
	INSIGHT,
	INTIMIDATION,
	INVESTIGATION,
	MEDICINE,
	NATURE,
	PERCEPTION,
	PERFORMANCE,
	PERSUASION,
	RELIGION,
	SLEIGHT_OF_HAND,
	STEALTH,
	SURVIVAL
}

var acrobatics: int = 0
var animal_handling: int = 0
var arcana: int = 0
var athletics: int = 0
var deception: int = 0
var history: int = 0
var insight: int = 0
var intimidation: int = 0
var investigation: int = 0
var medicine: int = 0
var nature: int = 0
var perception: int = 0
var performance: int = 0
var persuasion: int = 0
var religion: int = 0
var sleight_of_hand: int = 0
var stealth: int = 0
var survival: int = 0

func set_skills(p: PlayerCharacter) -> void:
	set_skills_by_stats(p.core_data.stats)
	update_skills_proficiencies(p.core_data.proficiencies, p.core_data.proficiency_bonus)
	update_skills_expertise(p.core_data.expertise, p.core_data.proficiency_bonus)
	update_skills_by_race(p.core_data.race, p.core_data.proficiency_bonus)
	update_skills_by_background(p.core_data.background, p.core_data.proficiency_bonus)
	pass

func set_skills_by_stats(s: Stats) -> void:
	acrobatics = s.get_ability_modifier(s.dexterity)
	animal_handling = s.get_ability_modifier(s.wisdom)
	arcana = s.get_ability_modifier(s.intelligence)
	athletics = s.get_ability_modifier(s.strength)
	deception = s.get_ability_modifier(s.charisma)
	history = s.get_ability_modifier(s.intelligence)
	insight = s.get_ability_modifier(s.wisdom)
	intimidation = s.get_ability_modifier(s.charisma)
	investigation = s.get_ability_modifier(s.intelligence)
	medicine = s.get_ability_modifier(s.wisdom)
	nature = s.get_ability_modifier(s.intelligence)
	perception = s.get_ability_modifier(s.wisdom)
	performance = s.get_ability_modifier(s.charisma)
	persuasion = s.get_ability_modifier(s.charisma)
	religion = s.get_ability_modifier(s.intelligence)
	sleight_of_hand = s.get_ability_modifier(s.dexterity)
	stealth = s.get_ability_modifier(s.dexterity)
	survival = s.get_ability_modifier(s.wisdom)
	pass
	
func update_skills_proficiencies(proficiencies: Array[Skills.SkillType], pb: int) -> void:
	for p in proficiencies:
		update_proficiency(p, pb)
	pass

func update_skills_expertise(expertises: Array[Skills.SkillType], pb: int) -> void:
	for e in expertises:
		update_proficiency(e, pb)
	pass

func update_proficiency(p: Skills.SkillType , pb: int) -> void:
	match p:
		Skills.SkillType.ACROBATICS:
			acrobatics += pb
		Skills.SkillType.ANIMAL_HANDLING:
			animal_handling += pb
		Skills.SkillType.ARCANA:
			arcana += pb
		Skills.SkillType.ATHLETICS:
			athletics += pb
		Skills.SkillType.DECEPTION:
			deception += pb
		Skills.SkillType.HISTORY:
			history += pb
		Skills.SkillType.INSIGHT:
			insight += pb
		Skills.SkillType.INTIMIDATION:
			intimidation += pb
		Skills.SkillType.INVESTIGATION:
			investigation += pb
		Skills.SkillType.MEDICINE:
			medicine += pb
		Skills.SkillType.NATURE:
			nature += pb
		Skills.SkillType.PERCEPTION:
			perception += pb
		Skills.SkillType.PERFORMANCE:
			performance += pb
		Skills.SkillType.PERSUASION:
			persuasion += pb
		Skills.SkillType.RELIGION:
			religion += pb
		Skills.SkillType.SLEIGHT_OF_HAND:
			sleight_of_hand += pb
		Skills.SkillType.STEALTH:
			stealth += pb
		Skills.SkillType.SURVIVAL:
			survival += pb
	pass

func update_skills_by_race(c: Race.RaceType, pb: int) -> void:
	match c:
		Race.RaceType.ELF:
			perception += pb
	pass
	
func update_skills_by_background(b: Background.BackgroundType, pb: int) -> void:
	match b:
		Background.BackgroundType.CRIMINAL:
			deception += pb
			stealth += pb
		Background.BackgroundType.ACOLYTE:
			insight += pb
			religion += pb
		Background.BackgroundType.NOBLE:
			history += pb
			persuasion += pb
		Background.BackgroundType.SOLDIER:
			athletics += pb
			intimidation += pb
		Background.BackgroundType.FOLKHERO:
			animal_handling += pb
			survival += pb
	pass
