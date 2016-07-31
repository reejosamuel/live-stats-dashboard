class PasswordsController < Devise::PasswordsController

  # another security feature of devise is not open the change password
  # page directly unless the user arrived the page from clicking the
  # reset password link on email.

  # we disable this security feature in support of mobile signup as
  # requested by the client.
  skip_before_action :assert_reset_token_passed, only: :edit


end