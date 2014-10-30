class AddCounterCacheToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, default: 0, null: false

    Post.find_each(select: 'id') do |result|
      Post.reset_counters(result.id, :comments)
    end
  end
end
