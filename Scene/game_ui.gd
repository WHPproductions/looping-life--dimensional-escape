extends CanvasLayer

@export var typing_speed: float = 30 # Characters per seconds
var _typing_time: float

## Memperlihatkan dialog di atas UI
## Formatnya [String(Isi teks), float(detik)]
func display_story(story_array: Array[Array]) -> void:
	for text_and_time in story_array:
		var text: String = text_and_time[0]
		var time: float = text_and_time[1]
		display_text(text)
		%TopLabel/ReadingTime.wait_time = time
		%TopLabel/ReadingTime.start()
		await %TopLabel/ReadingTime.timeout
		print("yay")
	
	%TopLabel.text = ""

func display_text(text: String) -> void:
	%TopLabel.text = text
	%TopLabel.visible_characters = 0
	_typing_time = 0
	while %TopLabel.visible_characters < %TopLabel.get_total_character_count():
		_typing_time += get_process_delta_time()
		%TopLabel.visible_characters = typing_speed * _typing_time as int
		if get_tree():
			await get_tree().process_frame
