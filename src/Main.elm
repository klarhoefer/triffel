module Main exposing (main)


import Browser

import Shared exposing (..)
import Views exposing (view)


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


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        AddPlayer -> ({model | players = (List.append model.players [model.playerName])}, Cmd.none)
        RemovePlayer name -> ({model | players = (List.filter (\n -> n /= name) model.players)}, Cmd.none)
        PlayerChanged name -> ({model | playerName = name }, Cmd.none)
        GameTypeChanged newType -> ({model | gameType = newType}, Cmd.none)
        GameRulesChanged newRules -> ({model | gameRules = newRules}, Cmd.none)
        StartGame -> ({model | screen = Game }, Cmd.none)
