require 'test/unit'
require File.expand_path("../helper", __FILE__)

class ItemTest < Test::Unit::TestCase
  def setup
    
  end

  def reload(klass)
    Object.send(:remove_const, klass.to_s)
    load File.expand_path("../#{klass.to_s.downcase}.rb", __FILE__)
    yield
  end

  def test_without_mikado
    reload(Item) do
      Item.class_eval do 
        validates_presence_of :title
      end
    end
    
    i = Item.new
    assert_equal false, i.valid?
  end

  def test_mikado_with_one_condition
    reload(Item) do
      Item.class_eval do 
        
        mikado :live? do
          validates_presence_of :title
        end
        
        def live?
          false
        end
      end
    end
    
    i = Item.new
    assert_equal true, i.valid?
  end
  
  def test_mikado_with_two_validations
    reload(Item) do
      Item.class_eval do 
        
        mikado :live? do
          validates_presence_of :title
        end
        
        validates_presence_of :description
        
        def live?
          false
        end
      end
    end
    
    i = Item.new
    assert_equal false, i.valid?
  end
  
  def test_mikado_with_array_of_validations
    reload(Item) do
      Item.class_eval do 
        
        mikado [:live?, Proc.new {|r| r.payed? }] do
          validates_presence_of :title
        end
        
        def live?
          true
        end
        
        def payed?
          false
        end
      end
    end
    
    i = Item.new
    assert_equal true, i.valid?
  end
  
  def test_mikado_with_array_of_validations_and_if_condition
    reload(Item) do
      Item.class_eval do 
        
        mikado [:live?, Proc.new {|r| r.payed? }] do
          validates_presence_of :title, :if => Proc.new {|r| true}
        end
        
        def live?
          true
        end
        
        def payed?
          true
        end
      end
    end
    
    i = Item.new
    assert_equal false, i.valid?
  end
  
  def test_mikado_with_validate_function
    reload(Item) do
      Item.class_eval do 
        
        mikado :live? do
          validate :check_format
        end
        
        def live?
          false
        end
        
        def check_format
          errors.add :title, 'format isnt correct'
        end
      end
    end
    
    i = Item.new
    assert_equal true, i.valid?
  end
  
  def test_mikado_with_two_mikado_validations
    reload(Item) do
      Item.class_eval do 
        
        mikado :live? do
          validate :check_format
        end
        
        mikado :payed? do
          validates_presence_of :title
        end
        
        def live?
          false
        end
        
        def payed?
          true
        end
      end
    end
    
    i = Item.new
    assert_equal false, i.valid?
  end
  
  def test_mikado_with_validate_on_create
    reload(Item) do
      Item.class_eval do 
        
        mikado :live? do
          validate_on_create :check_format
        end
        
        def live?
          false
        end
        
        def check_format
        end
      end
    end
    
    i = Item.new
    assert_equal true, i.save
  end
end

