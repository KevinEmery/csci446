class Player
  
  attr_accessor :currentHealth

  def play_turn(warrior)

    @currentHealth = warrior.health

    # If the space in front of the warrior is empty, then we don't have an enemy
    if warrior.feel.empty?

      # If the health is <= 6, then we will die in the next sludge fight. Better recover!
      if @currentHealth <= 6
        warrior.rest!

      # We're fine, walk!
      else
        warrior.walk!

      end

    #Otherwise, we should attack!
    else
      warrior.attack!

    end
  end
end
