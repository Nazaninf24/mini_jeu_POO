require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# binding.pry #est là pour permettre de faire des tests. Tout ce qui vas être coder dans player.rb, on peut le tester dans le terminal (avec PRY) en exécutant directement ruby app_2.rb


puts "------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------" 

enemies = Array.new #initialisaion du array des ennemies
player2 = Player.new("Josiane") #initialisation des ennemies
player3 = Player.new("José")
enemies.append(player2, player3) #on met les ennemies dans le array

puts "Comment te prénommes-tu ?"
name = gets.chomp
player1 = HumanPlayer.new(name) #initialisation du joueur
puts player1.show_state

puts "Deux ennemies rentrent dans la course : #{player2.name} et #{player3.name}" #on présente au joueur les méchants
puts "----------------------------"


while player1.life_points > 0 && (player2.life_points > 0 || player3.life_points > 0) #début de la boucle
	puts "Voici l'état de chaque joueur"
	puts player1.show_state
	puts "---------------------------------"
	puts "Quelle action veux-tu effectuer ?

a - chercher une meilleure arme
s - chercher à se soigner 

attaquer un joueur en vue :
0 - Josiane a #{player2.life_points} points de vie
1 - José a #{player3.life_points} points de vie \n\n"

	choice = gets.chomp #début du très joli menu
	case choice
	when "a" 
		player1.search_weapon
	when "s" 
		player1.search_health_pack
	when "0"
		player1.attacks(player2)
	when "1"
		player1.attacks(player3)
	else
		puts "valeur non valide"
	end
	puts "----------------------------- \n\n"


	enemies.each do |player| #debut de la boucle pour des ennemis de riposter
		if player.life_points > 0
		  puts "Les autres joueurs t'attaquent!" 
		  player.attacks(player1)
		end
	end
end

puts  "La partie est finie"

if player1.life_points == 0 #fin du jeu, très difficile de perdre par contre
	puts "Loser ! Tu as perdu !!"
else
	puts "BRAVO ! TU AS GAGNE !!"
end