require 'test_helper'

class ParticipantsControllerTest < ActionController::TestCase
  test 'should get participants' do
    get :index, token: polls(:alices_poll).token
    assert_response :success
    assert_template :index

    assert assigns(:participant)
    assert_equal polls(:alices_poll), assigns(:participant).poll
    assert assigns(:participants)
    assert assigns(:participants).size >= 3
    assert assigns(:participants).first.name

    assert assigns(:comment)
    assert_equal polls(:alices_poll), assigns(:comment).poll
    assert assigns(:comments)
    assert assigns(:comments).size >= 2
    assert assigns(:comments).first.name
    assert assigns(:comments).first.comment
  end

  test 'should create participant' do
    assert_difference('Participant.count') do
      post :create, token: polls(:alices_poll).token, participant: {name: 'peter', entries_attributes: [
          {choice_id: choices(:margherita).id, answer: '1'},
          {choice_id: choices(:funghi).id, answer: '3'},
          {choice_id: choices(:quattro_formaggi).id, answer: '1'},
          {choice_id: choices(:gorgonzola).id, answer: '1'}
      ]}
    end
    assert_equal 'Participant was successfully created.', flash[:notice]
    assert_equal polls(:alices_poll), assigns(:poll)
    assert_redirected_to poll_path(polls(:alices_poll))
    assert_equal 'peter', Poll.find(polls(:alices_poll).id).participants[2].name
    assert_equal 4, Poll.find(polls(:alices_poll).id).participants[2].entries.size
    assert_equal 1, Poll.find(polls(:alices_poll).id).participants[2].entries[0].answer
    assert_equal 3, Poll.find(polls(:alices_poll).id).participants[2].entries[1].answer
  end

  test 'should not create incomplete participant' do
    assert_no_difference('Participant.count') do
      post :create, token: polls(:alices_poll).token, participant: {name: ''}
    end
    assert_response :success
    assert_template :index
    assert assigns(:participant)
  end

  test 'should get edit participant' do
    get :edit, token: polls(:alices_poll).token, id: participants(:alice).id
    assert_response :success
    assert_template :edit
    assert assigns(:participant)
    assert assigns(:participant).entries
    assert_equal 4, assigns(:participant).entries.size
  end

  test 'should update participant' do
    put :update, token: polls(:alices_poll).token, id: participants(:alice).id, participant: {name: 'peter', entries_attributes: [
        {id: entries(:a1).id, choice_id: choices(:margherita).id, answer: '1'},
        {id: entries(:a2).id, choice_id: choices(:funghi).id, answer: '3'},
        {id: entries(:a3).id, choice_id: choices(:quattro_formaggi).id, answer: '1'},
        {id: entries(:a4).id, choice_id: choices(:gorgonzola).id, answer: '1'}
    ]}
    assert_equal 'Participant was successfully updated.', flash[:notice]
    assert_equal polls(:alices_poll), assigns(:poll)
    assert_redirected_to poll_path(polls(:alices_poll))
    assert_equal 'peter', Participant.find(participants(:alice).id).name
    assert_equal 4, Participant.find(participants(:alice).id).entries.size
    assert_equal 1, Entry.find(entries(:a1).id).answer
    assert_equal 3, Entry.find(entries(:a2).id).answer
  end

  test 'update participant should fail' do
    put :update, token: polls(:alices_poll).token, id: participants(:alice).id, participant: {name: ''}
    assert_response :success
    assert_template :edit
    assert assigns(:participant)
  end

  test 'should get destroy confirm participant' do
    get :destroy_confirm, token: polls(:alices_poll).token, id: participants(:alice).id
    assert_response :success
    assert_template :destroy_confirm
    assert assigns(:participant)
  end

  test 'should destroy participant' do
    assert_difference('Participant.count', -1) do
      delete :destroy, token: polls(:alices_poll).token, id: participants(:alice).id
    end
    assert_equal 'Participant destroyed.', flash[:notice]
    assert_redirected_to poll_path(assigns(:poll))
  end

  test 'token should be required' do
    assert_raises ActiveRecord::RecordNotFound do
      post :create, token: 'guessed token', participant: {name: 'peter', entries_attributes: [
          {choice_id: choices(:margherita).id, answer: '1'},
          {choice_id: choices(:funghi).id, answer: '3'},
          {choice_id: choices(:quattro_formaggi).id, answer: '1'},
          {choice_id: choices(:gorgonzola).id, answer: '1'}
      ]}
    end
    assert_raises ActiveRecord::RecordNotFound do
      get :edit, token: 'guessed token', id: participants(:alice).id
    end
    assert_raises ActiveRecord::RecordNotFound do
      put :update, token: 'guessed token', id: participants(:alice).id, participant: {name: 'peter', entries_attributes: [
          {id: entries(:a1).id, choice_id: choices(:margherita).id, answer: '1'},
          {id: entries(:a2).id, choice_id: choices(:funghi).id, answer: '3'},
          {id: entries(:a3).id, choice_id: choices(:quattro_formaggi).id, answer: '1'},
          {id: entries(:a4).id, choice_id: choices(:gorgonzola).id, answer: '1'}
      ]}
    end
    assert_raises ActiveRecord::RecordNotFound do
      get :destroy_confirm, token: 'guessed token', id: participants(:alice).id
    end
    assert_raises ActiveRecord::RecordNotFound do
      delete :destroy, token: 'guessed token', id: participants(:alice).id
    end
  end
end
