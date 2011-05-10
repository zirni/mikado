module Mikado
  class Utility
    def self.is_ar_3?
      cmp_ar_version(3)
    end
    
    def self.is_ar_2?
      cmp_ar_version(2)
    end
    
    def self.ar_version
      ActiveRecord::VERSION::STRING
    end
    
    # MAJOR (, MINOR, TINY)
    def self.cmp_ar_version(major)
      ar_version =~ /#{major}\.\d+\.\d+/
    end
  end
end