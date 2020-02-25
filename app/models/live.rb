class Live < ApplicationRecord
  has_many :songs, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: {scope: :date}
  validates :date, presence: true

  default_scope { order(date: :desc) }

  def title
    "#{date.year} #{name}"
  end

  def Live.years
    Live.all.select(:date).map(&:nendo).uniq
  end

  def nendo
    if date.mon < 4
      date.year - 1
    else
      date.year
    end
  end
end
