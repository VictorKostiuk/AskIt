# frozen_string_literal: true

class Question < ApplicationRecord
  include Commentable
  include Authorship

  has_many :answers, dependent: :destroy
  belongs_to :user

  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }

  def formatted_created_at
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  scope :all_by_tags, lambda { |tag_ids|
    questions = includes(:user, :question_tags, :tags)
    questions = questions.joins(:tags).where(tags: tag_ids) if tag_ids
    questions.order(created_at: :desc)
  }
end
