extends Sprite2D
var counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if counter == 0 :
		get_node("RuleTitleLabel").text = "Comment jouer à GodsChess ?"
		get_node("RuleExplanationText").text = "GodsChess conserve les règles classiques des échecs tout en y incorporant des pouvoirs, sans détruire ce qui a été construit.
Au contraire, il apporte une nouvelle dimension avec la division des pièces en factions et un niveau stratégique accru grâce à l'ajout de pouvoirs se jouant de manière passive. Vous devez toujours mettre en échec et mat le roi adverse pour gagner.
Cependant, l'inventivité, l'imagination et la créativité vous permettront de développer votre propre façon de jouer à GodsChess"
		get_node("RuleSpriteExplanation").texture = null
	
	if counter == 1 :
		get_node("RuleTitleLabel").text = "L’auto Echec"
		get_node("RuleExplanationText").text = "Si le joueur en jouant créer une situation d’échec sur son propre roi alors que le prochain tour est celui de l’adversaire. Il se met lui-même en auto-échec et perd le match. 
Ici, sur l'image, le joueur ne déplace pas sa Reine du Feu. C'est au tour de l'autre joueur qui convertit la Reine du Feu en Reine de la Secte, laquelle peut donc attaquer directement le Roi du Feu"
		get_node("RuleSpriteExplanation").texture = preload("res://Image/Tutoriel/AutoEchec.png")
	
	if counter == 2 :
		get_node("RuleTitleLabel").text = "Limite du terrain"
		get_node("RuleExplanationText").text = "Les pouvoirs qui sont susceptibles de faire sortir les pièces en dehors du terrain par quelconque moyen ne peuvent se faire que par la limite droite et gauche du terrain. Les limites haut et bas ne sont pas impacter par les pouvoirs, les pièces resteront bloquer à la limite du terrain."
		get_node("RuleSpriteExplanation").texture = preload("res://Image/Tutoriel/RégleLimiteDuTerrain.png")
	
	if counter == 3 :
		get_node("RuleTitleLabel").text = "Annulation d’un effet"
		get_node("RuleExplanationText").text = "Si une pièce est tuée par un effet d’un pouvoir ou mit hors zone (hors du plateau d’échec) alors l’activation de l’effet du pouvoir de cette pièce est annulée.

Sur la première image, le pion magnétique prend le pion de glace en a5, activant le pouvoir du pion de glace.
 
Sur la deuxième image, le cavalier magnétique se déplace en b5, poussant le pion de glace hors du terrain. Dans ce cas, le pouvoir ne s'active pas"
		get_node("RuleSpriteExplanation").texture = preload("res://Image/Tutoriel/EffetAnnulé.png")
	
	if counter == 4 :
		get_node("RuleTitleLabel").text = "Mouvement du cavalier"
		get_node("RuleExplanationText").text = "Pour éviter l’ambiguïté du déplacement du cavalier pour l’utilisation d’un pouvoir. Le cavalier se déplace sur le plateau de la manière suivante, deux cases dans la même direction (haut, bas, gauche, droite) puis une case latérale (haut, bas, gauche, droite)."
		get_node("RuleSpriteExplanation").texture = preload("res://Image/Tutoriel/RégleMouvementCavalier.png")
	
	if counter == 5 :
		get_node("RuleTitleLabel").text = "Pas d’effet contre le roi"
		get_node("RuleExplanationText").text = "Le roi est invulnérable à tout type d’effet présent dans le jeu."
		get_node("RuleSpriteExplanation").texture = preload("res://Image/Tutoriel/EffetRoi.png")
	
	if counter == 6 :
		get_node("RuleTitleLabel").text = "Echelle de force de GodChess"
		get_node("RuleExplanationText").text = "Faction Pion < Faction Cavalier < Faction Fou < Faction Tour < Faction Reine < Faction Roi"
		get_node("RuleSpriteExplanation").texture = preload("res://Image/Tutoriel/RégleEchelleDeForceFactionDessin.png")
	
	

	if counter > 6 :
		counter = 0
	elif counter < 0:
		counter = 6

func _on_button_rigth_button_down():
	counter += 1
	
func _on_button_left_button_down():
	counter -= 1
	
func _on_button_return_main_menu_button_down():
	self.hide()
	get_node("/root/Menu/Background/PlayScreen").show()
