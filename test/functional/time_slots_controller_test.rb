require 'test_helper'

class TimeSlotsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => TimeSlot.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    TimeSlot.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    TimeSlot.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to time_slot_url(assigns(:time_slot))
  end
  
  def test_edit
    get :edit, :id => TimeSlot.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    TimeSlot.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TimeSlot.first
    assert_template 'edit'
  end
  
  def test_update_valid
    TimeSlot.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TimeSlot.first
    assert_redirected_to time_slot_url(assigns(:time_slot))
  end
  
  def test_destroy
    time_slot = TimeSlot.first
    delete :destroy, :id => time_slot
    assert_redirected_to time_slots_url
    assert !TimeSlot.exists?(time_slot.id)
  end
end
