class Item < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :votable
  has_many :comments, class_name: "ItemComment"
  default_scope {order('created_at desc')}

  validates :title, presence: true, length: { maximum: 250 }, allow_blank: false, allow_nil: false
  validates :id, uniqueness: true




  scope :active, -> { where(disabled: false) }
  scope :disabled, -> { where(disabled: true) }
  scope :newest, -> { order(score: :desc) }


  # def check_comments(arr, comments)
  #   if self.updated_comments_count > 0
  #        arr << comments.first(self.updated_comments_count)
  #     save!
  #   elsif self.updated_comments_count == 0
  #     self.updated_comments_count = 0
  #   end
  # end


  def as_json(options = {})
    super({include:  {user: {only: :username}}}.merge(options))
  end


end
