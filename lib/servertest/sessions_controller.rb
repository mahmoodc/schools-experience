# This method overwrites SessionsController#create so that it can log in
# users without having to mimic an entire OIDC stack.
#
# **It should only be used by Cucumber**
Schools::SessionsController.class_eval do
  def create
    Bookings::School.find_or_create_by(urn: 123456) do |school|
      school.name = "Some school"
      school.contact_email = "someone@someschool.org"
      school.address_1 = "22 something street"
      school.postcode = "M1 2JJ"
      school.school_type = Bookings::SchoolType.find_or_create_by(name: "type one")
    end

    session[:id_token]     = 'abc123'
    session[:current_user] = { name: params[:name] || 'Joey' }
    session[:urn]          = 123456
    redirect_to '/schools/dashboard'
  end
end
