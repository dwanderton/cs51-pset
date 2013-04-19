 open Helpers
open WorldObject
open WorldObjectI
open Event

(** Class type for objects which constantly try to move in a calculated next
    direction. *)
class type movable_t =
object
  inherit world_object_i

  (** The next direction for which this object should move. *)
  method next_direction : Direction.direction option
end

class movable p (inv_speed:int option) : movable_t =
object (self)
  inherit world_object p as super

  initializer 
      match inv_speed with
      | None -> ()
      | Some s -> self#register_handler (Event.buffer s World.move_event) (fun _ -> self#do_move)
     method private do_move = self#move self#next_direction  

  

  (* ### TODO: Part 2 Movement ### *)

  (**************************)
  (***** Event Handlers *****)
  (**************************)    

  (* ### TODO: Part 2 Movement ### *)



  (* ### TODO: Part 2 Movement ### *)
  method next_direction = raise TODO

end
