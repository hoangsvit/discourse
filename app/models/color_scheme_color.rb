# frozen_string_literal: true

class ColorSchemeColor < ActiveRecord::Base
  belongs_to :color_scheme

  validates :hex, format: { with: /\A([0-9a-fA-F]{3}|[0-9a-fA-F]{6})\z/ }
  validates :dark_hex, format: { with: /\A([0-9a-fA-F]{3}|[0-9a-fA-F]{6})\z/ }, allow_nil: true

  def hex_with_hash
    "##{hex}"
  end
end

# == Schema Information
#
# Table name: color_scheme_colors
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  hex             :string           not null
#  color_scheme_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  dark_hex        :string(6)
#
# Indexes
#
#  index_color_scheme_colors_on_color_scheme_id  (color_scheme_id)
#
