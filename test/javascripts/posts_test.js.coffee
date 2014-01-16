module('posts_test')

test 'should update votes', ->
  $fixture = $('#qunit-fixture')
  $('#qunit-fixture').append("
  <ul>
    <li data-post-id='1'></li>
    <li data-post-id='2'></li>
    <li data-post-id='3'></li>
  </ul
  ")

  Post.updateVotes([
    { post_id: 1, value: 'up' }
    { post_id: 2, value: 'down' }
  ])

  equal( 'up', $fixture.find('[data-post-id=1]').data('post-vote') )
  equal( 'down', $fixture.find('[data-post-id=2]').data('post-vote') )
  equal( null, $fixture.find('[data-post-id=3]').data('post-vote') )
