#Comments for grading purposes
# => Instance Variables are used to store health and direction info, as well as store several states
# => Class variables are used to set constants for certain items, seen below
# => Fucntions are used below to modularize the play turn function

class Player

  # Sets parameters for which to call retreat with
  RETREAT_HEALTH_THRESHOLD = 9
  @@healedHealthThreshold = 18

  # If health is below this, don't touch the archer
  @@minumumArcherChallengeThreshold = 4

  # Sets a flag for intial setup
  @@firstTime = :true

  def play_turn(warrior)

    set_health_information(warrior)

    # Initial setup
    if (@@firstTime == :true)
      @@firstTime = :false
      @retreat = :false
      @direction = :forward
      @wizard = :false
      @archer = :false
      @actionTaken = :false
    end

    #If we are in a condition to check for range, check for it
    if (warrior.health > @@minumumArcherChallengeThreshold)
      check_for_ranged(warrior)
    end

    # If we've already acted, stop
    if (@actionTaken == :true)
      @actionTaken = :false
      return

    # If we need to retreat, then do it!
    elsif (@currentHealth <= RETREAT_HEALTH_THRESHOLD or @retreat == :true)
      retreat(warrior)

    # Otherwise, let's try to move
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

  # Switches direction with a pivot
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

    # If we are near an archer and are in a condition to fight it, then do that first
    if (warrior.look(@direction)[0].to_s == "Archer" && warrior.health > @@minumumArcherChallengeThreshold)
      warrior.attack! (@direction)
      return
    end

    # Set the flag for a new retreat and turn around
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


  # Check for ranged units in front of and behind you
  def check_for_ranged(warrior)

    #Check in front
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

    # Check behind
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

  # Move the warrior
  def move(warrior)

    # If there is a qizard, then shoot it please
    if @wizard == :true
      @wizard = :falst
      warrior.shoot! (@direction)

    #Empty in front? Walk
    elsif (warrior.feel(@direction).empty?)
      warrior.walk! (@direction)

    # Save the captive, save the world
    elsif warrior.feel(@direction).captive? 
      warrior.rescue! (@direction)

    # Hit a wall? Then turn around
    elsif warrior.feel(@direction).wall?
      pivot_direction(warrior)

    # Better attack!
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
