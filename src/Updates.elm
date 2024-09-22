module Updates exposing (update)

import Shared exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        AddPlayer -> ({model | players = (List.append model.players [model.playerName])}, Cmd.none)
        RemovePlayer name -> ({model | players = (List.filter (\n -> n /= name) model.players)}, Cmd.none)
        PlayerChanged name -> ({model | playerName = name }, Cmd.none)
        GameTypeChanged newType -> ({model | gameType = newType}, Cmd.none)
        GameRulesChanged newRules -> ({model | gameRules = newRules}, Cmd.none)
        StartGame -> ({model | screen = Game }, Cmd.none)
