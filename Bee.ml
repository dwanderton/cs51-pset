open WorldObject
open WorldObjectI
open Ageable


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
class type bee_t =
object 
  inherit Ageable.ageable_t

  method private next_direction_default : Direction.direction option 
end 
class bee p (home:world_object_i): bee_t = object(self)
  inherit CarbonBased.carbon_based p bee_inverse_speed (World.rand bee_lifetime) bee_lifetime

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)
  val mutable pollenlst = []

  (* ### TODO: Part 5 Smart Bees ### *)

  val sensing_range = World.rand max_sensing_range
  
  val pollen_types = World.rand max_pollen_types + 1

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
     pollenlst <- ((neighbor:>WorldObjectI.world_object_i)#receive_pollen pollenlst)

  method private extract_pollen neighbor = 
    match (neighbor:>WorldObjectI.world_object_i)#forfeit_pollen with
    | None -> ()
    | Some pollen_id -> (pollenlst <- (pollen_id::pollenlst))   
 
  (* ### TODO: Part 5 Smart Bees ### *)

  method private magnet_flower : world_object_i option = 
    let inrangelst = World.objects_within_range self#get_pos sensing_range in
      let rec intersect lst1 lst2 =
        match lst1 with
        | [] -> []
        | h::t -> if (List.exists (fun x -> 
                                     match (h#smells_like_pollen) with
                                     | None -> false
                                     | Some pollID -> (pollID =x)) lst2) then h::(intersect t lst2)
                 else (intersect t lst2) in
      let intersectlst = (intersect inrangelst pollenlst) in
        match intersectlst with
        | [] -> None 
        | h::t -> let closestObj = (List.fold_right (fun x y -> if ((Direction.distance self#get_pos x#get_pos) < 
      (Direction.distance self#get_pos y#get_pos)) then x 
                                                 else  y) (intersect inrangelst pollenlst) h) in Some closestObj 
   

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 1 Basic ### *)

  method get_name = "bee"

  (* ### TODO: Part 4 Aging ### *)
  method draw_picture = Draw.circle self#get_pos World.obj_width World.obj_height Graphics.yellow Graphics.black (string_of_int (List.length pollenlst))

  method draw_z_axis = 2


  (* ### TODO: Part 3 Actions ### *)

  method private do_action = 
    (*let deposit_extract_pollen obj = 
     (self#deposit_pollen obj;self#extract_pollen obj) in*)
     (fun _ -> let neighbors = World.get (self#get_pos) in List.iter (self#deposit_pollen;self#extract_pollen) neighbors)  
 
   

  (***************************)
  (***** Movable Methods *****)
  (***************************)

  (* ### TODO: Part 2 Movement ### *)

  method private next_direction = 
    if (List.length (Helpers.unique pollenlst) > pollen_types) then 
      World.direction_from_to self#get_pos home#get_pos
    else match self#magnet_flower with
         | None -> self#next_direction_default
         | Some fl -> World.direction_from_to self#get_pos fl#get_pos


  (* ### TODO: Part 5 Smart Bees ### *)

  (* ### TODO: Part 6 Custom Events ### *)

  (***********************)
  (***** Bee Methods *****)
  (***********************)

  (* ### TODO: Part 5 Smart Bees ### *)

  method private next_direction_default = None

end

