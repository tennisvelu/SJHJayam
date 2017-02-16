require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { address_id: @user.address_id, contact_id: @user.contact_id, created_by: @user.created_by, first_name: @user.first_name, isactive: @user.isactive, last_name: @user.last_name, password: @user.password, role_id: @user.role_id, updated_by: @user.updated_by, user_name: @user.user_name, warehouse_id: @user.warehouse_id }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { address_id: @user.address_id, contact_id: @user.contact_id, created_by: @user.created_by, first_name: @user.first_name, isactive: @user.isactive, last_name: @user.last_name, password: @user.password, role_id: @user.role_id, updated_by: @user.updated_by, user_name: @user.user_name, warehouse_id: @user.warehouse_id }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
