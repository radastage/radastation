/client/proc/loadworld()
	set category = "Debug"
	set name = "Load World" //Gave this shit a shorter name so you only have to time out "asay" rather than "admin say" to use it --NeoFite
	set hidden = 0
	if(!check_rights(0))	return

	Good_Load()

/client/proc/saveworld()
	set category = "Debug"
	set name = "Save World"
	set hidden = 0
	if(!check_rights(0))	return

	Good_Save("1")

/client/proc/saveworld_alt()
	set category = "Debug"
	set name = "Save World Alt"
	set hidden = 0
	if(!check_rights(0))	return

	Good_Save("2")
	src << "Check 2.sav in MapSaves folder."