class Band < ApplicationRecord
  belongs_to :event
  has_many :band_songs, dependent: :destroy
  has_many :band_members, dependent: :destroy

  accepts_nested_attributes_for :band_songs, :band_members
end
