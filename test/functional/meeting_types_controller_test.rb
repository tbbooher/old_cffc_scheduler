require 'test_helper'

class MeetingTypesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => MeetingType.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    MeetingType.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    MeetingType.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to meeting_type_url(assigns(:meeting_type))
  end
  
  def test_edit
    get :edit, :id => MeetingType.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    MeetingType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => MeetingType.first
    assert_template 'edit'
  end
  
  def test_update_valid
    MeetingType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => MeetingType.first
    assert_redirected_to meeting_type_url(assigns(:meeting_type))
  end
  
  def test_destroy
    meeting_type = MeetingType.first
    delete :destroy, :id => meeting_type
    assert_redirected_to meeting_types_url
    assert !MeetingType.exists?(meeting_type.id)
  end
end
