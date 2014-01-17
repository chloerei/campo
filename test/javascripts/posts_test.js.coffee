module('Posts')

test 'should update votes', ->
  $fixture = $('#qunit-fixture')
  $('#qunit-fixture').append("
  <ul>
    <li id='post_1'>
      <a class='post-vote-up' data-method='put'></a>
      <a class='post-vote-down' data-method='put'></a>
    </li>
    <li id='post_2'>
      <a class='post-vote-up' data-method='put'></a>
      <a class='post-vote-down' data-method='put'></a>
    </li>
    <li id='post_3'>
      <a class='post-vote-up' data-method='put'></a>
      <a class='post-vote-down' data-method='put'></a>
    </li>
  </ul
  ")

  campo.Posts.updateVotes([
    { post_id: 1, type: 'up' }
    { post_id: 2, type: 'down' }
  ])

  equal( $fixture.find('#post_1 .post-vote-up').data('method'), 'delete' )
  equal( $fixture.find('#post_2 .post-vote-down').data('method'), 'delete' )
  equal( $fixture.find('#post_3 .post-vote-down').data('method'), 'put' )
