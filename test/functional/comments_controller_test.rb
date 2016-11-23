require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test 'should create comment' do
    assert_difference('Comment.count') do
      post :create, token: polls(:alices_poll).token, comment: {name: 'name', comment: 'miau', calculation: '0x17'}
    end
    assert_equal 'Comment was successfully created.', flash[:notice]
    assert_equal polls(:alices_poll), assigns(:poll)
    assert_redirected_to poll_path(polls(:alices_poll))
    assert_equal 'miau', Poll.find(polls(:alices_poll).id).comments[2].comment
  end

  test 'should not create incomplete comment' do
    assert_no_difference('Comment.count') do
      post :create, token: polls(:alices_poll).token, comment: {name: 'name', comment: '', calculation: '0x17'}
    end
    assert_template 'participants/index'
    assert_equal polls(:alices_poll), assigns(:poll)
  end

  test 'should not allow comment if not enabled' do
    assert_no_difference('Comment.count') do
      post :create, token: polls(:bobs_poll).token, comment: {name: 'name', comment: 'miau', calculation: '0x17'}
    end
    assert_equal 'Comments have been disabled in this poll.', flash[:error]
    assert_redirected_to poll_path(polls(:bobs_poll))
  end

  test 'should get destroy confirm comment' do
    get :destroy_confirm, token: polls(:alices_poll).token, id: comments(:one).id
    assert_response :success
    assert_template :destroy_confirm
    assert assigns(:comment)
  end

  test 'should destroy comment' do
    assert_difference('Comment.count', -1) do
      delete :destroy, token: polls(:alices_poll).token, id: comments(:one).id
    end
    assert_equal 'Comment destroyed.', flash[:notice]
    assert_redirected_to poll_path(assigns(:poll))
  end

  test 'token should be required' do
    assert_raises ActiveRecord::RecordNotFound do
      post :create, token: 'guessed token', comment: {name: 'name', comment: 'miau', calculation: '0x17'}
    end
    assert_raises ActiveRecord::RecordNotFound do
      get :destroy_confirm, token: 'guessed token', id: comments(:one).id
    end
    assert_raises ActiveRecord::RecordNotFound do
      delete :destroy, token: 'guessed token', id: comments(:one).id
    end
  end
end
