class Item < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :votable
  has_many :comments, class_name: "ItemComment"
  default_scope {order('created_at ASC')}

  validates :title, presence: true, length: { maximum: 250 }, allow_blank: false, allow_nil: false
  validates :id, uniqueness: true

  validate do
    if content.blank? && url.blank?
      errors.add(:url, 'Submit a URL or Content')
    end
    if content.present? && url.present?
      errors.add(:url, 'Submit a URL or Content but not Both.')
    end
  end
  validates :url, url: {allow_nil: true, allow_blank: true}


  scope :active, -> { where(disabled: false) }
  scope :disabled, -> { where(disabled: true) }
  scope :newest, -> { order(score: :desc) }


  def check_comments(arr, comments)
    if self.updated_comments_count > 0
         arr << comments.first(self.updated_comments_count)
      save!
    elsif self.updated_comments_count == 0
      self.updated_comments_count = 0
    end
  end


  def as_json(options = {})
    super({include:  {user: {only: :username}}}.merge(options))
  end


end
