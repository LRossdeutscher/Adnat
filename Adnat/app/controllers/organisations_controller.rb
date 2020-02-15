class OrganisationsController < ApplicationController
    def organisation_params
        params.require(:organisation).permit(:name, :hourly_rate)
    end

    def create
        @organisation = Organisation.create(organisation_params)
        user = User.find(session[:user_id])
        if user
            user.organisation_id = @organisation.id
            #how can i tell this is being set?
            redirect_to '/overview'
        else
            render 'welcome'
        end
    end
end
