module Conversions
  module Distance
    module Miles
      module ToMetres
        def self.convert(miles)
          miles * 1609.344
        end
      end
    end
    module Metres
      module ToMiles
        def self.convert(metres)
          metres * 0.0006213
        end
      end
    end
  end
end
