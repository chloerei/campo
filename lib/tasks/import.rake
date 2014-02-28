desc "Import from code_campo"
task :import => [:environment, 'db:schema:load'] do
  db = Mongo::MongoClient.new['code_campo']

  puts 'Start import'

  user_map = {}
  db['users'].find.sort(created_at: :asc).each do |doc|
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
  puts "User: #{User.count}"

  topic_map = {}
  db['topics'].find.sort(created_at: :asc).each do |doc|
    topic = Topic.create!(id: doc['number_id'],
                          title: doc['title'],
                          body: doc['content'],
                          user_id: user_map[doc['user_id']],
                          created_at: doc['created_at'],
                          updated_at: doc['updated_at'])
    topic_map[doc['_id']] = topic.id
  end
  puts "Topic: #{Topic.count}"

  comment_map = {}
  db['replies'].find.sort(created_at: :asc).each do |doc|
    comment = Comment.create!(id: doc['number_id'],
                              body: doc['content'],
                              user_id: user_map[doc['user_id']],
                              commentable_type: 'Topic',
                              commentable_id: topic_map[doc['topic_id']],
                              created_at: doc['created_at'],
                              updated_at: doc['updated_at'])
    comment_map[doc['_id']] = comment.id
  end
  puts "Comment: #{Comment.count}"
end
