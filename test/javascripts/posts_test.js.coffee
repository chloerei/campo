module('Posts')

test 'should update votes', ->
  $fixture = $('#qunit-fixture')
  $('#qunit-fixture').append("
  <ul>
    <li data-post-id='1'></li>
    <li data-post-id='2'></li>
    <li data-post-id='3'></li>
  </ul
  ")

  campo.Posts.updateVotes([
    { post_id: 1, type: 'up' }
    { post_id: 2, type: 'down' }
  ])

  equal( 'up', $fixture.find('[data-post-id=1]').data('post-voted') )
  equal( 'down', $fixture.find('[data-post-id=2]').data('post-voted') )
  equal( null, $fixture.find('[data-post-id=3]').data('post-voted') )
