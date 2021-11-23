class GroupsController < ApplicationController
  before_action :set_user_groups, only: %i[index]
  before_action :set_user_group, only: %i[show]
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    if user_signed_in?
      @groups
    end
  end

  def show
    @group_contracts = @group.group_contracts.includes(:contract).order(created_at: :desc)
  end

  def new
    @group = current_user.groups.new
    @groups = current_user.groups
  end

  def create
    if current_user.groups.create(group_params)
      flash[:notice] = 'Group added successfully'
      redirect_to groups_url
    else
      flash[:error] = 'Group couldn\'t be added'
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end

  def set_user_group
    @group = current_user.groups.find(params[:id])
  end

  def set_user_groups
    if user_signed_in?
      @groups = current_user.groups.includes(group_contracts: :contract)
    end
  end
end
