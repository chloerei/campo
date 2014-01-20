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

test 'should acitve reply-to button', ->
  $fixture = $('#qunit-fixture')
  $fixture.append("""
  <a data-post-reply-to="@user #1"></a>
  <div id="new_post">
    <textarea></textarea>
  </div>
  """)
  $fixture.find('a').trigger 'click'
  equal( $fixture.find('textarea').val(), '@user #1 ')
