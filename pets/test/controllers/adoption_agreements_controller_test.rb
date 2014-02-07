require 'test_helper'

class AdoptionAgreementsControllerTest < ActionController::TestCase
  setup do
    @adoption_agreement = adoption_agreements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adoption_agreements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adoption_agreement" do
    assert_difference('AdoptionAgreement.count') do
      post :create, adoption_agreement: {  }
    end

    assert_redirected_to adoption_agreement_path(assigns(:adoption_agreement))
  end

  test "should show adoption_agreement" do
    get :show, id: @adoption_agreement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adoption_agreement
    assert_response :success
  end

  test "should update adoption_agreement" do
    patch :update, id: @adoption_agreement, adoption_agreement: {  }
    assert_redirected_to adoption_agreement_path(assigns(:adoption_agreement))
  end

  test "should destroy adoption_agreement" do
    assert_difference('AdoptionAgreement.count', -1) do
      delete :destroy, id: @adoption_agreement
    end

    assert_redirected_to adoption_agreements_path
  end
end
