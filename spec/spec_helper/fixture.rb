module SpecHelper
  def self.fixture(name)
    Fixture.fixture(name)
  end
  
  def self.create_sample_app_copy_from_fixture(fixture_name)
    tmp_dir = Pathname.new(Dir.mktmpdir)
    fixture_path = ROOT + "spec/fixtures/#{fixture_name}"
    fixture_copy_path = tmp_dir + fixture_name
    FileUtils.cp_r(fixture_path, tmp_dir)
    fixture_copy_path + "#{fixture_name}.xcodeproj"
  end

  module Fixture
    ROOT = ::ROOT + 'spec/fixtures'

    def fixture(name)
      file = ROOT + name
      unless file.exist?
        archive = Pathname.new(file.to_s + '.tar.gz')
        if archive.exist?
          system "cd '#{archive.dirname}' && tar -zxvf '#{archive}' > /dev/null 2>&1"
        end
      end
      file
    end
    module_function :fixture
  end
end
