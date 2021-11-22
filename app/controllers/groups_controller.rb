class GroupsController < ApplicationController
  before_action :set_user_groups, only: %i[index]
  before_action :set_user_group, only: %i[show]

  def index
    @groups
  end

  def show
    @group_contracts = @group.group_contracts.includes(:contract).order(created_at: :desc)
  end

  def new
    @group = Group.new
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
    @groups = current_user.groups.includes(group_contracts: :contract)
  end
end
