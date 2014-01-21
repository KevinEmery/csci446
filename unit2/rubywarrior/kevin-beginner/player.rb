class Player
  def play_turn(warrior)

    # If the space in front of the warrior is empty, walk forward
    if warrior.feel.empty?
      warrior.walk!

    #Otherwise, we should attack!
    else
      warrior.attack!

    end
  end
end
