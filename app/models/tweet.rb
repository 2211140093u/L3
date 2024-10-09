class Tweet < ApplicationRecord
  # メッセージが空でなく、140字以内
  validates :message, presence: true, length: { maximum: 140 }
end
