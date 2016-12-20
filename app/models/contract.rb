class Contract < ApplicationRecord
  validates :title, presence: true
  validates :link, presence: true
  validates :owner_link, presence: true
  validates :user_id, presence: true

  has_many :decisions
  belongs_to :user

  def owner?(user_id)
    self.user_id == user_id
  end

  def self.find_which_by(params)
    Contract.find_by_link(params) || Contract.find_by_owner_link(params)
  end

  def find_or_set_owner(hash_link, user_id)
    if hash_link == self.owner_link
      return true
    else
      return self.owner?(user_id)
    end
  end

  def self.find_by_link(params)
    Contract.find_by(id: params[:id], link: params[:link])
  end

  def self.find_by_owner_link(params)
    Contract.find_by(id: params[:id], owner_link: params[:link])
  end

end
