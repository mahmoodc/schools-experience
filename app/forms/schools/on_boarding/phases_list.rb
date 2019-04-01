module Schools
  module OnBoarding
    class PhasesList
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :primary, :boolean
      attribute :secondary, :boolean
      attribute :college, :boolean

      def ==(other)
        other.respond_to?(:attributes) && other.attributes == self.attributes
      end
    end
  end
end
