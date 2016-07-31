# So we are opening devise to override its wonderful token generation algorithm
# and create a highly unsecure 5-digit authentication code based on strict
# requirements from the client. All so users can login using mobile

# Ruby allows to open a class and change its methods
# `class_eval` creates instance methods and
# `instance_eval` creates class methods.
# Opposite of what one would think generally

# http://tech.tulentsev.com/2012/02/ruby-how-to-override-class-method-with-a-module/

module DeviseFiveDigitToken
  def self.included base
    base.instance_eval do
      def friendly_token
        rand.to_s[2..6]
      end
    end
  end
end


# include the newly generate token into `Devise` class
Devise.send(:include, DeviseFiveDigitToken)