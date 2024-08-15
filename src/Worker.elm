module Worker exposing (main)

import Json.Decode as Decode
import Json.Encode
import Platform
import Ports
import ReactRenderable exposing (ReactRenderable(..))
import Schema1
import SchemaError exposing (SchemaError(..))



-- Interop with JS


main : Program () () String
main =
    Platform.worker
        { init = always <| ( (), Cmd.none )
        , update = \str _ -> ( (), Ports.sendOutput <| encodeResult ReactRenderable.encoder <| processInput str )
        , subscriptions = always <| Ports.input identity
        }


processInput : String -> Result SchemaError ReactRenderable
processInput =
    (Decode.decodeString Schema1.dbDocumentDecoder >> Result.mapError DecodeError)
        >> Result.andThen (Schema1.toReactRenderable >> Result.mapError TransformError)


encodeResult : (a -> Json.Encode.Value) -> Result SchemaError a -> Json.Encode.Value
encodeResult encodeValue r =
    case r of
        Ok a ->
            Json.Encode.object
                [ ( "Ok", encodeValue a ) ]

        Err e ->
            Json.Encode.object
                [ ( "Err", SchemaError.encode e ) ]
