module('posts_test')

test 'should update votes', ->
  $fixture = $('#qunit-fixture')
  $('#qunit-fixture').append("
  <ul>
    <li data-post-id='1' data-behavior='post-voteable'>
      <a data-post-vote='up'></a>
      <a data-post-vote='down'></a>
    </li>
    <li data-post-id='2' data-behavior='post-voteable'>
      <a data-post-vote='up'></a>
      <a data-post-vote='down'></a>
    </li>
    <li data-post-id='3' data-behavior='post-voteable'>
      <a data-post-vote='up'></a>
      <a data-post-vote='down'></a>
    </li>
  </ul
  ")

  Post.updateVotes(
    1: 'up',
    2: 'down'
  )

  equal( 'up', $fixture.find('[data-post-id=1]').data('post-vote') )
  equal( 'down', $fixture.find('[data-post-id=2]').data('post-vote') )
  equal( null, $fixture.find('[data-post-id=3]').data('post-vote') )
