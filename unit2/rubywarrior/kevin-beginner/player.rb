#Comments for grading purposes
# => Instance Variables are used to store health
# => A function is used to move the player

class Player
  
  #attr_accessor :currentHealth, :previousHealth, :hasTouchedBackWall, :@direction

  # Sets parameters for which to call retreat with
  @@retreatHealthThreshold = 9
  @@healedHealthThreshold = 17

  def play_turn(warrior)

    set_health_information(warrior)

    if (@currentHealth <= @@retreatHealthThreshold or @retreat == :true)
      retreat(warrior)
    else
      move(warrior)
    end
  end



  # Toggles the player's direction between forward and backward
  def toggle_direction()

    if @direction == :backward
      @direction = :forward
    elsif @direction == :forward
      @direction = :backward

    end
  end

  # Creates a defined retreat behavior for the warrior
  def retreat(warrior)

    if (@retreat == :false) 
      toggle_direction()
      @retreat = :true
    end
  

    # If there is nothing in front of you and you were attacked last turn, walk
    if (warrior.feel(@direction).empty? and @currentHealth < @previousHealth)
      warrior.walk! (@direction)

    # This means something is in front of you (hopefully a wall?) or you were not attacked
    # Time to rest as needed
    elsif (@currentHealth <= @@healedHealthThreshold)
      warrior.rest!

    # This means you're all healed up and ready to go
    # Toggle direction, unset the retreat flag, and get moving!
    else
      toggle_direction()
      @retreat = :false
      move(warrior)
    end
  end


  # NEED TO REWRITE MOVE TO ACCOUNT FOR NEW LOGIC IN USE

  def move(warrior)
    # This checks to ensure that the space in front of us is empty, and 
    # to make sure we are not being attacked.
    if (warrior.feel(@direction).empty?)
      warrior.walk! (@direction)

    # If we get to here, either we are not empty in front of us or are being attacked, 
    # and we need to attack
    elsif warrior.feel(@direction).captive? 
      warrior.rescue! (@direction)
    elsif warrior.feel(@direction).wall?
      toggle_direction()
      warrior.walk! (@direction)
    else
      warrior.attack! (@direction)
          
    end
  end

  # Sets the health information for the player
  def set_health_information(warrior)

    # In the first iteration, we need some way to set previous health.
    # because currentHealth isn't set yet.
    if @currentHealth != nil
      @previousHealth = @currentHealth
    else
      @previousHealth = warrior.health
      @retreat = :false
      @direction = :backward
    end

    # Set current health
    @currentHealth = warrior.health
  end



end
