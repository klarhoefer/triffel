module Shared exposing (..)


type alias Model =
    { screen : Screen
    , gameType : GameType
    , gameRules : GameRules
    , players : List String
    , playerName : String
    }


initModel : Model
initModel =
    { screen = Start
    , gameType = Seven
    , gameRules = Triffel
    , players = []
    , playerName = ""
    }


type GameType
    = Classic
    | Seven


type GameRules
    = Single
    | Triffel


type Msg
    = AddPlayer
    | RemovePlayer String
    | PlayerChanged String
    | GameTypeChanged GameType
    | GameRulesChanged GameRules
    | StartGame


type Screen
    = Start
    | Game
