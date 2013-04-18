open WorldObject
open WorldObjectI

(* ### Part 3 Actions ### *)
let starting_pollen = 500
let cost_of_bee = 10
let spawn_probability = 20
let pollen_probability = 50
let max_pollen_deposit = 3

(** A hive will spawn bees and serve as a deposit point for the pollen that bees
    harvest.  It is possible to steal honey from a hive, however the hive will
    signal that it is in danger and its loyal bees will become angry. *)
class hive p : 
object
  inherit world_object_i
  method forfeit_honey : int -> world_object_i -> int
end =
object (self)
inherit world_object p as super

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)
    
  val mutable pollen_amt = max_pollen_deposit 

  (* ### TODO: Part 6 Custom Events ### *)

  (***********************)
  (***** Initializer *****)
  (***********************)

  (* ### TODO: Part 3 Actions ### *)

  initializer
    self#register_handler World.action_event self#do_action

  (**************************)
  (***** Event Handlers *****)
  (**************************)

  (* ### TODO: Part 3 Actions ### *)

  method private do_action = 
    fun _ -> (Helpers.with_inv_probability World.rand pollen_probability (fun _ -> (pollen_amt <- (pollen_amt + 1))))

  (* ### TODO: Part 4 Aging ### *)

  (**************************)
  (***** Helper Methods *****)
  (**************************)

  (* ### TODO: Part 4 Aging ### *)

  (* ### TODO: Part 5 Smart Bees ### *)

  (****************************)
  (*** WorldObjectI Methods ***)
  (****************************)

  (* ### TODO: Part 1 Basic ### *)

  method get_name = "hive"

  method draw = Draw.circle p World.obj_width World.obj_height Graphics.cyan Graphics.black (string_of_int (pollen_amt))

  method draw_z_axis = 1


  (* ### TODO: Part 3 Actions ### *)

  method receive_pollen pollen_lst = 
   if ((List.length pollen_lst) <= max_pollen_deposit) then let _ = (pollen_amt <- pollen_amt + List.length pollen_lst) in []     
     else let _ = (pollen_amt <- pollen_amt + List.length pollen_lst) in []

  method forfeit_honey n obj =
    let _ = self#danger in
    if n <= pollen_amt then
      let _ = pollen_amt <- (pollen_amt - n) in n
    else 
      let old_pollen = pollen_amt in 
      let _ = (pollen_amt <- 0) in old_pollen

  (* ### TODO: Part 6 Custom Events ### *)

  (************************)
  (***** Hive Methods *****)
  (************************)

  (* ### TODO: Part 3 Actions ### *)


  (* ### TODO: Part 6 Custom Events ### *)

end
