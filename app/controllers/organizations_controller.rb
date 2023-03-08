class OrganizationsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin, only: [:approve, :reject]
  before_action :verify_unapproved, only: [:new, :create]
  before_action :verify_approved, only: [:edit, :update]
  before_action :verify_user, only: [:show, :resources]
  before_action :set_organization, only: [:show, :edit, :update, :approve, :reject]

  def index
    @organizations = Organization.all.order(:name)
  end

  def new
    @organization = Organization.new
  end

  def create
    @new_organization = Organization.new(organization_params.merge(status: :submitted))

    current_user.organization = @new_organization if @new_organization.valid?

    if @new_organization.save && current_user.save
      redirect_to organization_application_submitted_path
      # TODO: fails if there are no admin users in the database
      email = UserMailer.with(to: User.where(role: :admin).pluck(:email), new_organization: @new_organization).new_organization_application
      if email then email.deliver_now end
    else
      @organization = @new_organization
      render :new
    end
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      redirect_to organization_path(id: @organization.id)
    else
      render :edit
    end
  end

  def show
  end

  def approve
    @organization.approve

    if @organization.save
      redirect_to organizations_path, notice: "Organization #{@organization.name} has been approved."
    else
      redirect_to organization_path(id: @organization.id)
    end
  end

  def reject
    @organization.reject

    @organization.rejection_reason = params[:organization][:rejection_reason] unless params[:organization][:rejection_reason].nil?

    if @organization.save
      redirect_to organizations_path, notice: "Organization #{@organization.name} has been rejected."
    else
      redirect_to organization_path(id: @organization.id)
    end
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(
      :name,
      :phone,
      :email,
      :description,
      :liability_insurance,
      :primary_name,
      :secondary_name,
      :secondary_phone,
      :title,
      :transportation,
      resource_category_ids: []
    ).to_h
  end

  def verify_unapproved
    redirect_to dashboard_path unless current_user.organization? && current_user.organization.nil?
  end

  def verify_approved
    redirect_to dashboard_path unless current_user.try(:organization).try(:approved?)
  end

  def verify_user
    redirect_to dashboard_path unless current_user.try(:organization).try(:approved?) || current_user.admin?
  end

end