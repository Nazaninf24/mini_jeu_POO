require 'pry'

class Player

	attr_accessor :name, :life_points

	def initialize(get_name)
	  @name = get_name
	  @life_points = 10
	end

	def show_state
	  if @life_points <= 0 #on met un if pour le cas de figure ou un joueur meurt
	    return "#{@name} a 0 point de vie"
	  else
	    return "#{@name} a #{@life_points} points de vie"
	  end
	end

	def gets_damage (damage)
	  @life_points -= damage
	  return "le joueur #{@name} a été tué !" if @life_points <= 0	
	end

    def attacks(ennemy_name)
      puts "Le joueur #{@name} attaque le joueur #{ennemy_name.name}"
      damages = compute_damage
      puts "Il lui inflige #{damages} points de vie"
      ennemy_name.gets_damage(damages)
    end

	def compute_damage #choisit un chiffre aléatoirement entre 1 & 6
      return rand(1..6)
	end	
end



class HumanPlayer < Player #heritage de la class Player

	attr_accessor :weapon_level, :search_health_pack

	def initialize(get_name)
		@weapon_level = 1
		@life_points = 100
		@name = get_name #on pourrait utiliser le super mais comme une seule variable c'est aussi rapide
	end

	def show_state
		if @life_points <= 0
		    return "#{@name} a 0 point de vie"
		else
		  return "#{@name} a #{@life_points} points de vie et possède une arme de niveau #{@weapon_level}\n \n"
		end
	end

	def compute_damage
      return rand(1..6) * @weapon_level
    end

    def search_weapon
    weapon_strength = rand(1..6)
    puts "tu as trouvé une arme de niveau : #{weapon_strength}"

      if weapon_strength > @weapon_level
      	@weapon_level = weapon_strength
      	puts "Youhou! elle est meilleure que ton arme actuelle: tu la prends."
      else
        puts "Garde ton arme, elle est meilleure!"
	  end
    end

    def search_health_pack
	heatlh_pack = rand(1..6)
	
      if heatlh_pack == 1
      	puts "Tu n'as rien trouvé..."
	  elsif heatlh_pack.between?(2, 5) #si le dés arrive sur un chiffre entre 2 et 5 compris
		
		puts "Bravo, tu as trouvé un pack de +50 points de vie!"  
        if @life_points + 50 > 100 #condition pour ne pas dépasser les 100 points de vie
      		return @life_points = 100
      	else
      		return @life_points + 50  
      	end

      elsif heatlh_pack == 6
		puts "Waow, tu as trouvé un pack de +80 points de vie!"
	    if @life_points + 80 > 100
      		return @life_points = 100
      	else
      		return @life_points + 80  
      	end      	
      end
    end
end