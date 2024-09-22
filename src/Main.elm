module Main exposing (main)


import Browser

import Shared exposing (..)
import Views exposing (view)
import Updates exposing (update)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : () -> (Model, Cmd Msg)
init _ =
    (initModel, Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none
