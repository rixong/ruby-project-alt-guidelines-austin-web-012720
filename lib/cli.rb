class CommandLineInterface
    def run
        User.greet
        User.login_or_create_user
    end
end