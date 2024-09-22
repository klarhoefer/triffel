module Main exposing (main)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { screen : Screen
    , gameType : GameType
    , gameRules : GameRules
    , players : List String
    , playerName : String
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
    (Model Start Seven Triffel [] "", Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions model = Sub.none


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        AddPlayer -> ({model | players = (List.append model.players [model.playerName])}, Cmd.none)
        RemovePlayer name -> ({model | players = (List.filter (\n -> n /= name) model.players)}, Cmd.none)
        PlayerChanged name -> ({model | playerName = name }, Cmd.none)
        GameTypeChanged newType -> ({model | gameType = newType}, Cmd.none)
        GameRulesChanged newRules -> ({model | gameRules = newRules}, Cmd.none)
        StartGame -> ({model | screen = Game }, Cmd.none)


view : Model -> Html Msg
view model =
    div []
        [ case model.screen of
            Start -> viewStart model
            Game -> viewGame model
        ]


viewStart : Model -> Html Msg
viewStart model =
    div []
        [ div []
            [ img [ src "Triffel.png", class "triffel-logo" ] []
            ]
        , fieldset []
            [ legend [] [ text "Spielart" ]
            , label []
                [ input [ type_ "radio", name "spielart", checked (model.gameType == Classic), onClick (GameTypeChanged Classic) ] []
                , text "Classic"
                ]
            , label [ class "label-offset" ]
                [ input [ type_ "radio", name "spielart", checked (model.gameType == Seven), onClick (GameTypeChanged Seven) ] []
                , text "Kniffel 7"
                ]
            ]
        , fieldset []
            [ legend [] [ text "Spielregeln" ]
            , label []
                [ input [ type_ "radio", name "spielregeln", checked (model.gameRules == Single), onClick (GameRulesChanged Single) ] []
                , text "Classic"
                ]
            , label [ class "label-offset" ]
                [ input [ type_ "radio", name "spielregeln", checked (model.gameRules == Triffel), onClick (GameRulesChanged Triffel) ] []
                , text "Triffel"
                ]
            ]
        , fieldset []
            [ legend [] [ text "Spieler" ]
            , ul []
                (List.map viewPlayer model.players)
            , input [ onInput PlayerChanged, autofocus True ] []
            , button [ onClick AddPlayer ] [ text "Hinzufügen" ]
            ]
        , div []
            [ button [ class "start-button", onClick StartGame ] [ text "Start" ]
            ]
        ]

viewPlayer : String -> Html Msg
viewPlayer name =
    li []
        [ span [] [ text name ]
        , button [ onClick (RemovePlayer name)] [ text "-" ]
        ]



viewGame : Model -> Html Msg
viewGame model =
    div []
        []
