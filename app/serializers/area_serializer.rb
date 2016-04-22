class AreaSerializer < ActiveModel::Serializer
  has_many :weathers
  attributes :address
end
