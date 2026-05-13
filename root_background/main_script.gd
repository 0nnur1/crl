extends CanvasLayer

@onready var input_line = $distro/VBoxContainer/input_line/input
@onready var prefix = $distro/VBoxContainer/input_line/prefix
@onready var command_log = $distro/VBoxContainer/history
@onready var scrolling_box = $distro

@onready var is_typing: bool = false

const UBUNTU_GREEN = "#8ae234"
const UBUNTU_BLUE = "#729fcf"

func _ready():
	prefix.text = ("[color="+UBUNTU_GREEN+"]"+globals.current_user+"@"+globals.pc_name+"[/color]"+":")
	prefix.append_text("[color=" + UBUNTU_BLUE + "]" + globals.current_dir + "[/color]$ ")
	input_line.grab_focus()

func _on_bg_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_handle_background_click()

func _handle_background_click():
	input_line.grab_focus()

func _on_input_text_submitted(new_text: String):
	if is_typing:
		return
	is_typing = true
	
	
	var command = new_text.strip_edges()
	
	if command.to_lower() == "clear":
		command_log.clear()
		input_line.clear()
		is_typing = false
		return
		
	input_line.clear()
	
	# Print the user part (Green)
	await fancy_print_to_log(globals.current_user+"@"+globals.pc_name, 0.01, UBUNTU_GREEN)
	
	command_log.append_text(":")
	
	# Print the directory part (Blue)
	await fancy_print_to_log(globals.current_dir, 0.01, UBUNTU_BLUE)
	
	command_log.append_text("$ ")
	
	# Print the command they just typed (White)
	await fancy_print_to_log(command, 0.015)
	
	# Run the actual command logic
	await process_command(command)
	
	# Auto-scroll to the bottom
	await get_tree().process_frame
	scrolling_box.scroll_vertical = scrolling_box.get_v_scroll_bar().max_value
	
	is_typing = false

func process_command(input: String) -> void:
	command_log.append_text("\n")
	var tokens = input.split(" ", false)
	
	if tokens.size() == 0:
		return
	
	var command = tokens[0].to_lower()
	
	var args = tokens.slice(1)
	
	match command:
		"help":
			
			await fancy_print_to_log("No. :3", 0.25, "#9b1937")
			command_log.append_text("\n    ")
			await fancy_print_to_log("(Just use the wiki or something.)", 0.03, "#00ac58")
			command_log.append_text("\n")
		
		"neofetch":
			await fancy_print_to_log("ASCII logo fr", 0.08, "#df4b78")
			command_log.append_text("\n")
			
	

func fancy_print_to_log(input: String, delay: float, color: String = "#ffffff") -> void:
	command_log.append_text("[color=" + color + "]")
	
	for i in range(input.length()):
		command_log.append_text(input[i])
		await get_tree().create_timer(delay).timeout
		
	command_log.append_text("[/color]")
