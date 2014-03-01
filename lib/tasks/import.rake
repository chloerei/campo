def reset_id_seq(model)
 ActiveRecord::Base.connection.execute(
     "ALTER SEQUENCE #{model.table_name}_id_seq RESTART WITH #{model.maximum(:id) + 1}"
 )
end

desc "Import from code_campo"
task :import => [:environment, 'db:schema:load'] do
  db = Mongo::MongoClient.new['code_campo']

  puts 'Start import'

  user_map = {}
  db['users'].find.sort(created_at: :asc).each_with_index do |doc, index|
    puts index if index % 50 == 0
    user = User.new(name: (doc['profile']['name'].present? ? doc['profile']['name'] : doc['name']),
                    username: doc['name'].gsub('_', '-'),
                    email: doc['email'],
                    password_digest: (doc['password_digest'] || User.new(password: SecureRandom.hex(16)).password_digest),
                    bio: doc['profile']['description'],
                    created_at: doc['created_at'],
                    updated_at: doc['created_at'])
    if user.save
      user_map[doc['_id']] = user.id
    else
      puts user.errors.inspect
      exit
    end

  end
  reset_id_seq User
  puts "User: #{User.count}"

  topic_map = {}
  Topic.import force: true
  db['topics'].find.sort(created_at: :asc).each_with_index do |doc, index|
    puts index if index % 50 == 0
    topic = Topic.create!(id: doc['number_id'],
                          title: doc['title'],
                          body: doc['content'],
                          user_id: user_map[doc['user_id']],
                          created_at: doc['created_at'],
                          updated_at: doc['updated_at'])
    topic_map[doc['_id']] = topic.id

    doc['marker_ids'].each do |id|
      topic.likes.create user_id: user_map[id]
    end
  end
  reset_id_seq Topic
  puts "Topic: #{Topic.count}"

  comment_map = {}
  db['replies'].find.sort(created_at: :asc).each_with_index do |doc, index|
    puts index if index % 50 == 0
    comment = Comment.create!(id: doc['number_id'],
                              body: doc['content'],
                              user_id: user_map[doc['user_id']],
                              commentable_type: 'Topic',
                              commentable_id: topic_map[doc['topic_id']],
                              created_at: doc['created_at'],
                              updated_at: doc['updated_at'])
    comment_map[doc['_id']] = comment.id
  end
  reset_id_seq Comment
  puts "Comment: #{Comment.count}"
end
