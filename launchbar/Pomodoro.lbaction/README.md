# Pomodoro

Sometimes you need to trick your brain into getting things done. The [pomodoro
technique](https://en.wikipedia.org/wiki/Pomodoro_Technique) is one such method
for getting past the initial block we sometimes face when starting a task.

This LaunchBar action implements a pomodoro timer that displays a message in
large type when the pomodoro interval is over. The action comes with a default
message and a default interval of 15 minutes. These defaults can be changed in
the settings menu, and they can be overridden on a one-off basis.

**NB** The actions described below use **␣** to represent a `[space]`
character. So when you see **pomodoro ␣**, it means you type in the word
`pomodoro` followed by a `[space]` character to execute the action in LaunchBar.
The `[return]` character is represented as **↩︎**, and the `[cmd]` character is
represented as **⌘**.

## Usage

<dl>
  <dt>pomodoro ↩︎</dt>
  <dd>
    Start a default pomodoro. The default message will be shown at the end of
    the interval, and the default interval length will be used.
    <br/><br/>
    <img src="../images/pomodoro/pomodoro.png" width="400px"/>
  </dd>
  <dt>pomodoro ␣</dt>
  <dd>
    Start a custom pomodoro. You can type in a custom message to show at the end
    of the interval, and you can specify a custom interval length. If you omit
    either, then the default message or interval will be used.
    <br/><br/>
    <img src="../images/pomodoro/pomodoro-task.png" width="400px"/>
  </dd>
  <dt>pomodoro ⌘↩︎</dt>
  <dd>
    Show the default pomodoro settings.
    <br/><br/>
    <img src="../images/pomodoro/pomodoro-settings.png" width="400px"/>
  </dd>
</dl>


## Settings

The default settings can be changed using the "bang" commands listed below. You
enter these commands in the "Pomodoro Task" entry area which is accessed by
pressing `[space]` after bringing up the pomodoro LaunchBar action - **pomodoro ␣**.

When a default setting is changed, LaunchBar will show a notification letting
you know that the change has been applied. You can pull up the default settings
**pomodoro ⌘↩︎** and see the changes there, too.

<dl>
  <dt>pomodoro ␣ !interval 15min</dt>
  <dd>
    Change the default pomodoro interval. The interval can be given in hours,
    minutes, and seconds. The string "12m 30s" would be interpreted as a twelve
    and a half minute pomodor interval.

    <ul>
      <li>hours - <code>h</code></li>
      <li>minutes - <code>min</code> or <code>m</code></li>
      <li>seconds - <code>sec</code> or <code>s</code></li>
    </ul>

    <img src="../images/pomodoro/pomodoro-interval.png" width="400px"/>
  </dd>
  <dt>pomodoro ␣ !message Your pomodoro is done!</dt>
  <dd>
    Change the default pomodoro message. This message will be displayed in large
    type at the end of the pomodoro interval if no other message is given.
    <br/><br/>
    <img src="../images/pomodoro/pomodoro-message.png" width="400px"/>
  </dd>
  <dt>pomodoro ␣ !sound Glass</dt>
  <dd>
    Change the default pomodoro sound. This sound will be played at the end of
    the pomodoro interval. You can also navigate to the "Sound" menu after
    pulling up the settings, and select the default sound that way.
    <br/><br/>
    <img src="../images/pomodoro/pomodoro-settings-sound.png" width="400px"/>
    <br/><br/>
    <img src="../images/pomodoro/pomodoro-sounds.png" width="400px"/>
  </dd>
</dl>

## History

The pomodoro action keeps track of the last 10 pomodoros. You can view this list
under the "History" section of the pomodoro settings. If you highlight one of
the pomodoros in the history list and hit `[return]`, it will start another
pomodoro interval using the historical message.

<img src="../images/pomodoro/pomodoro-history.png" width="400px"/>

If you start a pomodoro using the default message, it will not appear in the
history list. If you repeat a pomodoro from the history list, it will be moved
to the top of the history. This prevents duplicate pomodoros from appearing in
the history list.
