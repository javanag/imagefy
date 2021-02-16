require "test_helper"

class ImageTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess::FixtureFile

  test 'should not save with empty string title' do
    title_string = ''

    image = create_skeleton_image
    image.title = title_string

    assert_not image.save, "Saved the image with invalid title"
  end

  test 'default access_level should be :open' do
    image = create_skeleton_image
    image.save!
    assert image.open?
  end

  test 'should not save with title over 50 chars' do
    title_string = 'this is a long image title, much longer than 50 characters'

    image = create_skeleton_image
    image.title = title_string

    assert_not image.save, "Saved the image with invalid title"
  end

  test 'should not save with description over 1000 characters' do
    description_string = 'a' * 1001

    image = create_skeleton_image
    image.description = description_string

    assert_not image.save, "Saved the image with invalid description"
  end

  test 'should not save without image file' do
    image = Image.new(
      user: users(:me),
      title: 'title'
    )

    assert_not image.save, "Saved the image with missing image_file"
  end

  test 'should not save with invalid access level' do
    access_level_string = 'does_not_exist'

    image = create_skeleton_image

    assert_raises(ArgumentError) do
      image.access_level = access_level_string
    end
  end

  test 'should not save if uploaded file is not an image' do
    image = Image.new(
      user: users(:me),
      title: 'title',
      image_file: fixture_file_upload(
        'lorem-ipsum.pdf', 'application/pdf')
    )

    assert_not image.save, "Saved the image with non-image file upload"
  end

  test 'should strip and sort tags' do
    image = create_skeleton_image
    image.tags = 'hats,cats  ,rats, bats'
    image.save

    assert_equal 'bats,cats,hats,rats', image.tags
  end

  private

  def create_skeleton_image
    Image.new(
      user: users(:me),
      title: 'title',
      image_file: fixture_file_upload(
        'jake-hills-jasper-alberta.jpg', 'image/jpeg')
    )
  end
end
