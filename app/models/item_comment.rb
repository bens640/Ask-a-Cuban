class ItemComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, counter_cache: :comments_count
  validates_presence_of :user_id, :item_id, :content

  def as_json(options = {})
    super(include: {item: {only: :content}, user: {only: :username}})

  end

end
