require "helper"

class DateValidationsTest < Test::Unit::TestCase
  describe "date validation with a normal string column" do
    class Person < Ohm::Model
      include Ohm::DateValidations

      attribute :birthday
      
      def validate
        assert_date :birthday
      end
    end

    test "accepts all canonical dates" do
      assert Person.new(:birthday => "2010-05-05").valid?
      assert Person.new(:birthday => "2010-5-5").valid?
      assert Person.new(:birthday => "2010-05-5").valid?
      assert Person.new(:birthday => "2010-5-05").valid?
    end

    test "also catches invalid dates" do
      assert ! Person.new(:birthday => "2010-02-29").valid?
    end

    test "invalid when empty" do
      assert ! Person.new(:birthday => "").valid?
    end
  end
end
