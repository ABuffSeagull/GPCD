module Auth exposing (User, onPageLoad, viewLoadingPage)

import Auth.Action
import Dict
import Route exposing (Route)
import Route.Path
import Shared
import Url.Builder exposing (string)
import View exposing (View)


type alias User =
    { accessToken : String }


{-| Called before an auth-only page is loaded.
-}
onPageLoad : Shared.Model -> Route () -> Auth.Action.Action User
onPageLoad shared route =
    case shared.accessToken of
        Just token ->
            Auth.Action.loadPageWithUser
                { accessToken = token
                }

        Nothing ->
            let
                url =
                    Url.Builder.crossOrigin
                        "https://accounts.google.com/"
                        [ "o", "oauth2", "v2", "auth" ]
                        [ string "client_id" shared.oauthClientId
                        , string "redirect_uri" "http://localhost:1234"
                        , string "response_type" "token"
                        , string "scope" "https://www.googleapis.com/auth/cloud-platform"
                        ]
            in
            Auth.Action.loadExternalUrl url


{-| Renders whenever `Auth.Action.showLoadingPage` is returned from `onPageLoad`.
-}
viewLoadingPage : Shared.Model -> Route () -> View Never
viewLoadingPage shared route =
    View.fromString "Loading..."
