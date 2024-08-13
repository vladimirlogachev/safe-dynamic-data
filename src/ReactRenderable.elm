module ReactRenderable exposing (..)

import Json.Encode


type ReactRenderable
    = Int { name : String, value : Int }
    | String { name : String, value : String }
    | BoolValue { name : String, value : Bool }
    | Nested (List ReactRenderable)


encoder : ReactRenderable -> Json.Encode.Value
encoder renderable =
    case renderable of
        Int { name, value } ->
            Json.Encode.object
                [ ( "type", Json.Encode.string "Int" )
                , ( "name", Json.Encode.string name )
                , ( "value", Json.Encode.int value )
                ]

        String { name, value } ->
            Json.Encode.object
                [ ( "type", Json.Encode.string "String" )
                , ( "name", Json.Encode.string name )
                , ( "value", Json.Encode.string value )
                ]

        BoolValue { name, value } ->
            Json.Encode.object
                [ ( "type", Json.Encode.string "BoolValue" )
                , ( "name", Json.Encode.string name )
                , ( "value", Json.Encode.bool value )
                ]

        Nested elements ->
            Json.Encode.object
                [ ( "type", Json.Encode.string "Nested" )

                -- TODO: Use tail recursion, or prove that it's not necessary.
                , ( "elements", Json.Encode.list encoder elements )
                ]
