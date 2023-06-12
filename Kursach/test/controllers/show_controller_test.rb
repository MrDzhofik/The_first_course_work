require "test_helper"

class ShowControllerTest < ActionDispatch::IntegrationTest
  test "should get department" do
    get show_department_url
    assert_response :success
  end

  test "should get discipline" do
    get show_discipline_url
    assert_response :success
  end

  test "should get teacher" do
    get show_teacher_url
    assert_response :success
  end

  test "should get student" do
    get show_student_url
    assert_response :success
  end

  test "should get mark" do
    get show_mark_url
    assert_response :success
  end

  test "should get kudo" do
    get show_kudo_url
    assert_response :success
  end

  test "should get reprimand" do
    get show_reprimand_url
    assert_response :success
  end
end
