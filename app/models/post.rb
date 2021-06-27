class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :categories, reject_if: :all_blank

  def categories_attributes=(category_attributes)
  
    category_attributes.values.each do |category_attribute|
      if category_attribute[:name].present?
        category = Category.find_or_create_by(category_attribute)
        if !self.categories.include?(category)
          self.post_categories.build(:category => category)
        end
      end
    end
  end

  def comment_attributes=(comment_attributes)
    comment_attributes.values.each do |comm_att|
      binding.pry
      comment = Comment.find_or_create_by(comm_att)
      self.comment_attributes.build(comment: comment)
    end
  end

end
