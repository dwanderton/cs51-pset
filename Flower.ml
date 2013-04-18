open WorldObject
open WorldObjectI
open Helpers

(* ### Part 3 Actions ### *)
let next_pollen_id = ref 0
let get_next_pollen_id () =
  let p = !next_pollen_id in incr next_pollen_id ; p

(* ### Part 3 Actions ### *)
let max_pollen = 5
let produce_pollen_probability = 50
let bloom_probability = 4000
let forfeit_pollen_probability = 3

(* ### Part 4 Aging ### *)
let flower_lifetime = 2000

(** Flowers produce pollen.  They will also eventually die if they are not cross
    pollenated. *)
class flower p (pollen_id: int) : world_object_i =
object (self)
  inherit world_object p as super

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)

  val mutable pollen_amt = World.rand max_pollen 

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

  method private produce_pollen = 
   fun _ ->
   (if pollen_amt <= max_pollen then
       Helpers.with_inv_probability World.rand produce_pollen_probability (fun _ -> (pollen_amt <- (pollen_amt + 1)))
   else ())

  method private bloom = 
    (fun _ -> Helpers.with_inv_probability World.rand bloom_probability (fun _ -> (World.spawn 1 p (fun p -> ignore (new flower p pollen_id)))))

  method private do_action = 
     (self#bloom;
     self#produce_pollen)


  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 1 Basic ### *)

  method get_name = "flower"

  (* ### TODO: Part 4 Aging ### *)
  method draw = Draw.circle self#get_pos World.obj_width World.obj_height (Graphics.rgb 255 150 255) Graphics.black (string_of_int pollen_amt) 

  method draw_z_axis = 1

  method smells_like_pollen = 
    if pollen_amt <= 0 then None
    else Some pollen_id


  method forfeit_pollen = 
      if pollen_amt <= 0 then None 
      else 
        let _ = Helpers.with_inv_probability (World.rand) forfeit_pollen_probability 
                (fun _ -> pollen_amt <- (pollen_amt -1)) in self#smells_like_pollen 

  (* ### TODO: Part 3 Actions ### *)


  (***************************)
  (***** Ageable Methods *****)
  (***************************)

  (* ### TODO: Part 4 Aging ### *)

end
