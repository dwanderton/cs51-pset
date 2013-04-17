open WorldObject
open WorldObjectI


(* ### Part 2 Movement ### *)
let bee_inverse_speed = Some 1

(* ### Part 3 Actions ### *)
let max_pollen_types = 5

(* ### Part 4 Aging ### *)
let bee_lifetime = 1000

(* ### Part 5 Smart Bees ### *)
let max_sensing_range = 5

(** Bees travel the world searching for honey.  They are able to sense flowers
    within close range, and they will return to the hive once they have
    pollenated enough species of flowers. *)
class bee p: Movable.movable_t =
object (self)
  inherit (Movable.movable p bee_inverse_speed)
  

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)
  val mutable pollenlst = []

  (* ### TODO: Part 5 Smart Bees ### *)

  (* ### TODO: Part 6 Custom Events ### *)

  (***********************)
  (***** Initializer *****)
  (***********************)

  (* ### TODO: Part 3 Actions ### *)
  initializer 
  self#register_handler World.action_event self#do_action

  (* ### TODO: Part 6 Custom Events ### *)

  (**************************)
  (***** Event Handlers *****)
  (**************************)

  (* ### TODO: Part 6 Custom Events ### *)

  (**************************)
  (***** Helper Methods *****)
  (**************************)

  (* ### TODO: Part 3 Actions ### *)
  method private deposit_pollen neighbor =
     pollenlst <- (neighbor#receive_pollen pollenlst)


  method private extract_pollen neighbor = 
    match neighbor#forfeit_pollen with
    | None -> ()
    | Some pollen_id -> (pollenlst <- (pollen_id::pollenlst))   
 
  (* ### TODO: Part 5 Smart Bees ### *)

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 1 Basic ### *)

  method get_name = "bee"

  (* ### TODO: Part 4 Aging ### *)
  method draw = Draw.circle self#get_pos World.obj_width World.obj_height Graphics.yellow Graphics.black (string_of_int (List.length pollenlst))

  method draw_z_axis = 2


  (* ### TODO: Part 3 Actions ### *)

  method private do_action = 
    let deposit_extract_pollen obj = 
     (self#deposit_pollen obj;self#extract_pollen obj) in
    let neighbors = World.get (self#get_pos) in
     (fun _ -> List.iter  (deposit_extract_pollen) neighbors) 
 
   

  (***************************)
  (***** Movable Methods *****)
  (***************************)

  (* ### TODO: Part 2 Movement ### *)

  method next_direction = 
      Some (Direction.random World.rand)


  (* ### TODO: Part 5 Smart Bees ### *)

  (* ### TODO: Part 6 Custom Events ### *)

  (***********************)
  (***** Bee Methods *****)
  (***********************)

  (* ### TODO: Part 5 Smart Bees ### *)

end

