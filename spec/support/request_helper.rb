module Requests
    module JsonHelpers
        def json
            JSON.parse(last_response.body)
        end

        def authenticate_test(app)
            get '/users/confirm', params: {token: user.confirmation_token}
            post '/authenticate', params: {email: app.email, password: 'whatisthisnewapp'}
            return json['auth_token']
        end
    end
end
