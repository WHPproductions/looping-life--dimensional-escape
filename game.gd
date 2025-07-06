extends Node2D

#var story: Array[Array] = [
	#[ Template story
		# Isi text cerita berupa string. story[0]
		# Float dihitung dalam detik, waktu ini berlaku ketika teks sudah di display penuh. story[1]
	#]
#]

var adegan_awal: Array[Array] = [
	[
		"Huh?! Mimpi apa tadi?",
		5.0,
	],
	[
		"Ada apa diluar? Dimana aku?",
		5.0,
	],
	[
		"...",
		5.0,
	],
]
var terbunuh_pertama: Array[Array] = [
	[
		"AAAAHH!",
		3.0,
	],
	[
		"Apa? kenapa aku masih hidup?",
		5.0,
	],
	[
		"...",
		5.0,
	],
	[
		"Mama... tolong aku!",
		5.0,
	],
]
var koleksi_light_pertama: Array[Array] =[
	[
		"Api itu...",
		3.0,
	],
	[
		"Sepertinya menyalakan suatu portal",
		5.0,
	],
	[
		"...",
		5.0,
	],
	[
		"Aku harus mengumpulkannya, tinggal 3 lagi",
		5.0,
	],
]
var lingkaran_teraktivasi: Array[Array] =[
	[
		"BAGUS!!",
		3.0,
	],
	[
		"KAU INGIN KELUAR DARI SINI BUKAN?",
		5.0,
	],
	[
		"IKUTI PERINTAHKU DAN DIAMLAH DI DALAM LINGKARAN ITU",
		5.0,
	],
	[
		"LALU BAYARLAH DENGAN NYAWAMU",
		5.0,
	],
	[
		"PENCET \"BACKSPACE\" UNTUK MENGORBANKAN NYAWAMU",
		100
	]
]
var lingkaran_sudah_aktivasi_dan_player_bundir: Array[Array] =[
	[
		"Ughh, sakit...",
		3.0,
	],
	[
		"Aku sudah membayar dengan nyawaku",
		5.0,
	],
	[
		"Harusnya aku bisa keluar dari sini",
		5.0,
	],
	[
		"Tadi ada pintu keluar di lapangan basket",
		5.0,
	],
	[
		"Aku pengen pulang, aku tak mau lagi mati",
		5.0,
	],
]

func _on_main_world_adegan_awal() -> void:
	$GameUI.display_story(adegan_awal)


func _on_main_world_terbunuh_pertama() -> void:
	$GameUI.display_story(terbunuh_pertama)


func _on_main_world_koleksi_light_pertama() -> void:
	$GameUI.display_story(koleksi_light_pertama)


func _on_main_world_lingkaran_teraktivasi() -> void:
	var label: Label = $GameUI/Control/MarginContainer/TopLabel
	label.label_settings.font_color = Color("af0000")
	$GameUI.display_story(lingkaran_teraktivasi)


func _on_main_world_lingkaran_sudah_aktivasi_dan_player_bundir() -> void:
	var label: Label = $GameUI/Control/MarginContainer/TopLabel
	label.label_settings.font_color = Color.WHITE
	$GameUI.display_story(lingkaran_sudah_aktivasi_dan_player_bundir)
