class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
include ActionView::Helpers::NumberHelper

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @user.build_contact
    @user.build_address
    @warehouse = []
  end

  # GET /users/1/edit
  def edit
  end

  def dynamic_warehouse
    @warehouse = Warehouse.where(:company_id=>params[:format])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

      if @user.save
        Address.find(@user.address_id).update_attributes(:city=>params[:city],:state=>params[:state],:country=>params[:country])
        redirect_to users_path
        flash[:notice] = 'User was successfully created.'
      else
        redirect_to users_path
        flash[:notice] = @user.errors.full_messages[0]
      end
       
    end
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      warehouse_id=User.find(params[:id]).warehouse_id
      if @user.update(user_params)
        @user.update(:warehouse_id=>warehouse_id)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
      Address.find(@user.address_id).update_attributes(:city=>params[:city],:state=>params[:state],:country=>params[:country])
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
     respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def login_page
  @users=User.new
  #render :layout=>false
  end  
 def logout
   session[:user_id]=nil
    redirect_to root_path 
 end


 def validate_login 
    params.permit!
    user = User.where(:user_name=>params[:user_name], :password=>params[:password])
    unless user.empty?
      session[:user_id] = user[0].id
      role_id=user[0].role_id
      role=Role.find(role_id).role_type
      case role
      when "Super Admin"
        redirect_to companies_super_admin_path
      when "Warehouse Admin"
        redirect_to warehouses_warehouse_admin_path
      end
    else
     flash[:notice]= "Invalid UserName or Password" 
     redirect_to root_path
    end  
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :user_name, :password, :role_id, :contact_id, :address_id, :warehouse_id, :isactive, :created_by, :updated_by,contact_attributes: [:email,:telephone_number, :mobile_number], address_attributes: [:address1, :post_code, :city, :state, :country])
    end
end
