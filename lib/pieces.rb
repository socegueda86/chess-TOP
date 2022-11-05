class Pieces 

    
  def icon_define
        
    case self
    when Pawn
      @color == 'white'? '♟︎' : '♙'
    when King
      @color == 'white'? '♚' : '♔'
    when Queen
      @color == 'white'? '♛' : '♕'
    when Bishop
      @color == 'white'? '♝' : '♗'
    when Tower
      @color == 'white'? '♜' : '♖'
    when Knight
      @color == 'white'? '♞' : '♘'
    else
      'E'
    end
  end
  
end

class King < Pieces
  
  def initialize(game, color, piece_position)
    @game = game
    @color = color
    @icon = icon_define
    @piece_position
  end
  
  def to_s
    @icon 
  end
end

class Queen < Pieces
  
  def initialize(game, color, piece_position)
    @game = game
    @color = color
    @icon = icon_define
    @piece_position
  end

  def to_s
    @icon 
  end
end

class Knight < Pieces
  
  def initialize(game, color, piece_position)
    @game = game
    @color = color
    @icon = icon_define
    @piece_position
  end

  def to_s
    @icon 
  end
end


class Pawn < Pieces
  
  def initialize(game, color, piece_position)
    @game = game
    @color = color
    @icon = icon_define
    @piece_position
  end

  def to_s
    @icon 
  end
end

class Bishop < Pieces
  
  def initialize(game, color, piece_position)
    @game = game
    @color = color
    @icon = icon_define
    @piece_position
  end

  def to_s
    @icon 
  end
end

class Tower < Pieces
  
  def initialize(game, color, piece_position)
    @game = game
    @color = color
    @icon = icon_define
    @piece_position
  end

  def to_s
    @icon 
  end
end

