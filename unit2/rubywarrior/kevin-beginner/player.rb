#Comments for grading purposes
# => Instance Variables are used to store health
# => A function is used to move the player

class Player
  
  #attr_accessor :currentHealth, :previousHealth, :hasTouchedBackWall, :@direction

  # Sets parameters for which to call retreat with
  @@retreatHealthThreshold = 7
  @@healedHealthThreshold = 17

  def play_turn(warrior)

    set_health_information(warrior)

    check_for_wizards(warrior)
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

  def pivot_direction(warrior)
    if @direction == :backward
      @direction = :forward
      warrior.pivot! (:forward)
    elsif @direction == :forward
      @direction = :backward
      warrior.pivot!
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


  def check_for_wizards(warrior)




    for item in warrior.look (@direction)
      if (item.to_s == "nothing")
        next
      elsif (item.to_s == "Wizard")
        @wizard = :true
        break
      else
        break
      end
    end
  end

  def move(warrior)

    if @wizard == :true
      @wizard = :falst
      warrior.shoot! (@direction)
    elsif (warrior.feel(@direction).empty?)
      warrior.walk! (@direction)
    elsif warrior.feel(@direction).captive? 
      warrior.rescue! (@direction)
    elsif warrior.feel(@direction).wall?
      pivot_direction(warrior)
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
      @direction = :forward
      @wizard = :false
    end

    # Set current health
    @currentHealth = warrior.health
  end



end
