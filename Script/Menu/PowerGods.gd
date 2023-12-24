extends Sprite2D

var godsNameArray = ["GoddessOfTeleportation", "GodOfDeath"]
var godNameInPowerGods = ""

var godTexts = {
	"GoddessOfTeleportation": {
		"passif": "Chaque pièces possèdent sa zone de téléportation. La téléportation est obligatoirement symétrique par rapport à la pièce. Une pièce jouée sur une case comprenant deux zones de téléportation ou plus, la téléportation ne s’effectue pas. Il ne peut y avoir qu’une téléportation au cours d’un mouvement. Les pièces adverses ne peuvent pas activer la téléportation. Une pièce qui se téléporte sur une case comprenant une pièce adverse la prend.",
		"pawn": "Zone de téléportation d’une case derrière",
		"knight": "Quand elle enjambe une pièce active la téléportation",
		"bishop": "Zone de téléportation en croix d’une case",
		"rook": "Zone de téléportation en diagonale d’une case",
		"queen": "Zone de téléportation tout autour d’elle d’une case",
		"king": "Zone de téléportation de trois cases en losange"
	},
	"GodOfDeath": {
		"passif": "Lorsqu’une de vos pièces ce fait prendre par une pièce adverse, pose un compte à rebours sur une pièces adverse aléatoirement par rapport à l’échelle de force de GodsChess. Le compte à rebours est de 5 tours. La faction prise ne peut poser un compte à rebours seulement sur une faction inférieur à lui (Exception lié à la faction des pions). L’effet de la mort ne s’active que si la pièce se fait prendre seulement (la mort par un effet n’active pas le compte à rebours).",
		"pawn": "Tous les deux pions pris pose un compte à rebours tout d’abord sur les pions, puis pions et cavalier, puis pions,cavalier et fou et enfin pions, cavalier, fou et tour",
		"knight": "Pose un compte à rebours aléatoirement sur un pion adverse",
		"bishop": "Pose un compte à rebours aléatoirement sur un pion ou un cavalier adverse",
		"rook": "Pose un compte à rebours aléatoirement sur un pion, un cavalier ou un fou adverse",
		"queen": "Pose un compte à rebours aléatoirement sur un pion, un cavalier, un fou ou une tour adverse",
		"king": "Quand le roi se fait mettre en échec pose un compte un rebours n’importe quelles pièces. (3 utilisations)"
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialisationScreen(godName):
	if godName in godTexts:
		var godData = godTexts[godName]
		get_node("ButtonsFactions/SignOfGod").texture = load("res://Image/Gods/" + godName + "/Signe dieux.png")
		get_node("ButtonsFactions/SpritePawn").texture = load("res://Image/Gods/" + godName + "/Pieces/Base pièce doubler - Pion.png")
		get_node("ButtonsFactions/SpriteKnight").texture = load("res://Image/Gods/" + godName + "/Pieces/Base pièce doubler - Cavalier.png")
		get_node("ButtonsFactions/SpriteBishop").texture = load("res://Image/Gods/" + godName + "/Pieces/Base pièce doubler - Fou.png")
		get_node("ButtonsFactions/SpriteRook").texture = load("res://Image/Gods/" + godName + "/Pieces/Base pièce doubler - Tour.png")
		get_node("ButtonsFactions/SpriteQueen").texture = load("res://Image/Gods/" + godName + "/Pieces/Base pièce doubler - Reine.png")
		get_node("ButtonsFactions/SpriteKing").texture = load("res://Image/Gods/" + godName + "/Pieces/Base pièce doubler - Roi.png")
		get_node("TextPowerFactions").text = godData["passif"]
		get_node("ZoneGif/GifPowerFactions").set_animation("Passif" + godName )
	get_node("HoverSelectionFaction").texture = load("res://Image/Menu/HoverSelectionPassif.png")
	get_node("HoverSelectionFaction").position.x = 608
	get_node("HoverSelectionFaction").position.y = 167
	get_node("ZoneGif/GifPowerFactions").play()

func _on_gods_screen_god_selected(godName):
	godNameInPowerGods = godName
	initialisationScreen(godName)

func _on_button_passif_button_down():
	if godNameInPowerGods in godTexts:
		var godData = godTexts[godNameInPowerGods]
		get_node("TextPowerFactions").text = godData["passif"]
		get_node("ZoneGif/GifPowerFactions").set_animation("Passif" + godNameInPowerGods )
		get_node("ZoneGif/GifPowerFactions").play()
	get_node("HoverSelectionFaction").texture = load("res://Image/Menu/HoverSelectionPassif.png")
	get_node("HoverSelectionFaction").position.x = 608
	get_node("HoverSelectionFaction").position.y = 167

func _on_button_pawn_button_down():
	if godNameInPowerGods in godTexts:
		var godData = godTexts[godNameInPowerGods]
		get_node("TextPowerFactions").text = godData["pawn"]
		get_node("ZoneGif/GifPowerFactions").set_animation("Pawn" + godNameInPowerGods )
		get_node("ZoneGif/GifPowerFactions").play()
	get_node("HoverSelectionFaction").texture = load("res://Image/Menu/HoverSelectionPiece.png")
	get_node("HoverSelectionFaction").position.x = -7
	get_node("HoverSelectionFaction").position.y = 281

func _on_button_knight_button_down():
	if godNameInPowerGods in godTexts:
		var godData = godTexts[godNameInPowerGods]
		get_node("TextPowerFactions").text = godData["knight"]
		get_node("ZoneGif/GifPowerFactions").set_animation("Knight" + godNameInPowerGods )
		get_node("ZoneGif/GifPowerFactions").play()
	get_node("HoverSelectionFaction").texture = load("res://Image/Menu/HoverSelectionPiece.png")
	get_node("HoverSelectionFaction").position.x = 290
	get_node("HoverSelectionFaction").position.y = 281

func _on_button_bishop_button_down():
	if godNameInPowerGods in godTexts:
		var godData = godTexts[godNameInPowerGods]
		get_node("TextPowerFactions").text = godData["bishop"]
		get_node("ZoneGif/GifPowerFactions").set_animation("Bishop" + godNameInPowerGods )
		get_node("ZoneGif/GifPowerFactions").play()
	get_node("HoverSelectionFaction").texture = load("res://Image/Menu/HoverSelectionPiece.png")
	get_node("HoverSelectionFaction").position.x = 620
	get_node("HoverSelectionFaction").position.y = 281

func _on_button_rook_button_down():
	if godNameInPowerGods in godTexts:
		var godData = godTexts[godNameInPowerGods]
		get_node("TextPowerFactions").text = godData["rook"]
		get_node("ZoneGif/GifPowerFactions").set_animation("Rook" + godNameInPowerGods )
		get_node("ZoneGif/GifPowerFactions").play()
	get_node("HoverSelectionFaction").texture = load("res://Image/Menu/HoverSelectionPiece.png")
	get_node("HoverSelectionFaction").position.x = 940
	get_node("HoverSelectionFaction").position.y = 281

func _on_button_queen_button_down():
	if godNameInPowerGods in godTexts:
		var godData = godTexts[godNameInPowerGods]
		get_node("TextPowerFactions").text = godData["queen"]
		get_node("ZoneGif/GifPowerFactions").set_animation("Queen" + godNameInPowerGods )
		get_node("ZoneGif/GifPowerFactions").play()
	get_node("HoverSelectionFaction").texture = load("res://Image/Menu/HoverSelectionPiece.png")
	get_node("HoverSelectionFaction").position.x = 1277
	get_node("HoverSelectionFaction").position.y = 281

func _on_button_king_button_down():
	if godNameInPowerGods in godTexts:
		var godData = godTexts[godNameInPowerGods]
		get_node("TextPowerFactions").text = godData["king"]
		get_node("ZoneGif/GifPowerFactions").set_animation("King" + godNameInPowerGods )
		get_node("ZoneGif/GifPowerFactions").play()
	get_node("HoverSelectionFaction").texture = load("res://Image/Menu/HoverSelectionPiece.png")
	get_node("HoverSelectionFaction").position.x = 1600
	get_node("HoverSelectionFaction").position.y = 281

func _on_zone_gif_mouse_entered():
	get_node("ZoneGif/GifPowerFactions").play()

func _on_zone_gif_mouse_exited():
	get_node("ZoneGif/GifPowerFactions").stop()
