module Mikado
  # add methods to get mikado functionality
  
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      modify_validations
    end
  end
  
  module ClassMethods
    
    def mikado(*args, &block)
      # set flag that were in mikado
      # we have to monkey patch the validation methods
      # these should check if were in mikado
      # and add the condition to the :if param
      # then we can call class_eval

      self.mikado_validation = args

      class_eval &block
      
      self.mikado_validation = nil
      
      # remove the mikado flag
    end
    
    def mikado_validation=(value)
      @@mikado = value
    end
    
    def mikado_validation
      return @@mikado if defined? @@mikado
      return nil
    end
    
    def modify_validations
      meths = methods.map { |m| m if m.to_s.starts_with?("validates_") }.compact
      meths |= %w( validate validate_on_create validate_on_update )
      
      meths.each do |method|
        (class << self; self; end).instance_eval do

          define_method "#{method}_with_mikado" do |*attr_names, &block|
            attrs = modify_with_mikado(attr_names)
            return self.send("#{method}_without_mikado", *attrs, &block)
          end
          
          alias_method_chain method, "mikado"
        end
      end
    end
    
    def modify_with_mikado(attr_names)
      return attr_names unless mikado_validation
      
      options = attr_names.extract_options!
      options = options.dup if Mikado::Utility.is_ar_3?

      options[:if] = [] if options.blank?
      options[:if] = [options[:if]] if !options[:if].is_a?(Array)

      options[:if] = options[:if] | mikado_validation
    
      attr_names << options
      
      attr_names
    end
    
  end
end