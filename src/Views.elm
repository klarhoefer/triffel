module Views exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Shared exposing (..)
import Icons exposing (..)

view : Model -> Html Msg
view model =
    div [ class "outer-div" ]
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
            , ol []
                (List.map viewPlayer model.players)
            , div [ class "add-player" ]
                [ input [ onInput PlayerChanged, autofocus True ] []
                , button [ onClick AddPlayer ] [ text "Hinzufügen" ]
                ]
            ]
        , div [ class "settings-button" ]
            [ button [ class "start-button", onClick StartGame ] [ text "Start" ]
            ]
        ]


viewPlayer : String -> Html Msg
viewPlayer name =
    li []
        [ span [ class "player-name" ] [ text name ]
        , button [ onClick (RemovePlayer name)] [ text "-" ]
        ]


viewGame : Model -> Html Msg
viewGame _ =
    div []
        [ table []
            [ thead []
                ([ th [] []
                , th [] []
                ] ++ (
                    [1, 2, 3, 4, 5, 6]
                    |> List.map (\n -> viewSpielHdr n)
                ))
            , tbody []
                ([] ++ (viewPasche))
            ]
        ]


viewSpielHdr : Int -> Html Msg
viewSpielHdr n =
    th [ class "spiel-hdr" ] [ text <| (String.fromInt n) ++ ". Spiel" ]


viewPasche : List (Html Msg)
viewPasche =
    [1, 2, 3, 4, 5, 6, 7]
    |> List.map viewPaschRow


iconSize : Int
iconSize = 32


nurNzaehlen : Int -> String
nurNzaehlen n =
    let
        ausgeschrieben =
            case n of
                1 -> "Einser"
                2 -> "Zweier"
                3 -> "Dreier"
                4 -> "Vierer"
                5 -> "Fünfer"
                6 -> "Sechser"
                _ -> "Siebener"
    in
        "Nur " ++ ausgeschrieben ++ " zählen"


viewPaschRow : Int -> Html Msg
viewPaschRow n =
    tr []
        ([ td []
            [ dice iconSize n
            , dice iconSize n
            , dice iconSize n
            ]
        , td []
            [ text <| nurNzaehlen n ]
        ] ++ (
            [1, 2, 3, 4, 5, 6]
            |> List.map (\_ -> viewPaschField n)
        ))


viewPaschField : Int -> Html Msg
viewPaschField n =
    td [ class "td-cmb" ]
        [ select []
            ((option [] []) :: ([0,1,2,3,4,5,6]
                |> List.map (viewPaschOpt n))
            )
        ]


viewPaschOpt : Int -> Int -> Html Msg
viewPaschOpt v n =
    let
        val = n * v
        sval = case val of
            0 -> "-"
            x -> String.fromInt x
    in
        option []
            [ text sval ]
