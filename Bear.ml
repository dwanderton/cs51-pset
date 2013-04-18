open WorldObject
open WorldObjectI
open Direction

(* ### Part 3 Actions ### *)
let pollen_theft_amount = 1000

(* ### Part 4 Aging ### *)
let bear_starting_life = 20

(* ### Part 2 Movement ### *)
let bear_inverse_speed = Some 10

class bear p hive cave : Movable.movable_t =
  object (self)
    inherit Movable.movable p bear_inverse_speed as super

  (******************************)
  (***** Instance Variables *****)
  (******************************)


  (* ### TODO: Part 3 Actions ### *)

    val mutable stolen_amt = 0
    val mutable honey_amt = 0

  (* ### TODO: Part 6 Events ### *)

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
      if (self#get_pos = hive#get_pos) then
        fun _ -> (stolen_amt <- (stolen_amt + hive#forfeit_honey pollen_theft_amount (self :> world_object_i)))
      else
        fun _ -> ()

  (* ### TODO: Part 6 Custom Events ### *)

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 1 Basic ### *)

  method get_name = "bear"

  method draw = Draw.circle self#get_pos World.obj_width World.obj_height (Graphics.rgb 170 130 110) Graphics.black (string_of_int (stolen_amt))

  method draw_z_axis = 3


  (* ### TODO: Part 3 Actions ### *)

    

  (* ### TODO: Part 6 Custom Events ### *)

  (***************************)
  (***** Movable Methods *****)
  (***************************)

  (* ### TODO: Part 2 Movement ### *)

  method next_direction = (Direction.natural (self#get_pos) (hive#get_pos))


  (* ### TODO: Part 6 Custom Events ### *)

end
