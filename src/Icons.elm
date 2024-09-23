module Icons exposing (..)


import Svg exposing (..)
import Svg.Attributes exposing (..)

import Shared exposing (..)


dice : Int -> Int -> Svg Msg
dice size value =
    svg [ width (String.fromInt size), height (String.fromInt size), viewBox "0 0 100 100" ]
        <| (rect
            [ fill "none"
            , stroke "blue"
            , x "10"
            , y "10"
            , width "80"
            , height "80"
            , rx "10"
            , ry "10"
            ] []
        ) :: (points value)


points : Int -> List (Svg Msg)
points n =
    case n of
        1 -> [ point 50 50 ]
        2 -> [ point 30 30, point 70 70 ]
        3 -> (points 1) ++ (points 2)
        4 -> (points 2) ++ [ point 30 70, point 70 30 ]
        5 -> [ point 50 50, point 30 30, point 70 70, point 30 70, point 70 30 ]
        6 -> [ point 30 30, point 70 70, point 30 70, point 70 30, point 30 50, point 70 50 ]
        _ -> []

point : Int -> Int -> Svg Msg
point x y =
    circle [ cx (String.fromInt x), cy (String.fromInt y), r "10", fill "blue", stroke "none" ] []
