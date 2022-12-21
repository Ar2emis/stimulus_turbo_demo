# frozen_string_literal: true

class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes, id: :uuid do |t|
      t.string :text, null: false

      t.timestamps
    end

    add_index :quotes, %[to_tsvector('simple', coalesce("quotes"."text"::text, ''))], using: :gist
  end
end
