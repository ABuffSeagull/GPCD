module Pages.Home_ exposing (page)

import Element as E
import Html
import View exposing (View)


page : View msg
page =
    { title = "Homepage"
    , attributes = []
    , element = E.text "Hello World"
    }
