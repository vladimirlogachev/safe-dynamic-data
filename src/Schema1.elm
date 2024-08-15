module Schema1 exposing (DbDocument, dbDocumentDecoder, toReactRenderable)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)
import ReactRenderable exposing (ReactRenderable(..))
import SchemaError exposing (SchemaError(..))



-- This module is editable by the support engineer.
-- Required components of the schema: DbDocument, dbDocumentDecoder, toReactRenderable
-- Type signatures must be preserved.


type alias DbDocument =
    { name : String
    , age : Int
    , dogName : String
    , isDogOwner : Bool
    }


dbDocumentDecoder : Decoder DbDocument
dbDocumentDecoder =
    Decode.succeed DbDocument
        |> required "name" Decode.string
        |> required "age" Decode.int
        |> required "dogName" Decode.string
        |> required "isDogOwner" Decode.bool


toReactRenderable : DbDocument -> Result String ReactRenderable
toReactRenderable doc =
    if doc.age >= 30 && not doc.isDogOwner then
        Err "Every person over 30 must own a dog."

    else
        Ok <|
            Nested
                [ String { name = "Name", value = doc.name }
                , Int { name = "Age", value = doc.age }
                , String { name = "Dog Name", value = doc.dogName }
                , BoolValue { name = "Is Dog Owner", value = doc.isDogOwner }
                ]
