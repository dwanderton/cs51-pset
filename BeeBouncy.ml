open WorldObject
open WorldObjectI
open World

(** Bouncy bees will travel in a straight line in a random direction until an
    obstacle or edge of the world is reached, at which point a new random
    direction will be chosen. *)
class bee_bouncy p hive : Bee.bee_t =
object (self)
  inherit Bee.bee p hive as super

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 5 Smart Bees *)

  val mutable direction_curr = Direction.random World.rand

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)



  (* ### TODO: Part 5 Smart Bees *)

  (***********************)
  (***** Bee Methods *****)
  (***********************)

  (* ### TODO: Part 5 Smart Bees *)

  method private next_direction_default = 
    (if (World.can_move (Direction.move_point self#get_pos (Some direction_curr))) then () 
    else direction_curr <- Direction.random World.rand); (Some direction_curr)
      

end


