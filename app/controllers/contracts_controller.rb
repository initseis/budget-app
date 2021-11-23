class ContractsController < ApplicationController
  def new
    @contract = current_user.contracts.new
    @groups = current_user.groups
  end

  def create
    if (@contract = current_user.contracts.create(contract_params))
      params[:groups].each do |group|
        throw error unless @contract.group_contracts.create(group_id: group)
      end
      flash[:notice] = 'Contract added successfully'
      redirect_to group_url(id: params[:group_id])
    else
      throw error
    end
  rescue StandardError
    flash[:error] = 'Contract couldn\'t be added'
    render :new
  end

  private

  def contract_params
    params.require(:contract).permit(:name, :amount)
  end
end
