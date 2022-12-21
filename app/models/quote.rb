# frozen_string_literal: true

class Quote < ApplicationRecord
  include PgSearch::Model

  MAX_QUOTE_LENGTH = 255
  ORDER_TYPES = {
    'A-Z': { text: :asc },
    'Z-A': { text: :desc },
    Newest: { created_at: :asc },
    Oldest: { created_at: :desc }
  }.freeze

  validates :text, presence: true, length: { maximum: MAX_QUOTE_LENGTH }

  pg_search_scope :search_by_text, against: :text, using: :tsearch
end
