require 'simplecov'
require 'stringio'
SimpleCov.start
require_relative './automation_script.rb'
describe ImageTagAutomation do
  context 'directory path is incorrect' do
    it 'Return 0' do
      path_test_object = ImageTagAutomation.new
      path_test_variable = path_test_object.path_existance_check('/test_path', 'Testers/test_folder/**/*.haml', 1)
      expect(path_test_variable) == 0
    end
  end
  context 'directory path is correct' do
    it 'Return 0' do
      path_test_object = ImageTagAutomation.new
      path_test_variable = path_test_object.path_existance_check('Testers/test_folder', 'Testers/test_folder/**/*.haml', 2)
      expect(path_test_variable) == 0
    end
  end
  context 'directory/subdirectories does not contain HAML files' do
    it 'Return -1' do
      haml_test_object = ImageTagAutomation.new
      haml_test_variable = haml_test_object.haml_existance_check('Testers/no_haml/**/*.haml', 1)
      expect(haml_test_variable) == -1
    end
  end
  context 'directory/subdirectories contains HAML files' do
    it 'Return 0' do
      haml_test_object = ImageTagAutomation.new
      haml_test_variable = haml_test_object.haml_existance_check('Testers/test_folder/**/*.haml', 1)
      expect(haml_test_variable) == 0
    end
  end
  context 'directory/subdirectories does not contain HAML files' do
    it 'Return -1' do
      haml_test_object = ImageTagAutomation.new
      haml_test_variable = haml_test_object.haml_existance_check('Testers/no_haml/**/*.haml', 2)
      expect(haml_test_variable) == -1
    end
  end
  context 'directory/subdirectories contains HAML files' do
    it 'Return 0' do
      haml_test_object = ImageTagAutomation.new
      haml_test_variable = haml_test_object.haml_existance_check('Testers/test_folder/**/*.haml', 2)
      expect(haml_test_variable) == 0
    end
  end
  context 'HAML files does not contain image tag in English' do
    it 'Return 0' do
      img_test_object = ImageTagAutomation.new
      img_test_variable = img_test_object.scenario_check(0, 1)
      expect(img_test_variable) == 0
    end
  end
  context 'HAML files does not contain image tag in French' do
    it 'Return 0' do
      img_test_object = ImageTagAutomation.new
      img_test_variable = img_test_object.scenario_check(0, 2)
      expect(img_test_variable) == 0
    end
  end
  context 'HAML files contains image tag in English' do
    it 'Return 0' do
      img_test_object = ImageTagAutomation.new
      img_test_variable = img_test_object.scenario_check(1, 1)
      expect(img_test_variable) == 0
    end
  end
  context 'HAML files contains image tag in French' do
    it 'Return 0' do
      img_test_object = ImageTagAutomation.new
      img_test_variable = img_test_object.scenario_check(1, 2)
      expect(img_test_variable) == 0
    end
  end
  context 'Test case for wrong user input in English' do
    it 'Return -1' do
      img_test_object = ImageTagAutomation.new
      img_test_variable = img_test_object.scenario_check(2, 1)
      expect(img_test_variable) == -1
    end
  end
  context 'Test case for wrong user input in French' do
    it 'Return -1' do
      img_test_object = ImageTagAutomation.new
      img_test_variable = img_test_object.scenario_check(2, 2)
      expect(img_test_variable) == -1
    end
  end
  context 'Test for image tag without alt' do
    it 'Return 0' do
      img_test_object = ImageTagAutomation.new
      img_test_variable = img_test_object.check_image_attributes('Testers/test_folder/_scorecard_progress_bar_help.html.haml', 1)
      expect(img_test_variable) == 0
    end
  end
  context 'Test for image tag with alt' do
    it 'Return 0' do
      img_test_object = ImageTagAutomation.new
      img_test_variable = img_test_object.check_image_attributes('Testers/test_folder/testing.haml', 2)
      expect(img_test_variable) == 0
    end
  end
  context 'Test for image tag with alt and without alt' do
    it 'Return 0' do
      img_test_object = ImageTagAutomation.new
      img_test_variable = img_test_object.check_image_attributes('Testers/test_folder/testing.haml', 3)
      expect(img_test_variable) == 0
    end
  end
  context 'User should input given choice' do
    it 'Return -1' do
      choice_test_object = ImageTagAutomation.new
      choice_test_variable = choice_test_object.check_image_attributes('Testers/test_folder/testing.haml', 'a')
      expect(choice_test_variable) == -1
    end
  end
  context 'Test for switch case with user choice as 1 in English' do
    it 'Return 0' do
      switch_test_object = ImageTagAutomation.new
      switch_test_variable = switch_test_object.process_user_choice(1, 'Testers/test_folder/**/*.haml', 1)
      expect(switch_test_variable) == 0
    end
  end
  context 'Test for switch case with user choice as 2 in French' do
    it 'Return 0' do
      switch_test_object = ImageTagAutomation.new
      switch_test_variable = switch_test_object.process_user_choice(2, 'Testers/test_folder/**/*.haml', 2)
      expect(switch_test_variable) == 0
    end
  end
  context 'Test for switch case with user choice as 3 in English' do
    it 'Return 0' do
      switch_test_object = ImageTagAutomation.new
      switch_test_variable = switch_test_object.process_user_choice(3, 'Testers/test_folder/**/*.haml', 1)
      expect(switch_test_variable) == 0
    end
  end
  context 'Test for switch case with incorrect user choice in English' do
    it 'Return 0' do
      switch_test_object = ImageTagAutomation.new
      switch_test_variable = switch_test_object.process_user_choice(4, 'Testers/test_folder/**/*.haml', 1)
      expect(switch_test_variable) == -1
    end
  end
  context 'Test to get user inputs' do
    it 'Return 0' do
      switch_test_object = ImageTagAutomation.new
      switch_test_variable = switch_test_object.get_path(1)
      expect(switch_test_variable) == 0
    end
  end
  context 'Test to get user inputs' do
    it 'Return 0' do
      switch_test_object = ImageTagAutomation.new
      switch_test_variable = switch_test_object.get_path(2)
      expect(switch_test_variable) == 0
    end
  end
  context 'Test to get user inputs' do
    it 'Return -1' do
      switch_test_object = ImageTagAutomation.new
      switch_test_variable = switch_test_object.get_path(3)
      expect(switch_test_variable) == -1
    end
  end
end
