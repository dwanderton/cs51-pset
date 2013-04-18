open WorldObject
open WorldObjectI
open Helpers

(* ### Part 2 Movement ### *)
let cow_inverse_speed = Some 1

(* ### Part 6 Custom Events ### *)
let max_consumed_objects = 100

(** Cows will graze across the field until it has consumed a satisfactory number
    of flowers *)
class cow p hive: Movable.movable_t =
object (self)
  inherit Movable.movable p cow_inverse_speed as super

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)

  val mutable eaten_amt = 0

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

  (*let eat_obj obj = 
    match obj#smells_like_pollen with
    | None -> ()
    | Some _ -> (obj#die; (eaten_amt <- eaten_amt + 1); print_string ("nom "))*)

  method private do_action = 
    let eat_obj obj = 
      match obj#smells_like_pollen with
      | None -> ()
      | Some _ -> (obj#die; (eaten_amt <- eaten_amt + 1); print_string ("nom ")) in
    (fun _ -> let neighbors = World.get self#get_pos in 
    List.iter eat_obj neighbors)

  (* ### TODO: Part 6 Custom Events ### *)

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 1 Basic ### *)

  method get_name = "cow"

  method draw = Draw.circle self#get_pos World.obj_width World.obj_height (Graphics.rgb 180 140 255) Graphics.black (string_of_int eaten_amt)

  method draw_z_axis = 4


  (* ### TODO: Part 3 Actions ### *)

  (***************************)
  (***** Movable Methods *****)
  (***************************)

  (* ### TODO: Part 2 Movement ### *)

  method next_direction = Helpers.with_inv_probability_or (World.rand) (World.size/2) 
  (fun () -> Direction.natural (self#get_pos) (hive#get_pos)) (fun () -> Some (Direction.random (World.rand)))


  (* ### TODO: Part 6 Custom Events ### *)

end
