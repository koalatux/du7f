require 'test_helper'

class ParticipantsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  #test "the truth" do
  #  assert true
  #end

  test 'should get index' do
    get :index, token: polls(:alices_poll).token
    assert_response :success
    assert_template :index

    # TODO: test participant

    assert assigns(:comment)
    assert_equal polls(:alices_poll), assigns(:comment).poll
    assert assigns(:comments)
    assert assigns(:comments).size >= 2
    assert assigns(:comments).first.name
    assert assigns(:comments).first.comment
  end
end
