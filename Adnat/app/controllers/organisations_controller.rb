class OrganisationsController < ApplicationController
    def organisation_params
        params.require(:organisation).permit(:name, :hourly_rate)
    end

    def create
        @organisation = Organisation.create(organisation_params)
        if @organisation.save
            User.update(current_user.id, organisation_id: @organisation.id)
            redirect_to overview_path
        else
            render "sessions/welcome"
        end
    end

    def edit
        @organisation = Organisation.find(params[:id])
    end

    def update
        @organisation = Organisation.update(params[:id], organisation_params)
        if @organisation.errors.any?
            render "edit"
        else
            if current_user.organisation_id != nil
                redirect_to overview_path
            else
                redirect_to welcome_path
            end
        end
    end

    def destroy
        Organisation.destroy(params[:id])
        redirect_to welcome_path
    end
end
