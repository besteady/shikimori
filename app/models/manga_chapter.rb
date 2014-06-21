class MangaChapter < ActiveRecord::Base
  belongs_to :manga
  has_many :pages, -> { order :number }, class_name: 'MangaPage', dependent: :destroy

  validates :name, presence: true
  validates :url, presence: true, url: true, uniqueness: true
end
