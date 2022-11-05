

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