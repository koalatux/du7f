require 'test_helper'

class PollsControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
    assert_template :new
    assert assigns(:poll)
    assert assigns(:poll).choices
    assert assigns(:poll).choices.size >= 1
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_template :index
  end

  test 'should add choices' do
    assert_no_difference('Poll.count') do
      post :create, commit: 'Add Choice', poll: {choices_attributes: {'0' => {title: 'foo'}}}
    end
    assert_response :success
    assert_template :new
    assert assigns(:poll)
    assert assigns(:poll).choices
    assert assigns(:poll).choices.size >= 2
  end

  test 'should create poll' do
    assert_difference('Poll.count') do
      post :create, poll: {
          author: 'name',
          admin_email_address: 'test@example.org',
          title: 'title',
          description: 'description',
          calculation: '23',
          poll_type: '2',
          comments_allowed: '1',
          enable_close_at: '1',
          'close_at(1i)' => '2011',
          'close_at(2i)' => '9',
          'close_at(3i)' => '27',
          'close_at(4i)' => '17',
          'close_at(5i)' => '12',
          choices_attributes: {'0' => {title: 'a'}, '1' => {:title => 'b'}, '2' => {title: 'c'}, '3' => {title: 'd'}, '4' => {title: 'e'}}
      }
    end
    assert_response :success
    assert_template :create
    assert_equal 'Poll was successfully created.', flash[:notice]
    assert assigns(:poll)
  end

  test 'create poll should fail' do
    assert_no_difference('Poll.count') do
      post :create, poll: {}
    end
    assert_response :success
    assert_template :new
    assert assigns(:poll)
  end

  test 'should get edit' do
    get :edit, token: polls(:alices_poll).token, admin_token: polls(:alices_poll).admin_token
    assert_response :success
    assert_template :edit
    assert assigns(:poll)
    assert assigns(:poll).choices
    assert_equal 4, assigns(:poll).choices.size
  end

  test 'should update poll' do
    put :update, token: polls(:alices_poll).token, admin_token: polls(:alices_poll).admin_token, poll: {title: 'pi*z*z*a', calculation: '23'}
    assert_equal 'Poll was successfully updated.', flash[:notice]
    assert assigns(:poll)
    assert_redirected_to poll_path(assigns(:poll))
    assert_equal 'pi*z*z*a', Poll.find(polls(:alices_poll).id).title
  end

  test 'update poll should fail' do
    put :update, token: polls(:alices_poll).token, admin_token: polls(:alices_poll).admin_token, poll: {poll_type: ''}
    assert_response :success
    assert_template :edit
    assert assigns(:poll)
  end

  test 'should get destroy confirm poll' do
    get :destroy_confirm, token: polls(:alices_poll).token, admin_token: polls(:alices_poll).admin_token
    assert_response :success
    assert_template :destroy_confirm
    assert assigns(:poll)
  end

  test 'should destroy poll' do
    assert_difference('Poll.count', -1) do
      delete :destroy, token: polls(:alices_poll).token, admin_token: polls(:alices_poll).admin_token
    end
    assert_equal 'Poll destroyed.', flash[:notice]
    assert_redirected_to polls_path
  end

  test 'admin token should be required' do
    assert_raises ActiveRecord::RecordNotFound do
      get :edit, token: polls(:alices_poll).token, admin_token: 'guessed token'
    end
    assert_raises ActiveRecord::RecordNotFound do
      put :update, token: polls(:alices_poll).token, admin_token: 'guessed token', poll: {title: 'pi*z*z*a'}
    end
    assert_raises ActiveRecord::RecordNotFound do
      get :destroy_confirm, token: polls(:alices_poll).token, admin_token: 'guessed token'
    end
    assert_raises ActiveRecord::RecordNotFound do
      delete :destroy, token: polls(:alices_poll).token, admin_token: 'guessed token'
    end
  end
end
