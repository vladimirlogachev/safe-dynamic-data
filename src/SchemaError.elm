module SchemaError exposing (..)

import Json.Decode as Decode
import Json.Encode


type SchemaError
    = DecodeError Decode.Error
    | TransformError String


encode : SchemaError -> Json.Encode.Value
encode e =
    case e of
        DecodeError decodeError ->
            Json.Encode.object
                [ ( "DecodeError", Json.Encode.string <| Decode.errorToString decodeError )
                ]

        TransformError message ->
            Json.Encode.object
                [ ( "TransformError", Json.Encode.string message )
                ]
