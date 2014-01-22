#Comments for grading purposes
# => Instance Variables are used to store health
# => A function is used to move the player

class Player

  # Sets parameters for which to call retreat with
  @@retreatHealthThreshold = 9
  @@healedHealthThreshold = 18
  @@minumumArcherChallengeThreshold = 4
  @@firstTime = :true

  def play_turn(warrior)

    set_health_information(warrior)

    if (@@firstTime == :true)
      @@firstTime = :false
      @retreat = :false
      @direction = :forward
      # pivot_direction(warrior)
      @wizard = :false
      @archer = :false
      @actionTaken = :false
  
    end

    if (warrior.health > @@minumumArcherChallengeThreshold)
      check_for_ranged(warrior)
    end

    if (@actionTaken == :true)
      @actionTaken = :false
      return
    elsif (@currentHealth <= @@retreatHealthThreshold or @retreat == :true)
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

    if (warrior.look(@direction)[0].to_s == "Archer" && warrior.health > @@minumumArcherChallengeThreshold)
      warrior.attack! (@direction)
      return
    end

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


  def check_for_ranged(warrior)
    for item in warrior.look (@direction)
      if (item.to_s == "nothing")
        next
      elsif (item.to_s == "Wizard")
        @wizard = :true
        return
      elsif (item.to_s == "Archer")
        @archer = :true
        return
      else
        break
      end
    end

    toggle_direction()

    for item in warrior.look (@direction)
      if (item.to_s == "nothing")
        next
      elsif (item.to_s == "Wizard")
        @wizard = :true
        toggle_direction()
        pivot_direction(warrior)
        @actionTaken = :true;
        return
      elsif (item.to_s == "Archer")
        @archer = :true
        toggle_direction()
        pivot_direction(warrior)
        @actionTaken = :true;
        return
      else
        toggle_direction()
        return
      end
    end

    toggle_direction()

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
    end

    # Set current health
    @currentHealth = warrior.health
  end



end
