#Comments for grading purposes
# => Instance Variables are used to store health

class Player
  
  attr_accessor :currentHealth, :previousHealth

  def play_turn(warrior)

    # In the first iteration, we need some way to set previous health
    if @currentHealth != nil
      @previousHealth = @currentHealth
    else
      @previousHealth = warrior.health
    end

    # Set current health
    @currentHealth = warrior.health

    # This checks to ensure that the space in front of us is empty, and 
    # to make sure we are not being attacked.
    if (warrior.feel.empty? and (@currentHealth >= @previousHealth))

      # If the health is <= 6, then we will die in the next sludge fight. Better recover!
      # The lower we can push this number, the higher the scores will be
      if @currentHealth <= 12
        warrior.rest!

      # We're fine, walk!
      else
        warrior.walk!

      end

    # If we get to here, either we are not empty in front of us or are being attacked, 
    # and we need to attack
    else
      if warrior.feel.empty?
        warrior.walk!
      else
        if warrior.feel.captive?
          warrior.rescue!
        else
          warrior.attack!
        end
      end
    end
  end
end
